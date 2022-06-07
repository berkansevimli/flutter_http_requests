import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/constants.dart';
import 'package:flutter_api/screens/users/model/model.dart';
import 'package:flutter_api/screens/users/widgets/swipeable.dart';
import 'package:http/http.dart' as http;

import 'add_user/add_user.dart';

class GetUsersScreen extends StatefulWidget {
  const GetUsersScreen({Key? key}) : super(key: key);

  @override
  State<GetUsersScreen> createState() => _GetUsersScreenState();
}

class _GetUsersScreenState extends State<GetUsersScreen> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchUsers();
            },
          )
        ],
      ),
      body: personalResult != null
          ? Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListView.builder(
                itemCount: counter,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: Swipeable(
                      threshold: 60.0,
                      onSwipeLeft: () {
                        print("edit");
                      },
                      onSwipeRight: () {
                        showDialog(context: context, builder: (builder)=>CupertinoAlertDialog(
                          title: Text("Delete"),
                          content: Text("Are you sure you want to delete this user?"),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("Cancel"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("Delete"),
                              onPressed: (){
                                Navigator.of(context).pop();
                                deleteUser(personalResult.users[index].id, context);
                              },
                            )
                          ],
                        ));
                      },
                      background: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                              "${personalResult.users[index].id.toString()} ${personalResult.users![index].username}"),
                          subtitle: Text(personalResult.users![index].email),
                          leading: Icon(Icons.delete, color: Colors.red),
                          trailing: Icon(Icons.edit, color: Colors.blue),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            color: Colors.white),
                        child: ListTile(
                          title: Text(
                              "${personalResult.users[index].id.toString()} ${personalResult.users![index].username}"),
                          subtitle: Text(personalResult.users![index].email),
                          onTap: () {
                            print(personalResult.users[index].id);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => AddUser()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Future deleteUser(int id, BuildContext bContext) async {
    final deleteUrl = Uri.parse(deleteUserLink.toString() + id.toString());
    try {
      final response = await http.delete(deleteUrl);
      if (response.statusCode == 200) {
        fetchUsers();
        print(response.body);
        showDialog(context: bContext, builder: (builder)=>CupertinoAlertDialog(
          title: Text("Success"),
          content: Text("User deleted successfully"),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        ));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future fetchUsers() async {
    try {
      final response = await http.get(getUserLink);
      if (response.statusCode == 200) {
        var result = await UserModel.fromJson(json.decode(response.body));

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
