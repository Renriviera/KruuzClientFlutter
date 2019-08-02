import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'DialogBox.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({this.auth, this.onSignedIn});
//  final String user;
  final AuthImplementation auth;
  final VoidCallback onSignedIn;
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegisterPage> {
  //Methods
  DialogBox dialogBox = new DialogBox();
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.SignIn(_email, _password);
          print("login userId = " + userId);
//          user = userId;
        } else {
          String userId = await widget.auth.SignUp(_email, _password);
          dialogBox.information(context, "Congratulations!",
              "Your account has been created successfully, please verify your email address.");
          print("Register userId =" + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        dialogBox.information(context, "Error = ", e.toString());
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

//Object Design
  @override
  Widget build(BuildContext context) {
    {
      return new Scaffold(
//        appBar: new AppBar(title: new Text("Kruuz")),
        body: new Container(
          margin: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: new Form(
              key: formKey,
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createInputs() + createButtons()),
            ),
          ),
        ),
      );
    }
  }

  List<Widget> createInputs() {
    return [
//      SizedBox(
//        height: 10.0,
//      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) {
          return value.isEmpty ? 'Email is required.' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password is required.' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return new Hero(
      tag: 'hero',
      child: Image.asset('images/KruuzM.png'),
    );
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text("Login", style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Color.fromRGBO(242, 152, 54, 1),
          onPressed: validateAndSubmit,
        ),
        new RaisedButton(
          child: new Text("Don't have an Account? Create one here!",
              style: new TextStyle(fontSize: 16.0)),
          color: Color.fromRGBO(242, 152, 54, 1),
          textColor: Colors.white,
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child:
              new Text("Create Account", style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Color.fromRGBO(242, 152, 54, 1),
          onPressed: validateAndSubmit,
        ),
        new RaisedButton(
          child: new Text("Already have an Account? Login here!",
              style: new TextStyle(fontSize: 16.0)),
          color: Color.fromRGBO(242, 152, 54, 1),
          textColor: Colors.white,
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
