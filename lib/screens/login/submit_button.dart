import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.8,
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/otpscreen');
          },
          child: Text(
            'Submit',
            style: TextStyle(letterSpacing: 1.0, fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16),
          ),
          style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                // side: BorderSide(color: Colors.red)
              )
              )
          )
      ),
    );
  }
}
