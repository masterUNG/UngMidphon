import 'package:flutter/material.dart';

class ShowProcess extends StatefulWidget {
  @override
  _ShowProcessState createState() => _ShowProcessState();
}

class _ShowProcessState extends State<ShowProcess> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
