import 'package:effectips/screens/Login/login_screen.dart';
import 'package:effectips/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:effectips/routes.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Effectips',
      theme: ThemeData.light(),
      routes: {
        Routes.login: (context) => LoginScreen(),
        Routes.home: (context) => HomeScreen()
      },
      initialRoute: Routes.login,
    );
  }
}
