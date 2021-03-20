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
          listRow(Color(0xFFDDDDEE),Icon(Icons.ac_unit,color: Color(0xFF3333A5)), 'Bounce Club', 'New'),
          listRow(Color(0xFFE3F7F0),Icon(Icons.monetization_on_outlined, color: Color(0xFF15D48F)), 'Refer and Earn', ''),
          listRow(Color(0xFFE3F7F0),Icon(Icons.battery_charging_full,color: Color(0xFF15D48F)), 'Fuel & Earn', ''),
          listRow(Color(0xFFFFF6D9),Icon(Icons.credit_card, color: Color(0xFFFF9E00)), 'Driving License', 'ADD NOW'),
          Divider(height: 10),
          listRow(Color(0xFFE6E6E6),Icon(Icons.payments, color: Colors.blueGrey), 'Payments', ''),
          listRow(Color(0xFFE6E6E6),Icon(Icons.directions_bike_sharp, color: Colors.blueGrey), 'Your Rides', ''),
          listRow(Color(0xFFE6E6E6),Icon(Icons.access_time_rounded, color: Colors.blueGrey), 'Get Helmet', ''),
          listRow(Color(0xFFE6E6E6),Icon(Icons.phone, color: Colors.blueGrey), 'Help', ''),
          listRow(Color(0xFFE6E6E6),Icon(Icons.logout, color: Colors.blueGrey), 'Log Out', ''),
          SizedBox(height: screenHeight*0.11,)
        ],
      ),
    );
  }

  Widget listRow(iconBackColor, icon, midText, rightText) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: (midText!='Log Out') ? 10.0 : 0.0),
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
          SizedBox(width: 16.0),
          Text(
              midText,
            style: TextStyle(
              fontSize: 14
            ),
          ),
          Expanded(child: Container()),
          (rightText != '') ? Container(
            decoration: BoxDecoration(
              color: rightText == 'New' ? Colors.redAccent : Colors.black,
              borderRadius: BorderRadius.circular(3)
            ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(3.5, 1.0, 3.5,1.0),
                child: Text(
                    rightText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),
                ),
              )
          ) : Container()
        ],
      ),
    );
  }
}
