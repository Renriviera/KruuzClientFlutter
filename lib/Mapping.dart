import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Authentication.dart';
import 'RolePage.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;
//  final String userID = '';
//  final FirebaseUser user;
  MappingPage({
//    this.user,
    this.auth,
  });
  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
//  void userInfo() async {
//    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    print(user.uid);
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
        authStatus = firebaseUserId == null
            ? AuthStatus.notSignedIn
            : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
      print(authStatus.toString());

      print("whats wrong...");
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginRegisterPage(
//          user: userID,
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new RolePage(
          //need to fix, its working with  MapPage though.
//          user: widget.user,
//          user: userID,
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}
