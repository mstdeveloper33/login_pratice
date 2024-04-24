// login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  // TODO Burada kullanıcı isteği sonrası api ile iletişimin sağlanması için işlem yapıldı. 
  // TODO Eğer kullanıcı girişi sağlanıyorsa token saklanıyor , eğer giriş yapılamıyorsa uyarı için alert dialog gösteriyor.
  Future<void> _signIn() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.black),
        );
      },
    );
    String username = _usernameController.text;
    String password = _passwordController.text;

    ResponseModel? responseData =
        await _apiService.signIn(username, password, context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Loading indicator'ı kapat

    if (responseData != null &&
        responseData.status == true &&
        responseData.token != null) {
      saveToken(responseData.token ?? "");
      // ignore: use_build_context_synchronously
      Provider.of<TokenProvider>(context, listen: false).token =
          responseData.token!;
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "/home"); // Home sayfasına git
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Giriş Başarısız.'),
          content: const Text('Kullanıcı adı veya şifre hatalı.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // AlertDialog'ı kapat
                _usernameController
                    .clear(); // Kullanıcı adı TextField'ını temizle
                _passwordController.clear();
                _butonKontrol();
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade100,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        title: const Text('Kullanıcı Girişi'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Image.asset("assets/images/talu_2.png")),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hoşgeldiniz",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                _padding(),
                _padding_2(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: butonDurumu
                      ? () {
                          _signIn();
                        }
                      : null,
                  child: const Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _padding_2() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) {
          _butonKontrol();
        },
        controller: _passwordController,
        decoration: const InputDecoration(
            suffixIcon: Icon(Icons.password),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: 'Şifre',
            labelStyle: TextStyle(color: Colors.black)),
        obscureText: true,
      ),
    );
  }

  Padding _padding() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (value) {
          _butonKontrol();
        },
        controller: _usernameController,
        decoration: const InputDecoration(
            suffixIcon: Icon(Icons.mail),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: 'Kullanıcı Adı',
            labelStyle: TextStyle(color: Colors.black)),
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
