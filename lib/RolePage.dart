import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'Shippr/ShipprHomePage.dart';
import 'Authentication.dart';

class RolePage extends StatefulWidget {
  RolePage({
    this.user,
    this.auth,
    this.onSignedOut,
  });
  final String user;
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() {
    return _RolePageState();
  }
}

class _RolePageState extends State<RolePage> {
  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Color.fromRGBO(242, 152, 54, 0.8),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MaterialButton(
              height: MediaQuery.of(context).size.height / 2.2,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage(
                    user: widget.user,
                    auth: widget.auth,
                    onSignedOut: _logoutUser,
                  );
                }));
              },
              child: new Text(
                'Trucker',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              color: Color.fromRGBO(242, 152, 54, 1),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              height: MediaQuery.of(context).size.height / 2.2,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ShipprHomePage(
                    user: widget.user,
                    auth: widget.auth,
                    onSignedOut: _logoutUser,
                  );
                }));
              },
              child: new Text(
                'Shipper',
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              color: Color.fromRGBO(242, 152, 54, 1),
              elevation: 0.2,
            )
          ],
        ),
      ),
    );
  }
}
