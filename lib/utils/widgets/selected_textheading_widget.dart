import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colorconst.dart';

class SelectedTextheadingWidget extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  const SelectedTextheadingWidget({
    super.key,
    required this.title,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colorconst.textwhite,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
      height: height,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colorconst.darkblue,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
