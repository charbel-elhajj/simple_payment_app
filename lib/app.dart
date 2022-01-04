import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_payment_app/providers/auth_provider.dart';
import 'package:simple_payment_app/providers/payment_provider.dart';
import 'package:simple_payment_app/screens/login_screen.dart';
import 'package:simple_payment_app/services/api_client_service.dart';
import 'package:simple_payment_app/styles/theme.dart';

import 'config/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return _buildAppWithProviders();
  }

  MultiProvider _buildAppWithProviders() {
    final apiClientService = ApiClientService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(
            apiClientService: apiClientService,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            apiClientService: apiClientService,
          ),
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
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
