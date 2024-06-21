import 'package:flutter/material.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/table_grid.dart';

class TableServicePage extends StatelessWidget {
  const TableServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Table Service'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const CustomDrawer(
        accountName: 'Sylvia Do',
        accountEmail: 'testsoupa@example.com',
        workplace: 'Waiter 1',
      ),
      body: const TableGrid(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
