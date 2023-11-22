import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stunting/launcher_screen.dart';
import 'package:stunting/login_screen.dart';
import 'package:stunting/main_screen.dart';
import 'package:stunting/providers/auth_provider.dart';
import 'package:stunting/providers/page_provider.dart';
import 'package:stunting/providers/posyandu_provider.dart';
import 'package:stunting/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => PosyanduProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/launcher': (context) => LauncherScreen(),
          '/main': (context) => MainScreen(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
