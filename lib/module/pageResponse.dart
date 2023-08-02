// To parse this JSON data, do
//
//     final pageResponse = pageResponseFromJson(jsonString);

import 'dart:convert';

PageResponse pageResponseFromJson(String str) =>
    PageResponse.fromJson(json.decode(str));

String pageResponseToJson(PageResponse data) => json.encode(data.toJson());

class PageResponse {
  int? totalPages;
  int? totalElements;
  int? size;
  List<Content>? content;
  int? number;
  Sort? sort;
  bool? first;
  bool? last;
  int? numberOfElements;
  Pageable? pageable;
  bool? empty;

  PageResponse({
    this.totalPages,
    this.totalElements,
    this.size,
    this.content,
    this.number,
    this.sort,
    this.first,
    this.last,
    this.numberOfElements,
    this.pageable,
    this.empty,
  });

  factory PageResponse.fromJson(Map<String, dynamic> json) => PageResponse(
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        size: json["size"],
        content: json["content"] == null
            ? []
            : List<Content>.from(
                json["content"]!.map((x) => Content.fromJson(x))),
        number: json["number"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        first: json["first"],
        last: json["last"],
        numberOfElements: json["numberOfElements"],
        pageable: json["pageable"] == null
            ? null
            : Pageable.fromJson(json["pageable"]),
        empty: json["empty"],
      );

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "totalElements": totalElements,
        "size": size,
        "content": content == null
            ? []
            : List<dynamic>.from(content!.map((x) => x.toJson())),
        "number": number,
        "sort": sort?.toJson(),
        "first": first,
        "last": last,
        "numberOfElements": numberOfElements,
        "pageable": pageable?.toJson(),
        "empty": empty,
      };
}

class Content {
  int? id;
  String? title;
  String? description;
  String? type;
  String? status;
  DateTime? createdDate;
  DateTime? userSubmittedCreatedDate;
  DateTime? updatedDate;
  DateTime? closedDate;
  String? closureComments;
  User? user;
  List<Comment>? comments;
  List<History>? history;

  Content({
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

  factory Content.fromJson(Map<String, dynamic> json) => Content(
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
        updatedDate: json["updatedDate"] == null
            ? null
            : DateTime.parse(json["updatedDate"]),
        closedDate: json["closedDate"] == null
            ? null
            : DateTime.parse(json["closedDate"]),
        closureComments: json["closureComments"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
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
        "updatedDate": updatedDate?.toIso8601String(),
        "closedDate": closedDate?.toIso8601String(),
        "closureComments": closureComments,
        "user": user?.toJson(),
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "history": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
      };
}

class Comment {
  int? id;
  String? comment;
  DateTime? createdDate;
  int? userId;
  String? userName;

  Comment({
    this.id,
    this.comment,
    this.createdDate,
    this.userId,
    this.userName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        userId: json["userId"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "createdDate": createdDate?.toIso8601String(),
        "userId": userId,
        "userName": userName,
      };
}

class History {
  int? id;
  String? oldStatus;
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
  String? otherNames;
  String? primaryContactNo;
  String? secondaryContactNo;
  String? userStatus;
  String? gender;
  String? nicNumber;
  DateTime? dateOfBirth;
  DateTime? joinDate;
  DateTime? leftDate;
  DateTime? createdDate;
  Address? address;
  BankDetails? bankDetails;
  Designation? designation;
  Department? department;
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
        leftDate:
            json["leftDate"] == null ? null : DateTime.parse(json["leftDate"]),
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        bankDetails: json["bankDetails"] == null
            ? null
            : BankDetails.fromJson(json["bankDetails"]),
        designation: json["designation"] == null
            ? null
            : Designation.fromJson(json["designation"]),
        department: json["department"] == null
            ? null
            : Department.fromJson(json["department"]),
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
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "joinDate": joinDate?.toIso8601String(),
        "leftDate": leftDate?.toIso8601String(),
        "createdDate": createdDate?.toIso8601String(),
        "address": address?.toJson(),
        "bankDetails": bankDetails?.toJson(),
        "designation": designation?.toJson(),
        "department": department?.toJson(),
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

class BankDetails {
  int? id;
  String? accountNo;
  String? bankName;
  String? bankBranch;
  String? bankAccountType;

  BankDetails({
    this.id,
    this.accountNo,
    this.bankName,
    this.bankBranch,
    this.bankAccountType,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        id: json["id"],
        accountNo: json["accountNo"],
        bankName: json["bankName"],
        bankBranch: json["bankBranch"],
        bankAccountType: json["bankAccountType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountNo": accountNo,
        "bankName": bankName,
        "bankBranch": bankBranch,
        "bankAccountType": bankAccountType,
      };
}

class Department {
  int? id;
  String? name;
  String? agency;

  Department({
    this.id,
    this.name,
    this.agency,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
        agency: json["agency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "agency": agency,
      };
}

class Designation {
  int? id;
  String? designationName;
  String? designationLevel;

  Designation({
    this.id,
    this.designationName,
    this.designationLevel,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        id: json["id"],
        designationName: json["designationName"],
        designationLevel: json["designationLevel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "designationName": designationName,
        "designationLevel": designationLevel,
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
  List<String>? roles;

  Privilege({
    this.id,
    this.name,
    this.roles,
  });

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
        id: json["id"],
        name: json["name"],
        roles: json["roles"] == null
            ? []
            : List<String>.from(json["roles"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
      };
}

class Pageable {
  int? offset;
  Sort? sort;
  int? pageSize;
  int? pageNumber;
  bool? paged;
  bool? unpaged;

  Pageable({
    this.offset,
    this.sort,
    this.pageSize,
    this.pageNumber,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        offset: json["offset"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        pageSize: json["pageSize"],
        pageNumber: json["pageNumber"],
        paged: json["paged"],
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "sort": sort?.toJson(),
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        "paged": paged,
        "unpaged": unpaged,
      };
}

class Sort {
  bool? empty;
  bool? sorted;
  bool? unsorted;

  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
      };
}
