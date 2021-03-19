import 'package:flutter/material.dart';
import 'package:ui_design_demo/screens/otp/submit.dart';
import 'package:ui_design_demo/screens/otp/textfield.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    print("line13");
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Color(0XFFF6F6F6),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.asset('assets/images/png2.png'),
                ),
                Text(
                  'Enter OTP',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  'Please enter your OTP',
                  style: TextStyle(
                      color: Colors.grey, fontSize: 16.0, letterSpacing: 1.0),
                ),
                Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFieldOtp(),
                          SubmitOtp()
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
  }
}
