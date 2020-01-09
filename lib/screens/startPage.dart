import 'dart:convert';

import 'package:clima/screens/experiment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogged = false;
  FirebaseUser myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 180,
              width: 180,
              child: Center(
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
              margin: EdgeInsets.all(15.0),
            ),
            SizedBox(height: 5),
            SizedBox(height: 5),
            GestureDetector(
             /* onTap: () async {
                final facebookLogin = FacebookLogin();
                final result =
                    await facebookLogin.logInWithReadPermissions(['email']);
                if (result.status == FacebookLoginStatus.loggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                }
              },*/
              child: Container(
                child: Center(
                  child: Text(
                    'ENTRAR CON FACEBOOK',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF404097),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
             /* onTap: () async {
                var twitterLogin = new TwitterLogin(
                    consumerKey: 'YahZaFE3lW4almKkjSJErlo9K',
                    consumerSecret:
                        'gaDEs957pWN1YfYpJ1JNxDVTrgdNOGOTVtC8jiCCGf9RSwgxlC');
                final TwitterLoginResult result =
                    await twitterLogin.authorize();
                if (result.status == TwitterLoginStatus.loggedIn){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                }
              },*/
              child: Container(
                child: Center(
                  child: Text(
                    'ENTRAR CON TWITTER',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF404097),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
