import 'package:flutter/material.dart';

class TopSearchSection extends StatefulWidget {
  final handleDrawer;
  TopSearchSection({this.handleDrawer});

  @override
  _TopSearchSectionState createState() => _TopSearchSectionState();
}

class _TopSearchSectionState extends State<TopSearchSection> {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
        top: screenHeight * 0.1,
        left: 0.0,
      right: 0.0,
      child: Container(
        height: screenHeight*0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: (){
                // handleDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
                size: 32.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Theme(
                    data: ThemeData(
                        primaryColor: Color(0xFF49C1BD),
                        hintColor: Colors.grey),
                    child: TextField(
                      decoration: new InputDecoration(
                        // borderRadiuserSide: const BorderSide(color: Colors.grey, width: 0.0),
                          border: new OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF49C1BD), width: 0.0),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(50.0),
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.circle,
                              color: Color(0xFF49C1BD), size: 11.0),
                          hintText: "Your Location",
                          fillColor: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 4.0, right: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.my_location_rounded,
                  color: Colors.black,
                  size: 32.0,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
