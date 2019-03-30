import 'package:flutter/material.dart';
import 'package:ecstasy/routes/auth.dart';
import 'package:ecstasy/hello.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Auth',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.deepOrange[200],
      ),
      home: AuthScreen(),
    );
  }
}
