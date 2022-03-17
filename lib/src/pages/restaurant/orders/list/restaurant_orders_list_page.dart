import 'package:delivery_lee/src/pages/restaurant/orders/list/restaurant_orders_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class RestaurantOrdersListPage extends StatefulWidget {

  @override
  State<RestaurantOrdersListPage> createState() => _RestaurantOrdersListPageState();
}

class _RestaurantOrdersListPageState extends State<RestaurantOrdersListPage> {
  RestauranteOrdersListController _con = RestauranteOrdersListController();

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
      key: _con.key,
      appBar: AppBar(
        backgroundColor: Colors.red[100],
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
       body:const Center(
         child: Text('Restaurant page'),
       ),
    );
}
Widget _menuDrawer(){
  return GestureDetector(
    onTap: _con.openDrawer,
    child: Container(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/img/menu_icon.png'),
    ),
  );
}
Widget _drawer(){
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.red[100]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                 margin:const EdgeInsets.only(top:15),
                 child: Text(
                   '${_con.user?.name ?? ''} ${_con.user?.lastname ??''}',
                 style:const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold
              ) ,
              maxLines: 1,
              ),
               ),
             Container(
                 margin:const EdgeInsets.only(top:5),
              child: Text(
                _con.user?.email?? '',
                style:const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic
                ) ,
                maxLines: 1,
                ),
              ),
              Container(
                 margin:const EdgeInsets.only(top:5),
                 child: Text(
                   _con.user?.phone??'',
                  style:const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ) ,
                  maxLines: 1,
                  ),
              ),
              Container(
                 margin:const EdgeInsets.only(top:5),
                height: 60,
                child:FadeInImage(
                  image:_con.user?.image != null
                  ? NetworkImage(_con.user!.image!)
                  : const AssetImage('assets/img/persona.jpg') as ImageProvider,
                  placeholder:const AssetImage('assets/img/no-image.png'),
                  fadeInDuration:const Duration(milliseconds: 50),
                ),
              )

            ],
          )
          ),
          const ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
          ),
          _con.user != null ?
          _con.user!.roles!.length > 1?
           ListTile(
             onTap: _con.goToRoles,
            title:const Text('Selecionar rol'),
            trailing:const Icon(Icons.person_outline),
          ):Container():Container(),
           ListTile(
            onTap:_con.logout,
            title:const Text('Cerrar Sesion'),
            trailing:const Icon(Icons.power_settings_new_outlined),
          ),


      ],
    ),
  );
}
void refresh(){
  setState(() {
  });
}

}