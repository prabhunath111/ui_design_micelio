import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  @override
  _TextFieldsState createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: new Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(6)),
              child: TextField(
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                enabled: false,
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                  hintText: '+91',
                  border: InputBorder.none,
                ),
              ),
            )),
        SizedBox(width: screenWidth * 0.05),
        Expanded(
            flex: 4,
            child: Container(
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
                    hintText: 'Enter number',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
        ),
      ],
    );
  }
}
