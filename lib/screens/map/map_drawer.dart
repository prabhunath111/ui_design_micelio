import 'package:flutter/material.dart';
import 'package:ui_design_demo/screens/map/floating_text_column.dart';
import 'package:ui_design_demo/screens/map/widgets/ImageTextColumn.dart';

class MapDrawer extends StatefulWidget {
  @override
  _MapDrawerState createState() => _MapDrawerState();
}

class _MapDrawerState extends State<MapDrawer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Drawer(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0),
                height: screenHeight * 0.227,
                child: Align(
                  alignment: Alignment(0, -0.6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundColor: const Color(0xFFC4C6C8),
                        child: new Image.asset(
                          'assets/images/png2.png',
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26.0,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            "9547271228",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(color: Color(0xFFC4C6C8)),
              ),
              SizedBox(height: screenHeight * 0.1),
              ImageTextColumn(),
              Container(
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.08, right: screenWidth * 0.08),
                  child: Divider(height: screenHeight * 0.09, thickness: 1.0)),

            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.2,
          left: screenWidth * 0.08,
          right: screenWidth * 0.08,
          child: Container(
            height: screenHeight * 0.12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFFF8DE89), Color(0xFFFFB72D)])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingTextColumn(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    'assets/images/png3.png',
                    width: 36.0,
                    height: 36.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
