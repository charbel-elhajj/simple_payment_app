import 'dart:async';

import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/services/api_client_service.dart';

class PaymentProvider extends ChangeNotifier {
  final ApiClientService apiClientService;
  Timer? timer;
  Completer<bool?>? completer;

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

  Future<bool?> confirmPayment({
    required String userName,
    required double amount,
    required Duration intervalDuration,
    required Duration timeoutDuration,
  }) async {
    var transactions = await getUserTransactions(userName);
    final initialCount = transactions.length;

    final future = () async {
      final completer = Completer<bool?>();
      timer = Timer.periodic(intervalDuration, (_timer) async {
        print('[Fetching Transaction...]');
        transactions = await getUserTransactions(userName);
        var isRightAmount = transactions.length == 0 ? true : transactions.first.amount == amount;
        final isInserted = transactions.length > initialCount && isRightAmount;
        if (isInserted) {
          _timer.cancel();
          completer.complete(true);
        }
      });

      await completer.future.timeout(timeoutDuration, onTimeout: () {
        timer?.cancel();
        completer.complete(false);
      });

      return completer.future;
    };

    return errorHandler(future);
  }

  Future<T> errorHandler<T>(Future<T> Function() future) async {
    try {
      final response = await future();

      return response;
    } on Exception catch (e) {
      throw e;
    }
  }

  Future<Transaction?> createTransaction(
    String personFrom,
    String personTo,
    double amount,
    RSAKeypair keypair,
  ) async {
    try {
      // ignore: deprecated_member_use
      final signature = keypair.privateKey.createSignature('$amount');
      final transaction = await apiClientService.createTransaction(personFrom, personTo, amount, signature);
      return transaction;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
