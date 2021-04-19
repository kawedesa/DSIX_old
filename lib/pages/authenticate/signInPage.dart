import 'package:dsixv02app/models/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();

  //Text Field State

  String email = '';
  String password = '';

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 2.5, //                   <--- border width here
                  ),
                ),
                width: 300,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[700],
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 7),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontFamily: 'Headline',
                                height: 1.3,
                                fontSize: 25.0,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        ),
                        onPressed: () async {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.058,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[400],
                              width:
                                  2, //                   <--- border width here
                            ),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.grey[400],
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Center(
                                child: Text(
                                  'CONFIRM',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontFamily: 'Calibri',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        ),
        onPressed: () {
          showAlertDialog(context);
          // Navigator.of(context).push(_createRoute());
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.width * 0.62,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[600],
              width: 2.5, //                   <--- border width here
            ),
          ),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey[600],
                      size: 30,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Center(
                  child: Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontFamily: 'Calibri',
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
//     return Column(
//       children: [
//         //sign In Anom
//         Container(
//           width: 200,
//           height: 200,
//           color: Colors.amber,
//           child: GestureDetector(
//               onTap: () async {
//                 dynamic result = await _auth.signInAnon();
//                 if (result == null) {
//                   print('error');
//                 } else {
//                   print('sign in');
//                   print(result.uid);
//                 }
//               },
//               child: Text('SIGN IN')),
//         ),

// //Sign In E-mail

//       ],
//     );
  }
}
