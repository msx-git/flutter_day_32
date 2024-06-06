import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_day_32/models/contact.dart';

class ContactItem extends StatelessWidget {
  const ContactItem(
      {super.key,
      required this.contact,
      required this.onDelete,
      required this.onEdit});

  final Contact contact;
  final Future<void> Function({required Contact contact}) onDelete;
  final Future<void> Function({required Contact contact}) onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        leading: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.hardEdge,
          child: Image.network(contact.avatarUrl),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.number),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => onEdit(contact: contact),
              icon: const Icon(
                CupertinoIcons.pencil,
                color: Colors.teal,
              ),
            ),
            IconButton(
              onPressed: () => onDelete(contact: contact),
              icon: const Icon(
                CupertinoIcons.delete,
                size: 20,
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
