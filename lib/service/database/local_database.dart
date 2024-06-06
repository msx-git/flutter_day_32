import 'package:flutter/foundation.dart';
import 'package:flutter_day_32/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  final String tableName = "contacts";

  LocalDatabase._();

  static final LocalDatabase _localDatabase = LocalDatabase._();

  factory LocalDatabase() => _localDatabase;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath = await getDatabasesPath();
    final path = '$dbPath/$tableName.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    db.execute('''CREATE TABLE $tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    number TEXT NOT NULL,
    avatar_url TEXT NOT NULL)''');
  }

  /// Get Contacts
  Future<List<Contact>> getContacts() async {
    final db = await _localDatabase.database;
    final list = await db.query(tableName, columns: [
      'id',
      'name',
      'number',
      'avatar_url',
    ]);
    final contacts = list.map((contact) => Contact.fromJson(contact)).toList();
    return contacts;
  }

  /// Add Contact
  Future<void> addContact({
    required String name,
    required String number,
    required String avatarUrl,
  }) async {
    final db = await _localDatabase.database;
    try {
      await db.insert(tableName, {
        'name': name,
        'number': number,
        'avatar_url': avatarUrl,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /// Delete Contact
  Future<void> deleteContact({required int id}) async {
    final db = await _localDatabase.database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

// getContacts
}
