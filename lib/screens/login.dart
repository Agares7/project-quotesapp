import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String user = 'admin';
  final String pass = 'admin';
  final int xorKey = 42;

  TextEditingController userText = TextEditingController();
  TextEditingController passText = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset('assets/images/quotes.png'),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
              child: TextField(
                controller: userText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: TextField(
                obscureText: true,
                controller: passText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              width: 150,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text('Log In'),
                onPressed: () {
                  checkLogin(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkLogin(BuildContext context) async {
    final encryptedUsername = xorEncrypt(userText.text);
    final encryptedPassword = xorEncrypt(passText.text);

    if (encryptedUsername == xorEncrypt(user) &&
        encryptedPassword == xorEncrypt(pass)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      navigateToHomePage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password.'),
          backgroundColor: Colors.black,
        ),
      );
    }
  }

  String xorEncrypt(String text) {
    String result = '';
    final List<int> bytes = utf8.encode(text);
    for (int byte in bytes) {
      result += String.fromCharCode(byte ^ xorKey);
    }
    return result;
  }

  void navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FetchQuotePage()),
    );
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      navigateToHomePage();
    }
  }
}
