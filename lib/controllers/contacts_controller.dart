import 'package:flutter_day_32/repositories/contacts_repository.dart';

import '../models/contact.dart';

class ContactsController {
  final contactsRepository = ContactsRepository();

  final List<Contact> _list = [
    Contact(
        id: 1,
        name: "Musoxon",
        number: "+998 99 525 42 43",
        avatarUrl:
            "https://lh3.googleusercontent.com/a/ACg8ocLcLRcGuyvif62bRtGaf8zlLLJvSH5iTPJlyDXxrwDDlL2zmKs=s288-c-no"),
  ];

  Future<List<Contact>> get contacts async {
    final contactsFromDB = await contactsRepository.getContacts();
    return [..._list, ...contactsFromDB];
  }

  Future<void> addContact({
    required String name,
    required String number,
    required String avatarUrl,
  }) async {
    await contactsRepository.addContact(
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
    await contactsRepository.editContact(
      id: id,
      name: name,
      number: number,
    );
  }

  Future<void> deleteContact({required int id}) async {
    await contactsRepository.deleteContact(id: id);
  }
}
