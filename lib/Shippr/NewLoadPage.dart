import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewLoadPage extends StatefulWidget {
  NewLoadPage();
  State<StatefulWidget> createState() {
    return _NewLoadPageState();
  }
}

class _NewLoadPageState extends State<NewLoadPage> {
  String dropoff, pickup, pickupDate, dropoffDate;
  double length, width, height, weight;
  getPickup(pickup) {
    this.pickup = pickup;
  }

  getDropoff(dropoff) {
    this.dropoff = dropoff;
  }

  getPickupDate(pickupDate) {
    this.pickupDate = pickupDate;
  }

  getDropoffDate(dropoffDate) {
    this.dropoffDate = dropoffDate;
  }

  getLength(length) {
    double feet = double.parse(length.substring(0, length.indexOf(',')).trim());
    double inches = double.parse(length.substring(length.indexOf(',')).trim());
    this.length = feet * inches / 12.0;
  }

  getWidth(width) {
    double feet = double.parse(width.substring(0, width.indexOf(',')).trim());
    double inches = double.parse(width.substring(width.indexOf(',')).trim());
    this.width = feet * inches / 12.0;
  }

  getHeight(height) {
    double feet = double.parse(height.substring(0, height.indexOf(',')).trim());
    double inches = double.parse(height.substring(height.indexOf(',')).trim());
    this.height = feet * inches / 12.0;
  }

  getWeight(weight) {
    this.weight = double.parse(weight);
  }

  int _myTaskType = 0;
  String type;

  void _handleLoadType(int value) {
    setState(() {
      _myTaskType = value;
      switch (_myTaskType) {
        case 1:
          type = 'Equipment & Machinery';
          break;
        case 2:
          type = 'Freight';
          break;
        case 3:
          type = 'Containers';
          break;
        case 4:
          type = 'hotshot';
          break;
        case 5:
          type = 'flatbed';
          break;
      }
    });
  }

  createData() {
    DocumentReference ds = Firestore.instance.collection('Load').document();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: <Widget>[
              Center(
                child: Text('Select Load Type: ',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 1,
                        groupValue: _myTaskType,
                        onChanged: _handleLoadType,
                        activeColor: Color(0xff4158ba),
                      ),
                      Text('Equipment & Machinery',
                          style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 2,
                        groupValue: _myTaskType,
                        onChanged: _handleLoadType,
                        activeColor: Color(0xff4158ba),
                      ),
                      Text('Freight', style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 3,
                        groupValue: _myTaskType,
                        onChanged: _handleLoadType,
                        activeColor: Color(0xff4158ba),
                      ),
                      Text('Container', style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        onChanged: (String pickup) {
                          getPickup(pickup);
                        },
                        decoration:
                            InputDecoration(labelText: "Pickup Address: "),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        onChanged: (String dropoff) {
                          getDropoff(dropoff);
                        },
                        decoration:
                            InputDecoration(labelText: "Dropoff Address: "),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        onChanged: (String pickupDate) {
                          getPickupDate(pickupDate);
                        },
                        decoration: InputDecoration(
                          labelText: "Pickup Date: ",
                          hintText: 'MM/DD/YY',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: TextField(
                        onChanged: (String dropoffDate) {
                          getDropoffDate(dropoffDate);
                        },
                        decoration: InputDecoration(
                          labelText: "Dropoff Date: ",
                          hintText: 'MM/DD/YY',
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 300.0),
                          child: TextField(
                            onChanged: (String length) {
                              getLength(length);
                            },
                            decoration: InputDecoration(
                              labelText: "Length: ",
                              hintText: 'Feet, Inches',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 300.0),
                          child: TextField(
                            onChanged: (String width) {
                              getWidth(width);
                            },
                            decoration: InputDecoration(
                              labelText: "Width: ",
                              hintText: 'Feet, Inches',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 300.0),
                          child: TextField(
                            onChanged: (String height) {
                              getHeight(height);
                            },
                            decoration: InputDecoration(
                              labelText: "Height: ",
                              hintText: 'Feet, Inches',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 300.0),
                          child: TextField(
                            onChanged: (String weight) {
                              getWeight(weight);
                            },
                            decoration: InputDecoration(
                              labelText: "Weight: ",
                              hintText: 'Lb',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white),
                            )),
                        RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              createData();
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 100.0,
                    )
                  ],
                ),
              )
            ],
          ),
          //here
        ),
      ),
    );
  }
}
