import 'package:flutter/material.dart';

class HashDisplayScreen extends StatefulWidget {
  static const routeName = '/hash-display';
  final String hash;

  HashDisplayScreen({required this.hash});

  @override
  _HashDisplayScreenState createState() => _HashDisplayScreenState();
}

class _HashDisplayScreenState extends State<HashDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Transaction 's hash"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        child: Center(
          child: Text(widget.hash),
        ),
      ),
    );
  }
}
