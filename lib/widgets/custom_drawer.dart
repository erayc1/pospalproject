import 'package:flutter/material.dart';

import '../screens/order_lists_page.dart';

class CustomDrawer extends StatelessWidget {
  final String accountName;
  final String accountEmail;
  final String workplace;

  const CustomDrawer({
    super.key,
    required this.accountName,
    required this.accountEmail,
    required this.workplace,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                accountName[0],
                style: const TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.table_chart),
            title: const Text('Table Service'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.quick_contacts_mail),
            title: const Text('Quick Order'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delivery_dining),
            title: const Text('Delivery'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.kitchen),
            title: const Text('Kitchen Display'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Clock Time'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.list_alt),
            title: const Text('Order List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderListPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Reports'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text('Order Ready Screen'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.price_check),
            title: const Text('Price Checker'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
