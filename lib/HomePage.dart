import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Authentication.dart';
import 'LoadsPage.dart';
import 'NavigationPage.dart';
import 'DashPage.dart';
import 'PhotoUpload.dart';
import 'Banking.dart';
import 'CustomerSupport.dart';
import 'Preferences.dart';
import 'Schedule.dart';
import 'Fleet.dart';

class HomePage extends StatefulWidget {
  HomePage({
    this.user,
    this.auth,
    this.onSignedOut,
  });
  final String user;
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  //methods
//  Future<String> getUserEmail() async{
//    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    return user.email;
//  }
//  Future<String> getUserName() async{
//    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//    return user.email;
//  }
//
//  var email = getUserEmail();
//  var userName = user.displayName;

  int _currentIndex = 0;
  final List<Widget> _children = [NavigationPage(), DashPage(), LoadsPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //object description
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Kruuz"),
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        )),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Andre Barle"),
              accountEmail: Text("abarle2@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.directions_car),
                title: Text('Fleet'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FleetPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.thumb_up),
                title: Text('Preferences'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new PreferencesPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Schedule'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new SchedulePage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Banking'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new BankingPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.help),
                title: Text('Customer Support'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new CustomerSupportPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.camera_enhance),
                title: Text('Documentation'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return new UploadPhotoPage();
                  }));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.keyboard_return),
                title: Text('Logout'),
                onTap: () {
                  widget.onSignedOut();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedItemColor: Color.fromRGBO(242, 152, 54, 1),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('Nav'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Dash'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Loads'),
          ),
        ],
      ),
    );
  }
}
