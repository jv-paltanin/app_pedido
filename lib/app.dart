import 'package:app_pedido/features/customers/pages/customers/presenter/customer_page.dart';
import 'package:app_pedido/features/customers/services/customer_service.dart';
import 'package:app_pedido/features/customers/stores/customer_store.dart';
import 'package:app_pedido/features/order/pages/orders/presenter/order_page.dart';
import 'package:app_pedido/features/order/services/order_service.dart';
import 'package:app_pedido/features/order/stores/order_store.dart';
import 'package:app_pedido/features/products/pages/products/presenter/product_page.dart';
import 'package:app_pedido/features/products/services/product_service.dart';
import 'package:app_pedido/features/products/stores/product_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Dio()),
        Provider(create: (context) => CustomerService(context.read())),
        Provider(create: (context) => ProductService(context.read())),
        Provider(create: (context) => OrderService(context.read())),
        ChangeNotifierProvider(create: (context) => CustomerStore(context.read())),
        ChangeNotifierProvider(create: (context) => ProductStore(context.read())),
        ChangeNotifierProvider(create: (context) => OrderStore(context.read()))
      ],
      child: MaterialApp(
        title: 'App',
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Pedidos'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToCustomerPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomerPage(),
      ),
    );
  }

  void _navigateToProductPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Text('App'),
            ),
            ListTile(
              title: const Text('Clientes'),
              onTap: () {
                _navigateToCustomerPage(context);
              },
            ),
            ListTile(
              title: const Text('Produtos'),
              onTap: () {
                _navigateToProductPage(context);
              },
            ),
            ListTile(
              title: const Text('Pedidos'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: const OrderPage(),
    );
  }
}
