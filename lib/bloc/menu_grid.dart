import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pospal_app/widgets/menu_card.dart';
import 'menu_bloc.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        if (state.isSubMenu)
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              context.read<MenuCubit>().showMainMenu();
                            },
                          ),
                        Text(state.menuTitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 17)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 2.7,
                padding: const EdgeInsets.all(8.0),
                children: state.items.map((item) {
                  final price =
                      state.isSubMenu ? item['price'] as double : null;
                  return MenuItemCard(
                      item: item['name'] as String, price: price);
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
