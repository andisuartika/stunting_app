import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stunting/login_screen.dart';
import 'package:stunting/providers/auth_provider.dart';
import 'package:stunting/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    cekLogin();
    super.initState();
  }

  cekLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool islogin = prefs.getBool('isLogin') ?? false;
    String? token = prefs.getString('token');

    // Get user Data
    if (islogin == true) {
      print('login true');
      await Provider.of<AuthProvider>(context, listen: false).getUser(token);
    }
    print('ISLOGIN : $islogin TOKEN : $token');
    islogin
        ? Navigator.pushNamed(context, '/launcher')
        : Navigator.pushNamed(context, '/login');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/splash-logo.png",
            width: 250,
          ),
        ),
      ),
    );
  }
}
