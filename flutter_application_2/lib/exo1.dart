import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class DisplayImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Display image'),
        ),
        body: Center(
          child: Image.asset(
            'assets/images/test1.jpg',
            width: 350,
            fit: BoxFit.cover,
          ),
        ));
  }
}
