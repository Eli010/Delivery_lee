
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import 'package:delivery_lee/src/utils/shared_pref.dart';
import 'package:delivery_lee/src/models/response_api.dart';
import 'package:delivery_lee/src/models/user.dart';
import 'package:delivery_lee/src/provider/users_provider.dart';
import 'package:delivery_lee/src/utils/my_snackbar.dart';

class ClientUpdateController {

   BuildContext? context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;
  ProgressDialog? _progressDialog;
  bool isEnable = true;
  User? user;
  SharedPref _sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
    user=User.fromJson(await _sharedPref.read('user'));
    nameController.text = user!.name!;
    lastNameController.text = user!.lastname!;
    phoneController.text = user!.phone!;
    refresh();
  }

  void update()async{
      String name = nameController.text;
      String lastname = lastNameController.text;
      String phone = phoneController.text;

      //aqui pediremos que los usuarios ingresen todo los campos
      if(name.isEmpty|| lastname.isEmpty|| phone.isEmpty){
        MySnackbar.show( context!, 'debes ingresar todos los campos');
        return;
      }


      if (imageFile == null) {
        MySnackbar.show(context!, 'Selecciona una imagen');
        return;
      }

      _progressDialog!.show(max: 100, msg: 'Espere un momento ...');
      isEnable = false;
      User myUser = User(
        id: user!.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user?.image
      );

      Stream stream = await usersProvider.update(myUser, imageFile!);
      stream.listen((res)  async{
        _progressDialog!.close();
        
        // ResponseApi responseApi = await usersProvider.create(user);
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
         print('Respuesta: ${responseApi.toJson()}');
        //  MySnackbar.show(context!, responseApi.message!);
        Fluttertoast.showToast(msg: responseApi.message!);
         
        if (responseApi.success!) {
          user = await usersProvider.getById(myUser.id!); // aqui obtenemos el usuario
            
            print('Usuario obtenido: ${user!.toJson()}');

          _sharedPref.save('user', user!.toJson());
          Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);
        }else{
          isEnable = true;
        }

       });


      print('name: $name');
      print('lastName: $lastname');
      print('phone: $phone');
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