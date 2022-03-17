
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'package:delivery_lee/src/models/response_api.dart';
import 'package:delivery_lee/src/models/user.dart';
import 'package:delivery_lee/src/provider/users_provider.dart';
import 'package:delivery_lee/src/utils/my_snackbar.dart';

class RegisterController {

   BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;
  ProgressDialog? _progressDialog;
  bool isEnable = true;

  Future? init(BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
  }

  void register()async{
      String email = emailController.text.trim();
      String name = nameController.text;
      String lastname = lastNameController.text;
      String phone = phoneController.text;
      String password = passwordController.text.trim();
      String confirmPassword = passwordConfirmController.text.trim();

      //aqui pediremos que los usuarios ingresen todo los campos
      if(email.isEmpty || name.isEmpty|| lastname.isEmpty|| phone.isEmpty|| password.isEmpty|| confirmPassword.isEmpty){
        MySnackbar.show( context!, 'debes ingresar todos los campos');
        return;
      }

      if(confirmPassword != password){
        MySnackbar.show( context!, 'las contraseñas no coinciden');
        return;
      }

      if(password.length<6){
        MySnackbar.show( context!, 'debe tener mas de 6 caracteres');
        return;
      }

      if (imageFile == null) {
        MySnackbar.show(context!, 'Selecciona una imagen');
        return;
      }

      _progressDialog!.show(max: 100, msg: 'Espere un momento ...');
      isEnable = false;
      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password
      );

      Stream stream = await usersProvider.createWithimage(user, imageFile!);
      stream.listen((res) {
        _progressDialog!.close();
        // ResponseApi responseApi = await usersProvider.create(user);
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
         print('Respuesta: ${responseApi.toJson()}');
         MySnackbar.show(context!, responseApi.message!);
         
        if (responseApi.success!) {
          Future.delayed(const Duration(seconds: 3),(){
            Navigator.pushReplacementNamed(context!, 'login');
          });
        }else{
          isEnable = true;
        }

       });


      print('email: $email');
      print('name: $name');
      print('lastName: $lastname');
      print('phone: $phone');
      print('password: $password');
      print('confirmPassword: $confirmPassword');
  }
  Future selectImage(ImageSource imageSource)async{
    // ignore: deprecated_member_use
    pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile!.path);
    }
    Navigator.pop(context!);
    refresh!();
  }
    void showAlertDialog(){
      Widget galleryButton = ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.gallery);
        }, 
        child: Text('GALERIA'),
        );
      Widget cameraButton = ElevatedButton(
        onPressed: (){
          selectImage(ImageSource.camera);
        }, 
        child:const Text('CAMARA'),
      );
      AlertDialog alertDialog = AlertDialog(
        title:const Text('Selecione su imagen'),
        actions: [
          galleryButton,
          cameraButton
        ],
      );
      showDialog(
        context:context!,
        builder:(BuildContext context){
          return alertDialog;
        },
      );
    }
    void back(){
    Navigator.pop(context!);
  }
  
}