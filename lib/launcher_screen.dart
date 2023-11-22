import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stunting/providers/posyandu_provider.dart';
import 'package:stunting/theme.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    main();
    super.initState();
    // SET PROVIDER
    Provider.of<PosyanduProvider>(context, listen: false).getPosyandu();
  }

  main() {
    new Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, '/main');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
