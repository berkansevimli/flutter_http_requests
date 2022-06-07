import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextButton.icon(onPressed: (){}, icon: Icon(Icons.check), label: Text('Save'))
            ]),
          ),
        ));
  }
}
