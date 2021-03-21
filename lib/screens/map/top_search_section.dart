import 'package:flutter/material.dart';

class TopSearchSection extends StatefulWidget {
  final handleDrawer;
  const TopSearchSection ({ Key key, this.handleDrawer }): super(key: key);

  // TopSearchSection({this.handleDrawer});

  @override
  _TopSearchSectionState createState() => _TopSearchSectionState();
}

class _TopSearchSectionState extends State<TopSearchSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Positioned(
        top: screenHeight * 0.06,
        left: 0.0,
        right: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black87,
                  size: 22,
                ),
                onPressed: (){
                  widget.handleDrawer();
                }),
            Container(
                height: screenHeight * 0.05,
                width: screenWidth * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Your Location',
                        hintStyle: TextStyle(
                          fontSize: 14
                        ),
                        // contentPadding: EdgeInsets.all(screenWidth * 0.025),
                        prefixIcon: Icon(Icons.circle, color: Color(0xFF49C1BD),size: 10,),
                        border: InputBorder.none
                      ),
                  )],
                )),
            Container(
                decoration:
                    BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white,
                    ),
                child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Colors.black87,
                      size: 20,
                    ),
                    onPressed: null)),
          ],
        ));
  }
}
