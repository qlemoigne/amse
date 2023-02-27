import 'package:flutter/material.dart';
// import 'package:Taquin/util.dart';
import 'dart:math';

class ImageTransformationWidget extends StatefulWidget {
  const ImageTransformationWidget({super.key});

  @override
  State<ImageTransformationWidget> createState() => _ImageTransformationState();
}

class _ImageTransformationState extends State<ImageTransformationWidget> {
  @override
  Widget build(BuildContext context) {
    double _rotateX = 0;
    double _rotateZ = 0;
    double _scale = 100;

    return Scaffold(
        appBar: AppBar(
          title: Text('Image transformation'),
        ),
        body: Center(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const Text(
                "Rotate X : ",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                  child: Slider(
                value: _rotateX,
                min: 0,
                max: 360,
                divisions: 5,
                label: _rotateX.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _rotateX = value;
                  });
                },
              )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const Text(
                "Rotate Z : ",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                  child: Slider(
                value: _rotateZ,
                min: 0,
                max: 360,
                divisions: 360,
                label: _rotateZ.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _rotateZ = value;
                  });
                },
              ))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              const Text(
                "Scale : ",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(
                child: Slider(
                  value: _scale,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _scale.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _scale = value;
                    });
                  },
                ),
              )
            ],
          ),
        ])));
  }
}
