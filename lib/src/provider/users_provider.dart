//realizaremos la consulta de la peticion http
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:delivery_lee/src/api/enviroment.dart';
import 'package:delivery_lee/src/models/response_api.dart';
import 'package:delivery_lee/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersProvider{
  //realizamos la llamda al enviroment
   String _url = Enviroment.API_DELIVERY;
  //Aqui realizaremos la ruta de peticion de los usuarios
  String _api = '/api/users';

  BuildContext? context;

  Future? init(BuildContext context){
    this.context = context;
  }

  //aqui nos devolera los datos
  Future<User> getById(String id) async{
    try {
      //nos creamos la url
      Uri url = Uri.http(_url, '$_api/findById/$id');

      //mapa de headers
      Map<String, String> headers = {
        'Content-type':'application/json'
      };
      //Hago la peticion gete
      final res = await http.get(url,headers: headers);
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      throw Exception();
    }
  }

   Future<Stream> createWithimage(User user, File image) async{
     try {
       Uri url = Uri.http(_url, '$_api/create');
       final request = http.MultipartRequest('POST',url);
       if (image != null) {
         request.files.add(http.MultipartFile(
           'image',
         http.ByteStream(image.openRead().cast()),
         await image.length(),
         filename: basename(image.path)
         ));
       }
       request.fields['user'] = json.encode(user);
       final response = await request.send();//enviamos la peticion
       return response.stream.transform(utf8.decoder);
     } catch (e) {
       print('Erro: $e');
       throw Exception();
     }
   }

    Future<Stream> update(User user, File image) async{
     try {
       Uri url = Uri.http(_url, '$_api/update');
       final request = http.MultipartRequest('PUT',url);
       if (image != null) {
         request.files.add(http.MultipartFile(
           'image',
         http.ByteStream(image.openRead().cast()),
         await image.length(),
         filename: basename(image.path)
         ));
       }
       request.fields['user'] = json.encode(user);
       final response = await request.send();//enviamos la peticion
       return response.stream.transform(utf8.decoder);
     } catch (e) {
       print('Erro: $e');
       throw Exception();
     }
   }


   Future<ResponseApi> create(User user)async {
    try {
      // realizamos la peticion http
      Uri url = Uri.http(_url, '$_api/create');
      // pasaremos nuestro usuario
      String bodyParams =  json.encode(user);
      Map<String, String> headers= {
        'Content-type':'application/json'
      };
      final res = await http.post(url,headers: headers,body: bodyParams);
      // almacenamos la respuesta
      final data = json.decode(res.body);
      // mapa de valores
      ResponseApi responseApi = ResponseApi.fromJson(data);

      return responseApi;
      
    } catch (e) {
      print('Error $e');
      throw Exception;
      // return ;
    }
  }
  

  Future<ResponseApi> login(String email,String password)async{
      try {
        Uri url = Uri.http(_url, '$_api/login');
        String bodyParams = json.encode({
          'email':email,
          'password':password
        });
        Map<String,String> headers={
          'Content-type':'application/json'
        };
        final res = await http.post(url,headers: headers,body: bodyParams);
        final data = json.decode(res.body);
        ResponseApi responseApi= ResponseApi.fromJson(data);
        return responseApi;
        
      } catch (e) {
        print('Error : $e');
        throw Exception;
      }
  }
}