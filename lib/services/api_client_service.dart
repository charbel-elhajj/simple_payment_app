import 'package:simple_payment_app/models/transaction.dart';

class ApiClientService {
  Future<List<Transaction>> getTransactions() {
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
