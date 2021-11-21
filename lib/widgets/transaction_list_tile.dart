import 'package:flutter/material.dart';
import 'package:simple_payment_app/models/transaction.dart';
import 'package:simple_payment_app/screens/hash_display_screen.dart';

//TODO: Add Actions () see hash
class TransactionListTile extends StatelessWidget {
  final Transaction transaction;
  final bool? inOut;
  const TransactionListTile({Key? key, required this.transaction, this.inOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = _extractMonthAndDay(context);

    return ListTile(
      key: key,
      contentPadding: EdgeInsets.all(8),
      title: Text(
        _transactionDirection,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Text(
        _transactionTime,
        style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.black87),
      ),
      leading: Text(
        formattedDate,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _priceText,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(width: 4),
          if (inOut != null)
            Icon(
              inOut! ? Icons.arrow_back : Icons.arrow_forward,
              color: inOut! ? Colors.green : Colors.red,
            ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HashDisplayScreen(hash: transaction.hash),
        ),
      ),
    );
  }

  String _extractMonthAndDay(BuildContext context) {
    return '${_date.day}/${_date.month}';
  }

  String _formatTime(int timeInfo) => timeInfo < 10 ? '0$timeInfo' : '$timeInfo';

  // Getters

  DateTime get _date => transaction.time;

  String get _priceText {
    final price = transaction.amount;
    return price.toString();
  }

  String get _transactionDirection => '${transaction.personFrom} -> ${transaction.personTo}';

  String get _transactionTime => '${_formatTime(_date.hour)}:${_formatTime(_date.minute)}';
}
