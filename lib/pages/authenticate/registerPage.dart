import 'package:dsixv02app/models/service/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();

  //Text Field State

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //sign In Anom
        Container(
          width: 200,
          height: 200,
          color: Colors.amber,
          child: GestureDetector(
              onTap: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('error');
                } else {
                  print('sign in');
                  print(result.uid);
                }
              },
              child: Text('SIGN UP')),
        ),

//Sign In E-mail

        Container(
          color: Colors.pink,
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          onPressed: () async {
            print(email);
            print(password);
          },
          color: Colors.amber,
          child: Text('REGISTER'),
        )
      ],
    );
  }
}
