import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/number_formatter.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final _phoneNumberFormatter = PhoneNumberFormatter();

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new contact'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Enter name!";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  prefixText: '+998 '),
              textInputAction: TextInputAction.done,
              inputFormatters: [
                _phoneNumberFormatter,
                LengthLimitingTextInputFormatter(12)
              ],
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Enter number!";
                } else if (value.length != 12) {
                  return "Must be 9 digits!";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'name': nameController.text,
                'number': "+998 ${numberController.text}",
              });
            }
          },
          child: const Text('Add contact'),
        ),
      ],
    );
  }
}
