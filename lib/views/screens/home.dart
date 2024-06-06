import 'dart:math';

import 'package:flutter/material.dart';

import '../../controllers/contacts_controller.dart';
import '../../models/contact.dart';
import '../widgets/contact_item.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/manage_contact_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final contactsController = ContactsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: FutureBuilder(
        future: contactsController.contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("Couldn't get data from Database."),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Failed to load contacts"));
          } else if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text("You haven't added any contacts yet."));
          } else {
            var contacts = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ContactItem(
                  contact: contact,
                  onDelete: deleteContact,
                  onEdit: editContact,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> addContact() async {
    final data = await showDialog(
      context: context,
      builder: (context) {
        return const AddDialog();
      },
    );
    if (data != null) {
      await contactsController.addContact(
        name: data['name'],
        number: data['number'],
        avatarUrl:
            "https://randomuser.me/api/portraits/men/${Random().nextInt(98) + 1}.jpg",
      );
      setState(() {});
    }
  }

  Future<void> editContact({required Contact contact}) async {
    final data = await showDialog(
      context: context,
      builder: (context) {
        return AddDialog(
          contact: contact,
        );
      },
    );
    if (data != null) {
      await contactsController.editContact(
        id: data['id'],
        name: data['name'],
        number: data['number'],
      );
      setState(() {});
    }
  }

  Future<void> deleteContact({required Contact contact}) async {
    final bool delete = await showDialog(
      context: context,
      builder: (context) {
        return DeleteDialog(contact: contact);
      },
    );
    if (delete) {
      await contactsController.deleteContact(id: contact.id);
      setState(() {});
    }
  }
}
