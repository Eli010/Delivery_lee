import 'package:delivery_lee/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_lee/src/pages/client/update/client_update_page.dart';
import 'package:delivery_lee/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_lee/src/pages/login/login_page.dart';
import 'package:delivery_lee/src/pages/register/register_page.dart';
import 'package:delivery_lee/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_lee/src/pages/roles/roles_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      // theme: ThemeData(primaryColor: Colors.amber),
      debugShowCheckedModeBanner: false,
      title: 'Delivery App Lee',  
      initialRoute: 'login',
      routes: {
        'login' :  (BuildContext context)=> LoginPage(),
        'register':(BuildContext context) => RegisterPage(),
        'roles':(BuildContext context) => RolesPage(),
        'client/products/list':(BuildContext context)=> ClientProductsListPage(),
        'client/update':(BuildContext context)=> ClientUpdatePage(),
        'delivery/order/list':(BuildContext context)=> DeliveryOrdersListPage(),
        'restaurant/order/list':(BuildContext context)=> RestaurantOrdersListPage()
      },
    );
  }
}