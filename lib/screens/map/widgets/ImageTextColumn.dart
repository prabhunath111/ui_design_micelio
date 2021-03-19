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
          backgroundContainer(Color(0xFFFBF2D5),Icon(Icons.electric_scooter),'Keyless', 'Scooters'),
          SizedBox(width: screenWidth * 0.1),
          backgroundContainer(Color(0xFFFAFAFA),Icon(Icons.watch_later_outlined), 'Long', 'Term'),
        ],
      ),
    );
  }

  Widget backgroundContainer(color, icon, text1, text2) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color
      ),
      child: imageTextColumn(icon, text1, text2),
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
              color: Color(text1 == 'Keyless'? 0XFFFF9200 : 0xFFF1F1F1)
            ),
          ),
          Text(text1, style: TextStyle(fontWeight: FontWeight.bold),),
          Text(text2, style: TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
