import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'menu.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            customerName TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderType TEXT,
            client TEXT,
            leftToPay REAL,
            total REAL,
            date TEXT,
            status TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE order_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            name TEXT,
            FOREIGN KEY(orderId) REFERENCES orders(id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE orders ADD COLUMN status TEXT
          ''');
        }
      },
    );
  }

  Future<void> insertItem(
      String name, double price, String? customerName) async {
    final db = await database;
    await db.insert(
      'items',
      {'name': name, 'price': price, 'customerName': customerName},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getItemsForCustomer(
      String? customerName) async {
    final db = await database;
    return await db
        .query('items', where: 'customerName = ?', whereArgs: [customerName]);
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertOrder(
      Map<String, dynamic> order, List<Map<String, dynamic>> items) async {
    final db = await database;
    int orderId = await db.insert(
      'orders',
      order,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    for (var item in items) {
      await db.insert(
        'order_items',
        {'orderId': orderId, 'name': item['name']},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    final db = await database;
    final orders = await db.query('orders');
    List<Map<String, dynamic>> result = [];
    for (var order in orders) {
      final items = await db
          .query('order_items', where: 'orderId = ?', whereArgs: [order['id']]);
      result.add({
        ...order,
        'items': items,
      });
    }
    return result;
  }
}
