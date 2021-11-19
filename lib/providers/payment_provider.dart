import 'package:flutter/material.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/services/api_client_service.dart';

class PaymentProvider extends ChangeNotifier {
  final ApiClientService apiClientService;

  PaymentProvider({required this.apiClientService});

  Future<List<Transaction>> getTransactions() async {
    return apiClientService.getTransactions();
  }
}