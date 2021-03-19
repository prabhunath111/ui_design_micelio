import 'package:flutter/material.dart';

class ImageTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth*0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFFFBF2D5)
            ),
              child: imageTextColumn(Icon(Icons.electric_scooter), 'Keyless', 'Scooters'),
          )
        ],
      ),
    );
  }

  Widget imageTextColumn(Icon icon, text1, text2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(10),
              child: icon,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0XFFFF9200)
            ),
          ),
          Text(text1, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(text2, style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
