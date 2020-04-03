import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quarantined/models/essentials.dart';
import 'package:quarantined/models/grocery.dart';
import 'package:quarantined/models/user.dart';
import 'package:quarantined/pages/root.dart';
import 'package:quarantined/utils/auth.dart';
import 'package:quarantined/utils/requests.dart';
import 'package:quarantined/utils/user.dart';
import 'package:quarantined/widgets/progress.dart';

class LocalRequests extends StatefulWidget {
  LocalRequests({Key key}) : super(key: key);

  @override
  _LocalRequestsState createState() => _LocalRequestsState();
}

class _LocalRequestsState extends State<LocalRequests> {
  List<dynamic> req = new List<dynamic>();
  User currentUser;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getRequests();
  }

  getCurrentUser() async {
    setState(() {
      isLoading = true;
    });
    var userId = await authService.userID();
    print(userId);
    DocumentSnapshot snap = await UserService().getUserById(userId);
    currentUser = User.fromDocument(snap);
    print(currentUser.latitude);
    print(currentUser.longitude);
    print(currentUser.displayName);
    setState(() {
      isLoading = false;
    });
  }


  // getRequests() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var userId = await authService.userID();
  //   DocumentSnapshot snap = await UserService().getUserById(userId);
  //   currentUser = User.fromDocument(snap);

  //   var nearby;
  //   await for (List<dynamic> request in RequestService().getRequestFromFirestore()) {
  //     // print(request);
  //     // setState(() {
  //     //   req = request;
  //     // });
  //     for (int index = 0; index < request.length; index++) {
  //       // req.add(request[index]);
  //       // req.add(value)
  //       nearby = await checkDistance(request[index]);
  //       print('nearby $nearby km');
  //       req.add(request[index]);
  //     }
  //   }
  //   print(req);
  //   // List<dynamic> req1 = await RequestService().getRequestFromFirestore();
  //   // print(req1);

  //   // for (int index = 0; index < req.length; index++) {
  //   //   nearby = await checkDistance(req[index]['latitude'], req[index]['longitude']);
  //   //   print('nearby $nearby km');
  //   //   req.add(req[index]);
  //   // }
  //   setState(() {
  //     isLoading = false;
  //   });
  //   print(req.length);
  // }

  checkDistance(request) async {
    double distanceInMeters = await Geolocator().distanceBetween(currentUser.latitude, currentUser.longitude, request.latitude, request.longitude);
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
          if (snapshot.data < 25) {
            return ListTile(
              title: Text(snapshot.toString()),
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
        } else if (!snapshot.hasData) {
          return circularProgress();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data < 25) {
            return ListTile(
              title: Text(request.type),
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
      stream: requestService.allRequests,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Text("Error: ${asyncSnapshot.error}");
        } else if (asyncSnapshot.data == null) {
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
              }
            },
          );
        }
      },
    );
  }
}