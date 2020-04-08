import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quarantined/models/essentials.dart';
import 'package:quarantined/models/general.dart';
import 'package:quarantined/models/grocery.dart';
import 'package:quarantined/models/organization.dart';
import 'package:quarantined/utils/requests.dart';
import 'package:quarantined/widgets/progress.dart';

class LocalRequests extends StatefulWidget {
  double latitude;
  double longitude;

  LocalRequests({ this.latitude, this.longitude });

  @override
  _LocalRequestsState createState() => _LocalRequestsState();
}

class _LocalRequestsState extends State<LocalRequests> {
  List<dynamic> req = new List<dynamic>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  checkDistance(request) async {
    double distanceInMeters = await Geolocator().distanceBetween(widget.latitude, widget.longitude, request.latitude, request.longitude);
    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm;
  }

  buildEssentialCard(Essentials request) {
    return FutureBuilder(
      future: checkDistance(request),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          if (snapshot.data < 20) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.red),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: Icon(Icons.priority_high, color: Colors.white,),
                  ),
                  title: Text(request.type, style: TextStyle(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Row(
                    children: <Widget>[
                      Text(request.description),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }

  buildGroceryCard(Grocery request) {
    return FutureBuilder(
      future: checkDistance(request),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
          return circularProgress();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data < 20) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: Icon(Icons.local_grocery_store, color: Colors.white,),
                  ),
                  title: Text(request.type, style: TextStyle(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Row(
                    children: <Widget>[
                      DataTable(
                        columns: [
                          DataColumn(label: Text("Index")),
                          DataColumn(label: Text("Items")),
                        ],
                        rows: request.cart.asMap().entries.map((entry) {
                          int index = entry.key;
                          String val = entry.value;

                          return DataRow(
                            cells: [
                              DataCell(Text(index.toString())),
                              DataCell(Text(val)),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return circularProgress();
        }
      },
    );
  }

  buildGeneralCard(General request) {
    return FutureBuilder(
      future: checkDistance(request),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
          return circularProgress();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data < 20) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: Icon(Icons.notifications, color: Colors.white,),
                  ),
                  title: Text(request.type, style: TextStyle(
                    color: Colors.white24,
                    fontWeight: FontWeight.bold,
                  ),),
                  subtitle: Text(request.title),
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return circularProgress();
        }
      },
    );
  }

  buildOrganizationCard(Organization request) {
    return FutureBuilder(
      future: checkDistance(request),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else if (!snapshot.hasData || snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
          return circularProgress();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data < 20) {
            return Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.green),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                      border: new Border(
                        right: new BorderSide(width: 1.0, color: Colors.white),
                      ),
                    ),
                    child: Icon(Icons.business_center, color: Colors.white,),
                  ),
                  title: Text('Organization', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            );
          } else {
            return Container();
          }
        } else {
          return circularProgress();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: requestService.getRequestFromFirestore(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Text("Error: ${asyncSnapshot.error}");
        } else if (asyncSnapshot.data == null || asyncSnapshot.connectionState == ConnectionState.waiting) {
          return circularProgress();
        } else {
          return new ListView.builder(
            shrinkWrap: true,
            itemCount: asyncSnapshot.data.length,
            itemBuilder: (context, int index) {
              if (asyncSnapshot.data[index] is Essentials) {
                Essentials request = asyncSnapshot.data[index];
                return buildEssentialCard(request);
              } else if (asyncSnapshot.data[index] is Grocery) {
                Grocery request = asyncSnapshot.data[index];
                return buildGroceryCard(request);
              } else if (asyncSnapshot.data[index] is General) {
                General request = asyncSnapshot.data[index];
                return buildGeneralCard(request);
              } else if (asyncSnapshot.data[index] is Organization) {
                Organization request = asyncSnapshot.data[index];
                return buildOrganizationCard(request);
              }
            },
          );
        }
      },
    );
  }
}