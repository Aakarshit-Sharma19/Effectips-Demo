import 'dart:convert';
import 'package:effectips/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _email = '';
  String _password = '';
  final storage = new FlutterSecureStorage();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _proceedToHome() async {
    Navigator.pushReplacementNamed(context, Routes.home);
  }

  Future<void> _authenticateGoogle() async {
    await _googleSignIn.signIn().then((GoogleSignInAccount result) {
      result.authentication.then((GoogleSignInAuthentication googleKey) {
        print(googleKey.accessToken);
        print(googleKey.idToken);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully Logged In using Google'),
          ),
        );
        _proceedToHome();
      }).catchError((error) {
        print('Inner Error While Accessing Authentication \n $error');
      });
    }).catchError((error) {
      print('Outer Error while Signing In \n $error');
    });
  }

  Future<void> _authenticate() async {
    await http.post(
      Uri.parse('https://effectips.herokuapp.com/api/accounts/login/'),
      body: {'email': _email, 'password': _password},
    ).then((http.Response response) {
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        storage.write(key: 'access_token', value: body['access_token']);
        storage.write(key: 'refresh_token', value: body['refresh_token']);
        final snackBar = SnackBar(content: Text('Login Successful'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 400) {
        final snackBar = SnackBar(
            content: Text('Wrong Email or Password! Check and Try Again'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _proceedToHome();
      }
    }).catchError((error) {
      print('Cannot Log In \n($error)');
    });
  }

  @override
  void initState() {
    _googleSignIn.signInSilently().then((value) {
      final snackBar = SnackBar(content: Text('Welcome to Effectips'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      this._proceedToHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = SvgPicture.asset(
      'images/effectips-logo.svg',
      height: 250,
    );
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Text(
                'Welcome to Effectips',
                style: TextStyle(
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: logo,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    labelText: 'Email Address',
                  ),
                  onChanged: (String value) {
                    _email = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: 'Password',
                  ),
                  onChanged: (String value) {
                    _password = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: Text(
                  'Forgot Password',
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: Text(
                    'Login',
                  ),
                  onPressed: () {
                    _authenticate();
                  },
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: Row(children: [
                    Text(
                      'Login with Google',
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.android),
                  ], mainAxisAlignment: MainAxisAlignment.center),
                  onPressed: () {
                    _authenticateGoogle();
                  },
                ),
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  Text('Does not have account?'),
                  TextButton(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            ],
          )),
    ));
  }
}
