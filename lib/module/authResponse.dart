// To parse this JSON data, do
//
//     final authResonse = authResonseFromJson(jsonString);

import 'dart:convert';

AuthResonse authResonseFromJson(String str) => AuthResonse.fromJson(json.decode(str));

String authResonseToJson(AuthResonse data) => json.encode(data.toJson());

class AuthResonse {
    Body body;
    String status;
    String message;

    AuthResonse({
        required this.body,
        required this.status,
        required this.message,
    });

    factory AuthResonse.fromJson(Map<String, dynamic> json) => AuthResonse(
        body: Body.fromJson(json["body"]),
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "body": body.toJson(),
        "status": status,
        "message": message,
    };
}

class Body {
    String jwt;
    User user;

    Body({
        required this.jwt,
        required this.user,
    });

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        jwt: json["jwt"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "user": user.toJson(),
    };
}

class User {
    int userId;
    String email;
    String firstName;
    String lastName;
    String userStatus;
    List<Role> roles;
    dynamic designation;

    User({
        required this.userId,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.userStatus,
        required this.roles,
        this.designation,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userStatus: json["userStatus"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "userStatus": userStatus,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "designation": designation,
    };
}

class Role {
    int id;
    String name;
    List<Privilege> privileges;

    Role({
        required this.id,
        required this.name,
        required this.privileges,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        privileges: List<Privilege>.from(json["privileges"].map((x) => Privilege.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "privileges": List<dynamic>.from(privileges.map((x) => x.toJson())),
    };
}

class Privilege {
    int id;
    String name;

    Privilege({
        required this.id,
        required this.name,
    });

    factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
