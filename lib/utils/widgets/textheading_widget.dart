import 'package:flutter/material.dart';

class TextheadingWidget extends StatelessWidget {
  final String title;
  final Color containercolor;
  final Color textcolor;
  final double height;
  final double width;
  const TextheadingWidget(
      {super.key,
      required this.title,
      required this.containercolor,
      required this.height,
      required this.width,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: containercolor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: textcolor, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
