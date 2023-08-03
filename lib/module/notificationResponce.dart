// To parse this JSON data, do
//
//     final notificationResponce = notificationResponceFromJson(jsonString);

import 'dart:convert';

NotificationResponce notificationResponceFromJson(String str) =>
    NotificationResponce.fromJson(json.decode(str));

String notificationResponceToJson(NotificationResponce data) =>
    json.encode(data.toJson());

class NotificationResponce {
  Body? body;
  String? status;
  String? message;

  NotificationResponce({
    this.body,
    this.status,
    this.message,
  });

  factory NotificationResponce.fromJson(Map<String, dynamic> json) =>
      NotificationResponce(
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "body": body?.toJson(),
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
  DateTime? userSubmittedCreatedDate;
  dynamic updatedDate;
  dynamic closedDate;
  dynamic closureComments;
  User? user;
  dynamic comments;
  List<History>? history;

  Body({
    this.id,
    this.title,
    this.description,
    this.type,
    this.status,
    this.createdDate,
    this.userSubmittedCreatedDate,
    this.updatedDate,
    this.closedDate,
    this.closureComments,
    this.user,
    this.comments,
    this.history,
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
        userSubmittedCreatedDate: json["userSubmittedCreatedDate"] == null
            ? null
            : DateTime.parse(json["userSubmittedCreatedDate"]),
        updatedDate: json["updatedDate"],
        closedDate: json["closedDate"],
        closureComments: json["closureComments"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        comments: json["comments"],
        history: json["history"] == null
            ? []
            : List<History>.from(
                json["history"]!.map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "status": status,
        "createdDate": createdDate?.toIso8601String(),
        "userSubmittedCreatedDate": userSubmittedCreatedDate?.toIso8601String(),
        "updatedDate": updatedDate,
        "closedDate": closedDate,
        "closureComments": closureComments,
        "user": user?.toJson(),
        "comments": comments,
        "history": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}

class History {
  int? id;
  dynamic oldStatus;
  String? newStatus;
  DateTime? date;

  History({
    this.id,
    this.oldStatus,
    this.newStatus,
    this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        oldStatus: json["oldStatus"],
        newStatus: json["newStatus"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "oldStatus": oldStatus,
        "newStatus": newStatus,
        "date": date?.toIso8601String(),
      };
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  dynamic otherNames;
  String? primaryContactNo;
  dynamic secondaryContactNo;
  String? userStatus;
  dynamic gender;
  String? nicNumber;
  DateTime? dateOfBirth;
  DateTime? joinDate;
  dynamic leftDate;
  DateTime? createdDate;
  Address? address;
  dynamic bankDetails;
  dynamic designation;
  dynamic department;
  List<Role>? roles;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.otherNames,
    this.primaryContactNo,
    this.secondaryContactNo,
    this.userStatus,
    this.gender,
    this.nicNumber,
    this.dateOfBirth,
    this.joinDate,
    this.leftDate,
    this.createdDate,
    this.address,
    this.bankDetails,
    this.designation,
    this.department,
    this.roles,
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
        dateOfBirth: json["dateOfBirth"] == null
            ? null
            : DateTime.parse(json["dateOfBirth"]),
        joinDate:
            json["joinDate"] == null ? null : DateTime.parse(json["joinDate"]),
        leftDate: json["leftDate"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        bankDetails: json["bankDetails"],
        designation: json["designation"],
        department: json["department"],
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
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
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "joinDate":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "leftDate": leftDate,
        "createdDate":
            "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "address": address?.toJson(),
        "bankDetails": bankDetails,
        "designation": designation,
        "department": department,
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Address {
  int? id;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? province;

  Address({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.province,
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
  int? id;
  String? name;
  List<Privilege>? privileges;

  Role({
    this.id,
    this.name,
    this.privileges,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        privileges: json["privileges"] == null
            ? []
            : List<Privilege>.from(
                json["privileges"]!.map((x) => Privilege.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "privileges": privileges == null
            ? []
            : List<dynamic>.from(privileges!.map((x) => x.toJson())),
      };
}

class Privilege {
  int? id;
  String? name;

  Privilege({
    this.id,
    this.name,
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
