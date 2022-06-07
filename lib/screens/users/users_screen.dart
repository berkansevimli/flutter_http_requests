import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api/screens/users/model/model.dart';
import 'package:http/http.dart' as http;

import 'add_user/add_user.dart';

class GetUsersScreen extends StatefulWidget {
  const GetUsersScreen({Key? key}) : super(key: key);

  @override
  State<GetUsersScreen> createState() => _GetUsersScreenState();
}

class _GetUsersScreenState extends State<GetUsersScreen> {
  final url = Uri.parse('http://50.19.108.143:5000/users/');
  int counter = 0;
  var personalResult;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Users'),
      ),
      body: personalResult != null
          ? ListView.builder(
              itemCount: counter,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(personalResult.users[index].id.toString() +
                      ' ' +
                      personalResult.users![index].username),
                  subtitle: Text(personalResult.users![index].email),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddUser()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future fetchUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var result = await GetUsers.fromJson(json.decode(response.body));

        if (mounted) {
          setState(() {
            counter = result.users!.length;
            personalResult = result;
          });
        }
        return result;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
