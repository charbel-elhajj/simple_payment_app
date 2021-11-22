import 'package:simple_payment_app/screens/all_transactions_screen.dart';
import 'package:simple_payment_app/screens/home_screen.dart';
import 'package:simple_payment_app/screens/integrity_routing_screen.dart';
import 'package:simple_payment_app/screens/user_actions_screens.dart';

final routes = {
  HomeScreen.routeName: (context) => HomeScreen(),
  UserActionsScreen.routeName: (context) => UserActionsScreen(),
  AllTransactionsScreen.routeName: (context) => AllTransactionsScreen(),
  IntegrityRoutingScreen.routeName: (context) => IntegrityRoutingScreen(),
};
