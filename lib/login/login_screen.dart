// login_screen.dart

import 'package:flutter/material.dart';
import 'package:login_pratice/model/response_model.dart';
import 'package:login_pratice/provider/token_provider.dart';
import 'package:login_pratice/service/api_service.dart';
import 'package:login_pratice/shared/shared.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SharedManager {
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
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: CircularProgressIndicator(color: Colors.black));
      },
    );
    String username = _usernameController.text;
    String password = _passwordController.text;

    ResponseModel? responseData =
        await _apiService.signIn(username, password, context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    if (responseData != null &&
        responseData.status == true &&
        responseData.token != null) {
      saveToken(responseData.token ?? "");
      // ignore: use_build_context_synchronously
      Provider.of<TokenProvider>(context, listen: false).token =
          responseData.token!;

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(
        context, "/home"

       
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giriş yapılamadı. Kullanıcı adı veya şifre hatalı.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Girişi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                _butonKontrol();
              },
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            TextField(
              onChanged: (value) {
                _butonKontrol();
              },
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: butonDurumu
                  ? () {
                      _signIn();
                    }
                  : null,
              child: const Text('Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }

  _butonKontrol() {
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
