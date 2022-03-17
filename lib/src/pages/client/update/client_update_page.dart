import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';

import 'package:delivery_lee/src/pages/client/update/client_update_controller.dart';

class ClientUpdatePage extends StatefulWidget {

  @override
  State<ClientUpdatePage> createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {

   ClientUpdateController _con = ClientUpdateController();

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) { 
      _con.init(context,refresh);
    });
  }

@override
Widget build(BuildContext context) {

    return  Scaffold(
       appBar: AppBar(
         title:const Text('Editar perfil'),
         backgroundColor: Colors.orange[800],
       ),
       body:  SingleChildScrollView(
         child: Container(
           margin: const EdgeInsets.only(top:120),
           width: double.infinity,
           child: Column(
             children: [
               _perfilUser(),
               _textFieldName(),
               _textFieldLastName(),
               _textFieldPhone(),
             ],
           ),
         ),
       ),
       bottomNavigationBar: _botonUpdatePerfil(),
    );
}

     Widget _botonUpdatePerfil(){
      return Container(
        width: double.infinity,
        height: 45,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 15 ),
        // decoration: BoxDecoration(
          // color: Colors.orange[800]
        // ),
        child: ElevatedButton(
          style:ElevatedButton.styleFrom(
            primary: Colors.orange[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            )
          ),
          child:const Text('ACTUALIZAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ) ,),
          onPressed:_con.isEnable? _con.update:null ,
          ),
      );
    }

      Widget _textFieldName(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 10 ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          keyboardType: TextInputType.name,
          controller: _con.nameController,
          decoration: InputDecoration(
            hintText: 'Nombre',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person,color: Colors.orange[800]),
          ),
        ),
      );
    }

          Widget _textFieldLastName(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 10 ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          keyboardType: TextInputType.name,
          controller: _con.lastNameController,
          decoration: InputDecoration(
            hintText: 'Apellidos',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.person,color: Colors.orange[800]),
          ),
        ),
      );
    }

          Widget _textFieldPhone(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 10 ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          keyboardType: TextInputType.phone,
          controller: _con.phoneController,
          decoration: InputDecoration(
            hintText: 'Telefono',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.phone ,color: Colors.orange[800]),
          ),
        ),
      );
    }



  Widget _perfilUser(){
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
        ? FileImage(_con.imageFile!)
        : _con.user?.image != null
        ?NetworkImage(_con.user!.image!)
        :const AssetImage('assets/img/addperson.jpg')as ImageProvider ,
        radius: 60,
      ),
    );
  }


  void refresh(){
    setState(() {
    });
  }
}