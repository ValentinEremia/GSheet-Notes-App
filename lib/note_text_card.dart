import 'package:flutter/material.dart';

class MyTextCard extends StatelessWidget {
  final String text;
  const MyTextCard({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black.withOpacity(.8),
      child: Container(
        padding: const EdgeInsets.all(8).copyWith(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.yellow.withOpacity(0.4),
        ),
        alignment: Alignment.topCenter,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 15.5,
          ),
        ),
      ),
    );
  }
}
