import 'package:flutter/material.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/services/api_client_service.dart';

class PaymentProvider extends ChangeNotifier {
  final ApiClientService apiClientService;

  PaymentProvider({required this.apiClientService});

  Future<List<Transaction>> getTransactions() async {
    return apiClientService.getTransactions();
  }

  Future<List<Transaction>> getUserTransactions(String userName) async {
    return apiClientService.getUserTransactions(userName);
  }

  Future<bool> getIntegrity() async {
    return await apiClientService.getIntegrity();
  }

  Future<double> getUserBalance(String userName) async {
    try {
      final balance = await apiClientService.getUserBalance(userName);
      return balance;
    } on Exception catch (e) {
      return 0;
    }
  }
}
