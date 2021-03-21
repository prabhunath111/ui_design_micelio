import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_design_demo/screens/login/submit_button.dart';
import 'package:ui_design_demo/screens/login/textfields.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phone;
  void handleOnChange(String s){
    setState(() {
      phone = s;
      print("line17 $phone");
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: screenHeight,
              width: screenWidth,
              color: Color(0xFFC4C6C8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: screenHeight * 0.2,
                  ),
                  Image.asset('assets/images/png2.png', width: 72,height: 72),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Text(
                    'Mobile Number',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    'Please enter your mobile number',
                    style: TextStyle(
                        color: Colors.black45, fontSize: 16.0, letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: screenHeight * 0.14,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFields(handleOnChange: handleOnChange),
                          SizedBox(
                            height: 8.0,
                          ),
                          SubmitButton(phone: phone)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
