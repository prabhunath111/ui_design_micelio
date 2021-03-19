import 'package:flutter/material.dart';

class FloatingTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textSectin('Used Bike Sale', true),
          textSectin('Book a Test Ride!', false),
        ],
      ),
    );
  }

  Widget textSectin(text, isTitle) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: isTitle ? 20 : 15
      ),
    );
  }
}
