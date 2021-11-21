import 'package:dio/dio.dart';
import 'package:simple_payment_app/config/constants.dart';
import 'package:simple_payment_app/models/transaction.dart';

class ApiClientService {
  final _dio = Dio();


  Future<List<Transaction>> getTransactions() {
    final path = '${apiLink}transactions';
    final response = _dio.get(path) as Map<String, dynamic>;
    print(response['result']);
    return Future.delayed(
      Duration(seconds: 3),
      () => List.generate(
        10,
        (index) => Transaction(
          personFrom: 'test1',
          personTo: 'test2',
          amount: 10,
          id: index,
          hash: 'xxxxxx',
          time: DateTime.now(),
        ),
      ),
    );
  }
}
