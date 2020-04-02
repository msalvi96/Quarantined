import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quarantined/pages/home_screen.dart';
import 'package:quarantined/utils/auth.dart';

String currentUser;

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  // TabController _tabController;
  // bool isAuth = false;
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  void initState() { 
    super.initState();
    authService.profile.listen((state) => setState(() => _profile = state));
    authService.loading.listen((state) => setState(() => _loading = state));
    
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).primaryColorDark,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorLight,
              Theme.of(context).accentColor,
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'quarantineAid',
              style: GoogleFonts.fredokaOne(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SignInButton(
              Buttons.Google,
              text: "Sign In with Google",
              onPressed: () => authService.googleSignIn(),
            )
      ],)
    ),);
  }

  @override
  Widget build(BuildContext context) {
    // return isAuth ? HomeScreen() : buildUnAuthScreen();
    return StreamBuilder(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          currentUser = _profile['uid'];
          return HomeScreen();
        } else {
          return buildUnAuthScreen();
        }
      },
    );
  }
}