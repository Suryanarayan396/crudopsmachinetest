import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/staff_model.dart';

class StaffDialog extends StatefulWidget {
  StaffDialog(BuildContext context);

  @override
  _StaffDialogState createState() => _StaffDialogState();
}

class _StaffDialogState extends State<StaffDialog> {
  final staffnamecontroller = TextEditingController();
  final staffphonecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Staff Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: staffnamecontroller,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: staffphonecontroller,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Generate a random code for the staff member
            final staffCode = 'STAFF-${DateTime.now().millisecondsSinceEpoch}';
            final newStaff = Staff(
              name: staffnamecontroller.text,
              phoneNumber: staffphonecontroller.text,
              code: staffCode,
            );
            Navigator.of(context).pop(newStaff);
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
