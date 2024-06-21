import 'package:flutter/material.dart';

import 'table_card.dart';

class TableGrid extends StatelessWidget {
  const TableGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final tableData = [
      {'name': 'Sylvia Do', 'time': '09:30'},
      {'name': 'Jessica Lam', 'time': '12:02'},
      {'name': 'Sylvia Do', 'time': '13:51'},
      {'name': 'Jessica Lam', 'time': '05:06'},
      {'name': 'Sylvia Do', 'time': '19:10'},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
      {'name': null, 'time': null},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        children: List.generate(tableData.length, (index) {
          return TableCard(
            tableNumber: 'T${index + 1}',
            customerName: tableData[index]['name'],
            status: tableData[index]['name'] != null ? '1/4' : '0/4',
            time: tableData[index]['time'],
            isOccupied: tableData[index]['name'] != null,
          );
        }),
      ),
    );
  }
}
