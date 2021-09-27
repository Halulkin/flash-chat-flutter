import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/constants.dart';
import 'package:flash/screens/chat_screen.dart';
import 'package:flash/screens/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: false,
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _showSpinner,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter your email")),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter your password")),
                  SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      color: Colors.blueAccent,
                      title: 'Register',
                      onPressed: () async {
                        setState(() {
                          _showSpinner = true;
                        });
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushNamed(context, ChatScreen.id);
                          setState(() {
                            _showSpinner = false;
                          });
                        } catch (e) {
                          setState(() {
                            _showSpinner = false;
                          });
                          print(e);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
