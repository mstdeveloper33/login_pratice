import 'package:flutter/material.dart';

import 'package:login_pratice/provider/token_provider.dart';
import 'package:login_pratice/shared/shared.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget with SharedManager {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // getToken();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Consumer<TokenProvider>(
          builder: (context, tokenProvider, _) {
            return Text(tokenProvider.token);
          },
        ),
      ),
      body: ElevatedButton(
          onPressed: () {
            _cikisYap(context);
          },
          child: Text("Çıkış Yap")),
    );
  }

  void _cikisYap(BuildContext context) async {
    await clearToken();
    print("token silindi");

    Navigator.pushReplacementNamed(context, "/login");
  }
}
