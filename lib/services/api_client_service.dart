import 'package:dio/dio.dart';
import 'package:simple_payment_app/config/constants.dart';
import 'package:simple_payment_app/models/transaction.dart';

class ApiClientService {
  final _dio = Dio();

  Future<List<Transaction>> getTransactions() async {
    final path = '${apiLink}transactions';
    final response = (await _dio.get(path));
    final data = response.data as Map<String, dynamic>;
    final transactions = (data['result'] as List).map((t) => Transaction.fromJson(t)).toList();
    return transactions;
  }

  Future<List<Transaction>> getUserTransactions(String userName) async {
    final path = '${apiLink}persons/$userName/transactions';
    final response = (await _dio.get(path));
    final data = response.data as Map<String, dynamic>;
    final transactions = (data['result'] as List).map((t) => Transaction.fromJson(t)).toList();
    return transactions;
  }

  Future<double> getUserBalance(String userName) async {
    final path = '${apiLink}persons/$userName/balance';
    final response = (await _dio.get(path));
    final data = response.data as Map<String, dynamic>;
    final balance = (data['result']['balance']) as double;
    return balance;
  }

  Future<bool> getIntegrity() async {
    final path = '${apiLink}transactions/integrity';
    final response = (await _dio.get(path));
    final data = response.data as Map<String, dynamic>;
    final isValid = (data['result']['integrity'] as bool);
    return isValid;
  }

  Future<Transaction> createTransaction(
    String personFrom,
    String personTo,
    double amount,
  ) async {
    final params = {
      'person_from': personFrom,
      'person_to': personTo,
      'amount': amount,
    };
    final path = '${apiLink}transactions';
    final response = await _dio.post(
      path,
      data: FormData.fromMap(params),
    );

    final data = response.data as Map<String, dynamic>;
    final transaction = Transaction.fromJson(data);
    return transaction;
  }
}
