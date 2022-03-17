import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  //creamos nuestro metodo de almacenamiento
  void save(String key, value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  //nos creamos nuestro metodo de leer los valoes almacenados
  Future<dynamic> read(String key) async{
    final prefs= await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) return null;
    return json.decode(prefs.getString(key)!);
  }

  //para saber si existe algun otro dato
  Future<bool> contains(String key)async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  //para elimar el dato de shred preference
  Future<bool> remove(String key)async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  //nos creamos un metodo logout
  void logout( BuildContext context) async{
    await remove('user');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}