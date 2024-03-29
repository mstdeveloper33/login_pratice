// login_screen.dart

import 'package:flutter/material.dart';
import 'package:login_pratice/service/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool butonDurumu = false;

  @override
  void initState() {
    super.initState();
    butonDurumu;
  }

  Future<void> _signIn() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    await _apiService.signIn(username, password, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Girişi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                butonKontrol();
              },
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              onChanged: (value) {
                butonKontrol();
              },
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: butonDurumu
                  ? () {
                      _signIn();
                    }
                  : null,
              child: Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }

  butonKontrol() {
    setState(() {
      if (_usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        butonDurumu = true;
      } else {
        butonDurumu = false;
      }
    });
  }
}
