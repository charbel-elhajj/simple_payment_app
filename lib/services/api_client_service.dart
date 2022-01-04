import 'package:dio/dio.dart';
import 'package:simple_payment_app/config/constants.dart';
import 'package:simple_payment_app/models/person.dart';
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
    String signature,
  ) async {
    final params = {
      'person_from': personFrom,
      'person_to': personTo,
      'amount': amount,
      'signature': signature,
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

  Future<Person> signin(String email, String password, String? publicKey) async {
    print('data');
    final params = {
      'email': email,
      'password': password,
      if (publicKey != null) 'public_key': publicKey,
    };
    final path = '${apiLink}persons/signin';
    final response = await _dio.post(
      path,
      data: FormData.fromMap(params),
    );
    final data = response.data as Map<String, dynamic>;
    print(data);
    final person = Person.fromJson(data);
    return person;
  }

  Future<Person> signup(String email, String password, String publicKey) async {
    print('data');
    final params = {
      'email': email,
      'password': password,
      'public_key': publicKey,
    };
    final path = '${apiLink}persons/signup';
    final response = await _dio.post(
      path,
      data: FormData.fromMap(params),
    );
    final data = response.data as Map<String, dynamic>;
    print(data);
    final person = Person.fromJson(data);
    return person;
  }
}
