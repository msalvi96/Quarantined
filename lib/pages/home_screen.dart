import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quarantined/pages/create_request.dart';
import 'package:quarantined/pages/information.dart';
import 'package:quarantined/pages/local_requests.dart';
import 'package:quarantined/widgets/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isLoading = false;
  Geolocator geolocator = Geolocator();
  Position userLocation;
  double latitude;
  double longitude;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    getLocation();
  }

  getLocation() async {
    setState(() {
      isLoading = true;
    });
    Position currentPosition = await geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("latitude", currentPosition.latitude);
    prefs.setDouble("longitude", currentPosition.longitude);
    setState(() {
      isLoading = false;
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
    });
    print(latitude);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? circularProgress() : Scaffold(
      appBar: AppBar(
        title: Text(
          'quarantined',
          style: GoogleFonts.fredokaOne(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
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
          LocalRequests(latitude: latitude, longitude: longitude),
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