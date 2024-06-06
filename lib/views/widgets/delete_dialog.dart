import 'package:flutter/material.dart';
import 'package:flutter_day_32/models/contact.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Deleting contact'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(contact.name),
          const SizedBox(height: 10),
          Text(contact.number),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text(
            'Yes, delete',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
