


import 'package:flutter/material.dart';
import 'package:ungmitrphol/widgets/show_alert.dart';

Future<Null> normalDialog(BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowAlert(),
          title: Text(title),
          subtitle: Text(message),
        ),
        content: TextButton(
            onPressed: () => Navigator.pop(context), child: Text('OK')),
      ),
    );
  }