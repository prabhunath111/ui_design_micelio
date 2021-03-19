import 'package:flutter/material.dart';

class TextFieldOtp extends StatefulWidget {
  @override
  _TextFieldOtpState createState() => _TextFieldOtpState();
}

class _TextFieldOtpState extends State<TextFieldOtp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          border: new Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(6.0)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: TextField(
          cursorColor: Colors.black,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal),
          textAlign: TextAlign.left,
          decoration: new InputDecoration(
            suffixIcon: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF49C1BD)
              ),
              child: Icon(Icons.done, color: Colors.white,),
            ),
            hintText: 'Enter OTP here',
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
