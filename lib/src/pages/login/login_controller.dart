
import 'package:delivery_lee/src/models/response_api.dart';
import 'package:delivery_lee/src/models/user.dart';
import 'package:delivery_lee/src/provider/users_provider.dart';
import 'package:delivery_lee/src/utils/my_snackbar.dart';
import 'package:delivery_lee/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class LoginController{

  BuildContext? context ;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  //creamos nuestra variable de tipo ShredPrefences
  SharedPref _sharedPref =  SharedPref();

  Future? init(BuildContext context) async{
    this.context = context;

    await usersProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user')??{});
    if (user.sessionToken != null) {
      if (user.roles!.length >1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context,user.roles![0].route!, (route) => false);
      }  

      // Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
      print('Rspuesta: ${user.toJson()}');
    }
  }

  void goToRegisterPage(BuildContext context){
    Navigator.pushNamed( context, 'register');
  }

  //con estos datos capturamos los valores de nuestros textfiel
  //el trim()= sirve para que no reconozca espacio en blanco
  //este es un metodo para usar en el login de ingreso
  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email,password);
    print('Email: $email');
    print('password: $password');

    
    //aqui comprobamos si inicio sesion o no
    if (responseApi.success!) {
      User user = User.fromJson(responseApi.data);
      //esta es la llave 
      _sharedPref.save('user', user.toJson());
      print('Usuario logeado: ${user.toJson()}');
      if (user.roles!.length >1) {
        Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context!,user.roles![0].route!, (route) => false);
      }  
      //El pushnamedAndUntill borra todos los datos atras de todas las paginas
      // Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);
    }else{
    MySnackbar.show(context!,responseApi.message!);
    }
    print('Respuesta: ${responseApi.toJson()}');
  }

}