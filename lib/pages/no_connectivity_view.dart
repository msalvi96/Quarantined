import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:quarantined/pages/home_screen.dart';
import 'package:quarantined/widgets/progress.dart';

class NoConnectivityView extends StatefulWidget {
  NoConnectivityView({Key key}) : super(key: key);

  @override
  _NoConnectivityViewState createState() => _NoConnectivityViewState();
}

class _NoConnectivityViewState extends State<NoConnectivityView> {
  bool isConnected = false;

  checkConnection() async {
    ConnectivityResult res = await Connectivity().checkConnectivity();
    if (res == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text("No Internet Connection"),
            ),
          );
        }
      );
    } else {
      setState(() {
        isConnected = true;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'No Internet',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: checkConnection,
                child: Text(
                  "Check Network Connection",
                ),
              ),
            ),
            isConnected == false ? circularProgress() : SnackBar(content: Container(
              child: Text("Internet Connection Established")
            )),
          ],
        ),
      ),
    );
  }
}