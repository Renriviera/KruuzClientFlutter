import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotoPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UploadPhotoPageState();
  }
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  final formKey = new GlobalKey<FormState>();
  String _myValue;
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload Documents"),
        centerTitle: true,
      ),
      body: new Center(
          child:
              sampleImage == null ? Text("Select an Image") : enableUpload()),
      floatingActionButton: new FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Add Image',
          child: new Icon(Icons.add_a_photo)),
    );
  }

  Widget enableUpload() {
    return new Container(
      child: new Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Image.file(sampleImage, height: 330.0, width: 600.0),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'),
              validator: (value) {
                return value.isEmpty ? 'Description is required' : null;
              },
              onSaved: (value) {
                return _myValue = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            RaisedButton(
              elevation: 10.0,
              child: Text("Upload Relevant Documents"),
              textColor: Colors.white,
              color: Color.fromRGBO(242, 152, 54, 1),
              onPressed: validateAndSave,
            ),
          ],
        ),
      ),
    );
  }
}
