import 'package:delivery_lee/src/pages/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

   RegisterController _con = RegisterController();

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
       body:  Stack(
         children: [
           Positioned(
             top: -50,
             left: -60,
             child: _circle()
             ),
           SingleChildScrollView(
             child: Container(
               margin: const EdgeInsets.only(top:120),
               width: double.infinity,
               child: Column(
                 children: [
                   _perfilUser(),
                   _textFieldEmail(),
                   _textFieldName(),
                   _textFieldLastName(),
                   _textFieldPhone(),
                   _textFieldPassword(),
                   _textFieldPasswordConfirm(),
                   _botonRegister()
                 ],
               ),
             ),
           ),
            //  _iconReturnDos(), 
             Positioned(
             top: 52,
             left: -5,
             child: _iconReturn()
             ),  

         ],
       ),
    );
}

     Widget _botonRegister(){
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
          child:const Text('REGISTRARSE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ) ,),
          onPressed:_con.isEnable? _con.register:null ,
          ),
      );
    }

      Widget _textFieldEmail(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.only(left: 50,right: 50,top:25,bottom: 5),

        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _con.emailController,
          decoration: InputDecoration(
            hintText: 'Correo electronico',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.email,color: Colors.orange[800]),
          ),
        ),
      );
    }

      Widget _textFieldName(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 5 ),
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
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 5 ),
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
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 5 ),
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

          Widget _textFieldPassword(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 5 ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          keyboardType: TextInputType.visiblePassword,
          controller: _con.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.lock ,color: Colors.orange[800]),
          ),
        ),
      );
    }

          Widget _textFieldPasswordConfirm(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 5 ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          controller: _con.passwordConfirmController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Confirmar contraseña',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.lock,color: Colors.orange[800]),
          ),
        ),
      );
    }

  Widget _perfilUser(){
    return GestureDetector(
      onTap: _con.showAlertDialog,
      child: CircleAvatar(
        backgroundImage: _con.imageFile != null
        ? FileImage(_con.imageFile!):const AssetImage('assets/img/addperson.jpg')as ImageProvider ,
        radius: 60,
      ),
    );
  }

  Widget _circle(){
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.orange[800],
        borderRadius: BorderRadius.circular(90)
      ),
      child: Container(
        padding:const EdgeInsets.only(top:110,left: 85 ),
        child: const Text('REGISTRO',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'ageta-chubby'
        ),
        ),
      ),
    );
  }

  Widget _iconReturn(){
    return IconButton(
      onPressed:_con.back,
       icon:const Icon(Icons.arrow_back_ios),
       iconSize: 23,
       color: Colors.white,
       );
  }
  void refresh(){
    setState(() {
    });
  }
}