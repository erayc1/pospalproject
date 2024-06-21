import 'package:flutter_bloc/flutter_bloc.dart';

import '../sqflite/db_helper.dart';

class MenuState {
  final String menuTitle;
  final List<Map<String, dynamic>> items;
  final bool isSubMenu;
  final List<Map<String, dynamic>> selectedItems;
  final double totalPrice;
  final String? customerName;

  MenuState(this.menuTitle, this.items, this.isSubMenu, this.selectedItems,
      this.totalPrice, this.customerName);
}

class MenuCubit extends Cubit<MenuState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  MenuCubit(String? customerName)
      : super(MenuState(
          'Menu',
          [
            {'name': 'BENTO BOX'},
            {'name': 'BUILD YOUR OWN RAMEN'},
            {'name': 'CHEESECAKE SERIES'},
            {'name': 'DESSERTS'},
            {'name': 'DRINKS'},
            {'name': 'EXTRAS'},
            {'name': 'FRUIT TEA'},
            {'name': 'HANG-IN RAMEN'},
            {'name': 'JAM MILKY'},
            {'name': 'JAPANESE GRILLE'},
            {'name': 'KID MENU'},
            {'name': 'LEMONADE PARADISE'}
          ],
          false,
          [],
          0.0,
          customerName,
        ));

  void showMenu(String menuTitle, List<Map<String, dynamic>> items) {
    emit(MenuState(menuTitle, items, true, state.selectedItems,
        state.totalPrice, state.customerName));
  }

  void showMainMenu() async {
    final selectedItems =
        await _databaseHelper.getItemsForCustomer(state.customerName);
    double total = selectedItems.fold(0, (sum, item) => sum + item['price']);
    emit(MenuState(
        'Menu',
        [
          {'name': 'BENTO BOX'},
          {'name': 'BUILD YOUR OWN RAMEN'},
          {'name': 'CHEESECAKE SERIES'},
          {'name': 'DESSERTS'},
          {'name': 'DRINKS'},
          {'name': 'EXTRAS'},
          {'name': 'FRUIT TEA'},
          {'name': 'HANG-IN RAMEN'},
          {'name': 'JAM MILKY'},
          {'name': 'JAPANESE GRILLE'},
          {'name': 'KID MENU'},
          {'name': 'LEMONADE PARADISE'}
        ],
        false,
        selectedItems,
        total,
        state.customerName));
  }

  void addItem(String name, double price) async {
    await _databaseHelper.insertItem(name, price, state.customerName);
    final selectedItems =
        await _databaseHelper.getItemsForCustomer(state.customerName);
    double total = selectedItems.fold(0, (sum, item) => sum + item['price']);
    emit(MenuState(state.menuTitle, state.items, state.isSubMenu, selectedItems,
        total, state.customerName));
  }

  void removeItem(int id) async {
    await _databaseHelper.deleteItem(id);
    final selectedItems =
        await _databaseHelper.getItemsForCustomer(state.customerName);
    double total = selectedItems.fold(0, (sum, item) => sum + item['price']);
    emit(MenuState(state.menuTitle, state.items, state.isSubMenu, selectedItems,
        total, state.customerName));
  }

  Future<void> saveOrder() async {
    final order = {
      'orderType': 'table',
      'client': state.customerName ?? 'Unknown',
      'leftToPay': state.totalPrice,
      'total': state.totalPrice,
      'date': DateTime.now().toString(),
    };
    await _databaseHelper.insertOrder(order, state.selectedItems);
    emit(MenuState(state.menuTitle, state.items, state.isSubMenu, [], 0.0,
        state.customerName));
  }
}
