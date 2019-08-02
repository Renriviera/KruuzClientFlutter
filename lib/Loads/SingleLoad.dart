import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kruuz_client/HomePage.dart';

class SingleLoadPage extends StatefulWidget {
  final String loadId;
  SingleLoadPage({
    this.loadId,
  });
  State<StatefulWidget> createState() {
    return _SingleLoadPageState();
  }
}

class _SingleLoadPageState extends State<SingleLoadPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("View Load"),
        textTheme: TextTheme(
            title: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        )),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: new StreamBuilder(
          stream: Firestore.instance
              .collection('Load')
              .document('${widget.loadId}')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              print(snapshot.data);
              return new Text("Loading");
            }
            var singleLoad = snapshot.data;
            return new Padding(
              padding: EdgeInsets.all(10),
              child: Material(
                color: Colors.white,
                elevation: 14.0,
                shadowColor: Color(0x802196F3),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Load Type:',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${singleLoad['type']}',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Current value:',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ ${singleLoad['value']}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Highest current bid:',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Pickup on:',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${DateTime.fromMillisecondsSinceEpoch(singleLoad['pickupDate'].seconds * 1000)}',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Pickup Address:',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${singleLoad['pickupAddress']}',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Dropoff on:',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${DateTime.fromMillisecondsSinceEpoch(singleLoad['expirationDate'].seconds * 1000)}',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Dropoff Address:',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${singleLoad['dropoffAddress']}',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[Text('Dimensions')],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new RaisedButton(
                              child: new Text("Bid",
                                  style: new TextStyle(fontSize: 20.0)),
                              textColor: Colors.white,
                              color: Color.fromRGBO(242, 152, 54, 1),
                              onPressed: () {},
                            ),
                            new RaisedButton(
                              child: new Text("Accept",
                                  style: new TextStyle(fontSize: 20.0)),
                              color: Colors.lightBlue,
                              textColor: Colors.white,
                              onPressed: () async {
                                await Firestore.instance
                                    .runTransaction((Transaction tx) async {
                                  DocumentSnapshot postSnapshot = await tx.get(
                                      Firestore.instance
                                          .collection('Load')
                                          .document('${widget.loadId}'));
                                  print('${postSnapshot}');
                                  if (postSnapshot.exists) {
                                    await tx.update(
                                        Firestore.instance
                                            .collection('Load')
                                            .document('${widget.loadId}'),
                                        <String, dynamic>{
                                          'trucker': 'Andre Barle'
                                        });
                                  }
                                }).then((onValue) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return HomePage();
                                  }));
                                });
                              },
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
