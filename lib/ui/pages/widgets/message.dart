import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  Message({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message, 
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black26
        ), 
        textAlign: TextAlign.center,
      ),
    );
  }
}