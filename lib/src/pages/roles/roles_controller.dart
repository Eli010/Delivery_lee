import 'package:flutter/material.dart';

import 'package:delivery_lee/src/utils/shared_pref.dart';
import 'package:delivery_lee/src/models/user.dart';

class RolesController{

  BuildContext? context;
  Function? refresh;
  User? user;
  SharedPref sharedPref = SharedPref();

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;

    //aqui obtenemos el usuario
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
  }
  void goToPage(String route){
    Navigator.pushNamedAndRemoveUntil(context!, route, (route) => false);
  }
}