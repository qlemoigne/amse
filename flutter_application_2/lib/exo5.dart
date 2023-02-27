import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class TuilesViewWidget extends StatefulWidget {
  const TuilesViewWidget({super.key});

  @override
  State<TuilesViewWidget> createState() => _TuilesViewWidgetState();
}

class _TuilesViewWidgetState extends State<TuilesViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GridView'),
        ),
        body: Center());
  }
}
