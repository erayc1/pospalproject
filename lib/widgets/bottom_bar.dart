import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.exit_to_app),
          label: 'Exit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Order List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_grocery_store),
          label: 'To Go',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood),
          label: 'Quick Order',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
