import 'package:flutter/material.dart';

import '../screens/table_detail_page.dart';

class TableCard extends StatelessWidget {
  final String tableNumber;
  final String? customerName;
  final String status;
  final String? time;
  final bool isOccupied;

  const TableCard({
    super.key,
    required this.tableNumber,
    this.customerName,
    required this.status,
    this.time,
    required this.isOccupied,
  });

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      if (customerName == 'Jessica Lam') {
        return Colors.grey.shade400;
      } else if (isOccupied) {
        return Colors.red.shade100;
      } else {
        return Colors.green.shade100;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TableDetailPage(
              tableNumber: tableNumber,
              customerName: customerName,
              status: status,
              time: time,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(tableNumber,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                if (customerName != null)
                  Text(customerName!, style: const TextStyle(fontSize: 14)),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: getBackgroundColor(),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(status, style: const TextStyle(fontSize: 14)),
                    if (time != null)
                      Text(time!, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
