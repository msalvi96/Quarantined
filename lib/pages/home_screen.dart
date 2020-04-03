import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quarantined/models/user.dart';
import 'package:quarantined/pages/create_request.dart';
import 'package:quarantined/pages/information.dart';
import 'package:quarantined/pages/local_requests.dart';
import 'package:quarantined/utils/auth.dart';
import 'package:quarantined/utils/requests.dart';
import 'package:quarantined/utils/user.dart';
import 'package:quarantined/widgets/progress.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLoading = false;
  User currentUser;
  Geolocator geolocator = Geolocator();
  Position userLocation;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getCurrentUser();
  }


  Future<Position> _getLocation() async {
    var currentPosition;
    try {
      currentPosition = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      Navigator.pop(context, currentPosition);
    } catch (e) {
      print(e);
      currentPosition = null;
    }
  }

  getCurrentUser() async {
    setState(() {
      isLoading = true;
    });
    var userId = await authService.userID();
    print(userId);
    DocumentSnapshot snap = await UserService().getUserById(userId);
    User user = User.fromDocument(snap);
    print(user.latitude);
    print(user.longitude);
    print(user.displayName);
    if (user.geoPoint == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Request"),
            content: Text("Quarantined would like access to your location"),
            actions: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    RaisedButton.icon(
                      onPressed: () => _getLocation(),
                      icon: Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Use Current Location",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Theme.of(context).primaryColorDark,
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ).then((val) async {
        setState(() {
          userLocation = val;
        });
        DocumentSnapshot userSnap = await UserService().updateUserProfile(user.uid, userLocation.latitude, userLocation.longitude);
        currentUser = User.fromDocument(userSnap);
        print(currentUser.latitude);
        print(currentUser.displayName);
        print(currentUser.longitude);
        print(currentUser.geoPoint.latitude);
      });
      setState(() {
        isLoading = false;
      });
    } else {
      currentUser = user;
      setState(() {
        isLoading = false;
      });
    }
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'quarantined',
          style: GoogleFonts.fredokaOne(),
        ),
        bottom: TabBar(
          tabs: [
            Tab(
              text: "Info",
              icon: Icon(Icons.all_inclusive),
            ),
            Tab(
              text: "Requests",
              icon: Icon(Icons.notifications_active),
            ),
          ],
          controller: _tabController,
        ),
        centerTitle: true,
      ),
      body: isLoading ? circularProgress() : TabBarView(
        children: <Widget>[
          InformationPage(),
          LocalRequests(),
          // Container(),
        ],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRequests()));
        },
        label: Text("Create New Requests"),
        icon: Icon(Icons.queue),
        elevation: 20.0,
      ),
    );
  }
}