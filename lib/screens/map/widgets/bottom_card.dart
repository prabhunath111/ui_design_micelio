import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final nearbyChargers;
  final createMarker;
  final updateCameraLocation;

  BottomCard({this.nearbyChargers, this.createMarker, this.updateCameraLocation});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return (nearbyChargers != null)
        ? Positioned(
            left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: Container(
              height: screenHeight * 0.25,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: nearbyChargers.length,
                  itemBuilder: (BuildContext context, int index) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        var destLat=nearbyChargers[index]['location']['coordinates'][0];
                        var destLng=nearbyChargers[index]['location']['coordinates'][1];
                        createMarker(destLat, destLng, false);
                        updateCameraLocation();
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/download.png',
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.05,
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      (nearbyChargers[index]['charger_id'] !=
                                              null)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6.0),
                                              child: Text(
                                                nearbyChargers[index]
                                                    ['charger_id'],
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            )
                                          : Container(),
                                      (nearbyChargers[index]['charger_name'] !=
                                              null)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6.0),
                                              child: Text(
                                                nearbyChargers[index]
                                                        ['charger_name']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                              ),
                                            )
                                          : Container(),
                                      (nearbyChargers[index]['chargerStatus'] !=
                                              null)
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6.0),
                                              child: Text(
                                                nearbyChargers[index]
                                                    ['chargerStatus'],
                                                style: TextStyle(
                                                    color: (nearbyChargers[
                                                                    index][
                                                                'chargerStatus'] ==
                                                            'available')
                                                        ? Colors.green
                                                        : (nearbyChargers[index]
                                                                    [
                                                                    'chargerStatus'] ==
                                                                'unavailable')
                                                            ? Colors.red
                                                            : Colors.black),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  width: screenWidth * 0.7,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    color: Color(0xFF49C1BD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                    child: Text(
                                      "BOOK NOW",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container();
  }
}
