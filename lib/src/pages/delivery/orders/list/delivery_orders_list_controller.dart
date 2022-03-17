import 'package:delivery_lee/src/models/user.dart';
import 'package:delivery_lee/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class DeliveryOrdersListController{

  BuildContext? context;
  SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson( await _sharedPref.read('user'));
    refresh();
  }

  void logout(){
    _sharedPref.logout(context!);
  }

  void openDrawer(){
    key.currentState!.openDrawer();
  }
  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }
}