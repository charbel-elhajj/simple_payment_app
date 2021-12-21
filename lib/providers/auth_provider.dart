import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:simple_payment_app/models/person.dart';
import 'package:simple_payment_app/services/api_client_service.dart';

class AuthProvider extends ChangeNotifier {
  final ApiClientService apiClientService;
  RSAKeypair? keypair;
  Person? person;

  AuthProvider({
    required this.apiClientService,
  });

  Future<bool> signin(String email, String password) async {
    try {
      keypair = RSAKeypair.fromRandom();
      // String message = DateTime.now().millisecondsSinceEpoch.toRadixString(16);
      // String signature = rsaKeypair.privateKey.createSignature(message);
      // bool verified = rsaKeypair.publicKey.verifySignature(message, signature);

      // print(rsaKeypair.publicKey);
      // print(rsaKeypair.privateKey.publicKey);
      // print(verified);
      // print(rsaKeypair.privateKey.publicKey.toString() == rsaKeypair.publicKey.toString());
      // print(signature);
      // print(message);
      person = await apiClientService.signin(email, password, keypair!.publicKey.toString());
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      keypair = RSAKeypair.fromRandom();
      person = await apiClientService.signup(email, password, keypair!.publicKey.toString());
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
