import 'package:flutter/material.dart';
import 'package:ecstasy/button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Auth',
      
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        accentColor: Colors.deepOrange[200],
      ),
      home: ShowButtonPage() //AuthScreen(),
    );
  }
}
