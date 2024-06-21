import 'package:flutter/material.dart';
import '../sqflite/db_helper.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchOrders() async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.getOrders();
  }

  Future<List<Map<String, dynamic>>> _fetchUnpaidOrders() async {
    final orders = await _fetchOrders();
    return orders.where((order) => order['leftToPay'] > 0).toList();
  }

  Future<List<Map<String, dynamic>>> _fetchPaidOrders() async {
    final orders = await _fetchOrders();
    return orders.where((order) => order['leftToPay'] == 0).toList();
  }

  Future<List<Map<String, dynamic>>> _fetchClosedOrders() async {
    // Implement closed orders fetching logic if necessary
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'UNPAID'),
              Tab(text: 'PAID'),
              Tab(text: 'CLOSED'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(_fetchUnpaidOrders()),
            _buildOrderList(_fetchPaidOrders()),
            _buildOrderList(_fetchClosedOrders()),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(Future<List<Map<String, dynamic>>> fetchOrders) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading orders'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No orders available'));
        } else {
          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${order['id']} (${order['orderType']})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(order['client']),
                      Text(
                          'Left to pay ${order['leftToPay']} \$ of total ${order['total']} \$'),
                      Text(order['date']),
                      const SizedBox(height: 8.0),
                      ...order['items'].map<Widget>((item) {
                        return Text('1.0 * ${item['name']}');
                      }).toList(),
                      const SizedBox(height: 15.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.lightBlue,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              minimumSize: Size(60, 36),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Info',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 0, 91, 165),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              minimumSize: Size(60, 36),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Pay',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 91, 165),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.green,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              minimumSize: Size(60, 36),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Print',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              minimumSize: Size(60, 36),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Void',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
