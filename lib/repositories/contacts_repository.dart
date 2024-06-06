import 'package:flutter_day_32/models/contact.dart';
import 'package:flutter_day_32/service/database/local_database.dart';

class ContactsRepository {
  final localDatabase = LocalDatabase();

  Future<List<Contact>> getContacts() async {
    return await localDatabase.getContacts();
  }

  Future<void> addContact({
    required String name,
    required String number,
    required String avatarUrl,
  }) async {
    await localDatabase.addContact(
      name: name,
      number: number,
      avatarUrl: avatarUrl,
    );
  }

  Future<void> editContact({
    required int id,
    required String name,
    required String number,
  }) async {
    await localDatabase.editContact(
      id: id,
      name: name,
      number: number,
    );
  }

  Future<void> deleteContact({required int id}) async {
    await localDatabase.deleteContact(id: id);
  }
}
