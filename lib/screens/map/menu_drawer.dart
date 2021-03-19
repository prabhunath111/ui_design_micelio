import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin:
          EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth * 0.08),
      child: Column(

        children: [
          listRow(Color(0xFFDDDDEE),Icon(Icons.add), 'Bounce Club', 'New'),
          listRow(Color(0xFFE3F7F0),Icon(Icons.add), 'Refer and Earn', ''),
          listRow(Color(0xFFE3F7F0),Icon(Icons.add), 'Fuel & Earn', ''),
          listRow(Color(0xFFFFF6D9),Icon(Icons.credit_card), 'Driving License', 'ADD NOW'),
          Divider(height: 10),
          listRow(Color(0xFFF6F6F6),Icon(Icons.payments, color: Colors.blueGrey), 'Payments', ''),
          listRow(Color(0xFFF6F6F6),Icon(Icons.access_time_rounded, color: Colors.blueGrey), 'Your Rides', ''),
        ],
      ),
    );
  }

  Widget listRow(iconBackColor, icon, midText, rightText) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackColor
            ),
            child: icon,
          ),
          SizedBox(width: 10.0),
          Text(
              midText,
            style: TextStyle(
              // fontSize: 10
            ),
          ),
          Expanded(child: Container()),
          (rightText != '') ? Container(
            decoration: BoxDecoration(
              color: rightText == 'New' ? Colors.redAccent : Colors.black,
              borderRadius: BorderRadius.circular(5)
            ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 4.0, 6.0,4.0),
                child: Text(
                    rightText,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
          ) : Container()
        ],
      ),
    );
  }
}
