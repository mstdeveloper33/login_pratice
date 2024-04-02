import 'package:flutter/material.dart';
import 'package:login_pratice/login/login_screen.dart';
import 'package:login_pratice/provider/token_provider.dart';
import 'package:login_pratice/shared/shared.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SharedManager {
  @override
  Widget build(BuildContext context) {
    getToken();
    String token = Provider.of<TokenProvider>(context).token;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent, title: Text("$token")),
      body: ElevatedButton(
          onPressed: () {
            _cikisYap();
          },
          child: Text("Çıkış Yap")),
    );
  }

  void _cikisYap() async {
    clearToken();
    
    Navigator.pushReplacementNamed(
        context, "/login"
        );
  }
}


//  String token = "";
//   Future<void> getTokenCAche() async {
//     token = await getToken() ?? "";
//     setState(() {});
//   }