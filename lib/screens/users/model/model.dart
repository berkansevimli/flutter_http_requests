// To parse this JSON data, do
//
//     final GetUsers = GetUsersFromJson(jsonString);

import 'dart:convert';

GetUsers getUsersFromJson(String str) => GetUsers.fromJson(json.decode(str));

String getUsersToJson(GetUsers data) => json.encode(data.toJson());

class GetUsers {
    GetUsers({
        this.users,
    });

    List<User>? users;

    factory GetUsers.fromJson(Map<String, dynamic> json) => GetUsers(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

class User {
    User({
        this.id,
        this.username,
        this.email,
        this.password,
    });

    int? id;
    String? username;
    String? email;
    String? password;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
    };
}
