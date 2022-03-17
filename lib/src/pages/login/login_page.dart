import 'package:delivery_lee/src/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final LoginController _con =  LoginController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      print('schuduler');
      _con.init(context);
    });
  }
@override
Widget build(BuildContext context) {
  print('sacsfold');
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // _lottieAnimation(),
            Positioned(
              top: -70,
              left: -80,
              child: _circleLogin()
              ),

            SingleChildScrollView(
              child: Column(
                children: [
                  // _lottieAnimation(),
                  _imageBanner(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _botonLogin(),
                  _textDontHaveAccount()
                ],
              ),
            ),
          ],
        ),
      ),
    );

    }

    Widget _lottieAnimation(){
      return Container(
         margin: const EdgeInsets.only(top: 80,
        // bottom:MediaQuery.of(context).size.height * 0.10, 
        ),
        child: Lottie.asset('assets/json/sunset.json',
        width: double.infinity,
        height: 300
        )
        );
    }
    Widget _imageBanner(){
      return  Stack(
        children: [
          _lottieAnimation(),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.27,
            bottom:MediaQuery.of(context).size.height * 0.10, left: 100
            ),
            child: Image.asset('assets/img/deliveryGirls.png',
                  width: 150,
                  height: 150,
                   ),
          ),
        ],
      );
    }

    Widget _textFieldEmail(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50,vertical: 15 ),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          controller: _con.emailController,
          keyboardType: TextInputType.emailAddress,
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
        Widget _textFieldPassword(){
      return  Container(
        width: double.infinity,
        margin:const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(30)
        ),
        child:  TextField(
          controller: _con.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Contraseña',
            hintStyle: TextStyle(color:Colors.orange[800]),
            border: InputBorder.none,
            contentPadding:const EdgeInsets.all(15),
            prefixIcon: Icon(Icons.lock,color: Colors.orange[800])
          ),
        ),
      );
    }
    Widget _botonLogin(){
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
          child:const Text('INGRESAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ) ,),
          onPressed:_con.login ,
          ),
      );
    }
    Widget _textDontHaveAccount(){
      return Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿No tienes cuenta? ',
            style:TextStyle(
              color: Colors.orange[800]
            ) 
            ),
            GestureDetector(
              onTap: (){
              _con.goToRegisterPage(context);
              },
              child: Text(' Registrate',
                style:TextStyle(
                color: Colors.orange[800],
                fontWeight: FontWeight.bold
              ) 
              ),
            ),
          ],
        ) ,
      );
    }

    Widget _circleLogin(){
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.orange[800],
          borderRadius: BorderRadius.circular(90)
        ),
        child:  Center(
          
          child: Container(
            margin: const EdgeInsets.only(top: 100,left: 60),
            child:const  Text('LOGIN',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontFamily: 'ageta-chubby'
            ),
        ),
          ),),
      );
    }
}