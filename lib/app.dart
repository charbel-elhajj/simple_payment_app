import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:simple_payment_app/styles/theme.dart';

import 'config/routes.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildAppWithProviders();
  }

  MultiProvider _buildAppWithProviders() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PaymentProvider()
        ),
      ],
      child: _buildApp(),
    );
  }

  MaterialApp _buildApp() {
    return MaterialApp(
      title: 'Simple Payment App',
      theme: theme,
      routes: routes,
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
