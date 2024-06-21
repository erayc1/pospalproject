import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/menu_bloc.dart';
import '../bloc/menu_grid.dart';

class TableDetailPage extends StatelessWidget {
  final String tableNumber;
  final String? customerName;
  final String status;
  final String? time;

  const TableDetailPage({
    super.key,
    required this.tableNumber,
    this.customerName,
    required this.status,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MenuCubit(customerName)..showMainMenu(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              return Text(
                  '$tableNumber ${state.totalPrice.toStringAsFixed(2)} \$');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<MenuCubit, MenuState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${state.selectedItems.length} ${state.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.save),
                            onPressed: () {
                              context.read<MenuCubit>().saveOrder();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.print),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.payment),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                if (state.selectedItems.isEmpty) {
                  return const Expanded(
                    flex: 2,
                    child: Center(
                      child: Text('There is no items',
                          style: TextStyle(fontSize: 20)),
                    ),
                  );
                } else {
                  return Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: state.selectedItems.length,
                      itemBuilder: (context, index) {
                        final item = state.selectedItems[index];
                        return ListTile(
                          title: Text(item['name']),
                          trailing: Text('\$${item['price']}'),
                          onLongPress: () {
                            context.read<MenuCubit>().removeItem(item['id']);
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const Expanded(flex: 3, child: MenuGrid()),
          ],
        ),
      ),
    );
  }
}
