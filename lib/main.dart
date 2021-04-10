import 'package:cctracer/CCList.dart';
import 'package:flutter/material.dart';
void main() =>runApp(CCTracer());

class CCTracer extends StatelessWidget{
  
  Widget build (BuildContext context) {
    return MaterialApp(
      title: 'Трекер криптовалют',
      theme: ThemeData(
        primarySwatch: Colors.yellow
      ),
      home: CCList(),
      
    );
  }
}
