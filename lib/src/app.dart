import 'package:flutter/material.dart';
import 'package:proyect/src/screens/login_screen.dart';
import 'package:proyect/src/screens/api_screen.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: Scaffold(
        body: LoginScreen(),
        
      ),
    );
  }
}