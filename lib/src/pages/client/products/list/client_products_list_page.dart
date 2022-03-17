import 'package:delivery_lee/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class ClientProductsListPage extends StatefulWidget {

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {

  ClientProductsListController _con = ClientProductsListController();

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
        backgroundColor: Colors.orange[800],
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
       body:const Center(
         child: Text('bienvenido a cliente page'),
       ),
    );
}
Widget _menuDrawer(){
  return GestureDetector(
    onTap: _con.openDrawer,
    child: Container(
      alignment: Alignment.centerLeft,
      child: Image.asset('assets/img/menu_icon.png',color: Colors.white),
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
            color: Colors.orange[800]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                 margin:const EdgeInsets.only(top:15),
                 child: Text(
                   '${_con.user?.name ?? ''} ${ _con.user?.lastname ?? ''} ',
                 style:const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ) ,
              maxLines: 1,
              ),
               ),
             Container(
                 margin:const EdgeInsets.only(top:5),
              child: Text(
                _con.user?.email ?? '',
                style:  TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[350],
                  fontStyle: FontStyle.italic
                ) ,
                maxLines: 1,
                ),
              ),
              Container(
                 margin:const EdgeInsets.only(top:5),
                 child: Text(
                   _con.user?.phone??'',
                  style:TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[350]
                  ) ,
                  maxLines: 1,
                  ),
              ),
              Container(
                height: 60,
                child: FadeInImage(
                  image:_con.user?.image != null 
                  ? NetworkImage(_con.user!.image!)
                  : const AssetImage('assets/img/persona.jpg') as ImageProvider,
                  placeholder:const AssetImage('assets/img/no-image.png'),
                  fadeInDuration:const Duration(milliseconds: 50),
                  fit: BoxFit.cover,
                ),
              )

            ],
          )
          ),
          ListTile(
            onTap: _con.goToUpdatePage,
            title:const Text('Editar Perfil'),
            trailing:const Icon(Icons.edit_outlined),
          ),
          const ListTile(
            title: Text('Mis Pedidos'),
            trailing: Icon(Icons.shopping_cart)
          ),
          _con.user != null ?
          _con.user!.roles!.length >1?
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
  setState(() {});
}
}