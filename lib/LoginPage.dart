import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stringer/FirstScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  String _error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  onSaved: (String value) {
                    _email = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "E-Mail"),
                ),
                TextFormField(
                  onSaved: (String value) {
                    _password = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "This field can't be empty , and to be more than 6 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Password"),
                ),
                RaisedButton(
                  onPressed: () {
                    _formKey.currentState.validate();
                    _formKey.currentState.save();

                    register(_email, _password).then((FirebaseUser user) {
                      if (user.toString().isNotEmpty) {
                        toFirstScreen(user.email);
                      }
                    }).catchError((e) {
                      setState(() {
                        _error = e.message;
                      });
                    });
                  },
                ),
                Text(_error),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> register(newEmail, newPassword) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: newEmail, password: newPassword);
    return user;
  }

  toFirstScreen(String user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FirstScreen(user)));
  }
}
