import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/constants.dart';
import 'package:flutter_api/screens/users/model/model.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? username;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      username = newValue;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      email = newValue;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                TextFormField(
                  onSaved: (newValue) {
                    setState(() {
                      password = newValue;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Map<String, dynamic> data = {
                        //   'data': {
                        //     "username": username,
                        //     "firstname": "Emre Can",
                        //     "lastname": "Karataş",
                        //     "user_type": "admin",
                        //     "time": DateTime.now().toString(),
                        //     "email": email,
                        //     "img": "default",
                        //     "bio": "I am Emre Can",
                        //     "phonenumber": "05436256481",
                        //     "uniid": 1,
                        //     "uniname": "Özyeğin Üniversitesi",
                        //     "faculty": "Engineering",
                        //     "department": "CS",
                        //     "grade": "Hazırlık",
                        //     "blocks": {},
                        //     "uid": username
                        //   }
                        // };
                        Map<String, dynamic> data = {
                          'data': {
                            "uid": username,
                            "randomKey":
                                "528f97527e4d45119065c352fd8d93016c4847f1fb1bc68a59fd6bf752cc2b2e",
                            "devicename": "Iphone 12"
                          }
                        };

                        String timestamp = "2022-06-29 18:48:38.971523+00";
                        DateTime time = DateTime.parse(timestamp);
                        print(time.hour);

                        try {
                          final response = await http.post(loginPath,
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                                'Authorization':
                                    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE2NTY0MzMxNjJ9.LW6PLHA-CicEIBDfOTa165Uy-Dj-hivrM9hlm79xh1A'
                              },
                              body: json.encode(data));

                          print(response.body);

                          if (response.statusCode == 201) {
                            Navigator.pop(context);
                          } else {
                            print(response.statusCode);
                          }
                        } catch (e) {
                          print(e.toString() + " jjj");
                        }
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
