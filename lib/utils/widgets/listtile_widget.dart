import 'package:flutter/material.dart';

class ListtileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget trailing;

  const ListtileWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required Null Function() onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      subtitle: Text(subtitle),
      trailing: trailing,
    );
  }
}
