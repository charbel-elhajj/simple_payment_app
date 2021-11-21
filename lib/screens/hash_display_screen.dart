import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:simple_payment_app/widgets/transaction_list_tile.dart';

class HashDisplayScreen extends StatefulWidget {
  static const routeName = '/hash-display';
  String hash;

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
    return Container(
      child: Center(
        child: Text(widget.hash),
      ),
    );
  }
}
