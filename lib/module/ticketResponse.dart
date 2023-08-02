// To parse this JSON data, do
//
//     final ticketResponse = ticketResponseFromJson(jsonString);

import 'dart:convert';

TicketResponse ticketResponseFromJson(String str) =>
    TicketResponse.fromJson(json.decode(str));

String ticketResponseToJson(TicketResponse data) => json.encode(data.toJson());

class TicketResponse {
  List<Body> body;
  String status;
  String message;

  var ticketResponse;

  TicketResponse({
    required this.body,
    required this.status,
    required this.message,
  });

  factory TicketResponse.fromJson(Map<String, dynamic> json) => TicketResponse(
        body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Body {
  int? id;
  String? title;
  String? description;
  String? type;
  String? status;
  DateTime? createdDate;
  dynamic userSubmittedCreatedDate;
  DateTime? updatedDate;
  DateTime? closedDate;
  String? closureComments;
  User? user;
  List<Comment> comments;
  List<dynamic> history;

  Body({
    required this.id,
    this.title,
    required this.description,
    this.type,
    required this.status,
    this.createdDate,
    this.userSubmittedCreatedDate,
    this.updatedDate,
    this.closedDate,
    this.closureComments,
    this.user,
    required this.comments,
    required this.history,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        status: json["status"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        userSubmittedCreatedDate: json["userSubmittedCreatedDate"],
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
        closedDate: json["closedDate"] == null
            ? null
            : DateTime.parse(json["closedDate"]),
        closureComments: json["closureComments"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        history: List<dynamic>.from(json["history"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "status": status,
        "createdDate": createdDate?.toIso8601String(),
        "userSubmittedCreatedDate": userSubmittedCreatedDate,
        "updatedDate": updatedDate?.toIso8601String(),
        "closedDate": closedDate?.toIso8601String(),
        "closureComments": closureComments,
        "user": user?.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "history": List<dynamic>.from(history.map((x) => x)),
      };
}

class Comment {
  int id;
  String comment;
  DateTime createdDate;
  int userId;
  String userName;

  Comment({
    required this.id,
    required this.comment,
    required this.createdDate,
    required this.userId,
    required this.userName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        createdDate: DateTime.parse(json["createdDate"]),
        userId: json["userId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "createdDate": createdDate.toIso8601String(),
        "userId": userId,
        "userName": userName,
      };
}

class User {
  int id;
  String email;
  String firstName;
  String lastName;
  dynamic otherNames;
  String primaryContactNo;
  dynamic secondaryContactNo;
  String userStatus;
  dynamic gender;
  String nicNumber;
  DateTime dateOfBirth;
  DateTime joinDate;
  dynamic leftDate;
  DateTime createdDate;
  Address address;
  dynamic bankDetails;
  dynamic designation;
  dynamic department;
  List<Role> roles;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.otherNames,
    required this.primaryContactNo,
    this.secondaryContactNo,
    required this.userStatus,
    this.gender,
    required this.nicNumber,
    required this.dateOfBirth,
    required this.joinDate,
    this.leftDate,
    required this.createdDate,
    required this.address,
    this.bankDetails,
    this.designation,
    this.department,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        otherNames: json["otherNames"],
        primaryContactNo: json["primaryContactNo"],
        secondaryContactNo: json["secondaryContactNo"],
        userStatus: json["userStatus"],
        gender: json["gender"],
        nicNumber: json["nicNumber"],
        dateOfBirth: DateTime.parse(json["dateOfBirth"]),
        joinDate: DateTime.parse(json["joinDate"]),
        leftDate: json["leftDate"],
        createdDate: DateTime.parse(json["createdDate"]),
        address: Address.fromJson(json["address"]),
        bankDetails: json["bankDetails"],
        designation: json["designation"],
        department: json["department"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "otherNames": otherNames,
        "primaryContactNo": primaryContactNo,
        "secondaryContactNo": secondaryContactNo,
        "userStatus": userStatus,
        "gender": gender,
        "nicNumber": nicNumber,
        "dateOfBirth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "joinDate":
            "${joinDate.year.toString().padLeft(4, '0')}-${joinDate.month.toString().padLeft(2, '0')}-${joinDate.day.toString().padLeft(2, '0')}",
        "leftDate": leftDate,
        "createdDate":
            "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "address": address.toJson(),
        "bankDetails": bankDetails,
        "designation": designation,
        "department": department,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}

class Address {
  int id;
  String addressLine1;
  String addressLine2;
  String city;
  String province;

  Address({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.province,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "province": province,
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
        privileges: List<Privilege>.from(
            json["privileges"].map((x) => Privilege.fromJson(x))),
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
