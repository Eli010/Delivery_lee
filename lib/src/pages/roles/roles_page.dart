import 'package:delivery_lee/src/models/rol.dart';
import 'package:delivery_lee/src/pages/roles/roles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class RolesPage extends StatefulWidget {

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _con = RolesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context,refresh);
    });
  }
@override
Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title:const Text('Seleccione su rol:'),
      ),
       body: Container(
         margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.10),
         child: ListView(
           children: _con.user != null ? _con.user!.roles!.map((Rol rol){
             return _cardRol(rol);
           }).toList():[],
         ),
       )
    );
}

Widget _cardRol(Rol rol){
  return GestureDetector(
    onTap: (){
        _con.goToPage(rol.route!);
    },
    child: Column(
      children: [
        Container(
          height: 100,
          margin:const EdgeInsets.only(top: 20),
          child: FadeInImage(
            image: rol.image != null? NetworkImage(rol.image!)
            :const  AssetImage('assets/img/no-image.png') as ImageProvider,
            fit:BoxFit.contain,
            fadeInDuration:const Duration(milliseconds: 50),
            placeholder:const AssetImage('assets/img/no-image.png'),
             ),
        ),
        Text(
          // rol.name != null ? rol.name:'',
          rol.name ?? '',
          style:const TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
          )
      ],
    ),
  );
}
void refresh(){
  setState(() {});
}
}