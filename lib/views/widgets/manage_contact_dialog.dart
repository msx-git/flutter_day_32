import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/contact.dart';
import '../../utils/number_formatter.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key, this.contact});

  final Contact? contact;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      name = widget.contact!.name;
      number = widget.contact!.number.replaceAll('+998 ', '');
      id = widget.contact!.id;
    }
  }

  final formKey = GlobalKey<FormState>();

  final _phoneNumberFormatter = PhoneNumberFormatter();

  String name = "";
  String number = "";

  int id = 0;

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.pop(context, {
        'id': id,
        'name': name,
        'number': "+998 $number",
      });
    }
  }

  @override
  void dispose() {
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
              // controller: nameController,
              initialValue: name,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onSaved: (newValue) {
                name = newValue!;
              },
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Enter name!";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              // controller: numberController,
              initialValue: number,
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
              onSaved: (newValue) {
                number = newValue!;
              },
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
          onPressed: submit,
          child: Text(widget.contact == null ? 'Add contact' : 'Save contact'),
        ),
      ],
    );
  }
}
