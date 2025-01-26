import 'package:flutter/foundation.dart';

const String tblUser = "User";

const String tblUserName = 'name';
const String tblUserOffice = 'office';
const String tblUserPhone = 'phone';
const String tblUserID = 'userid';
const String tblUserEmail = 'email';
const String tblUserPosition = 'position';
const String tblUserRole = 'role';
const String tblUserAddress = 'address';
const String tblUserType = 'type';
const String tblUserpass = 'password';
const String tblUserArea = 'area';

class UserModel {
  String userType;
  String? userid;
  String? name;
  String? office;
  String? phone;
  String? email;
  String? position;
  String? role;
  String? address;
  String? password;
  String? area;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.office,
    this.phone,
    this.position,
    this.role,
    this.userid,
    this.address,
    required this.userType,
    this.area
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      tblUserType: userType,
      tblUserEmail: email,
      tblUserName: name,
      tblUserpass: password,
      tblUserOffice: office,
      tblUserPhone: phone,
      tblUserPosition: position,
      tblUserRole: role,
      tblUserID: userid,
      tblUserAddress: address,
      tblUserArea: area,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    userType: map[tblUserType],
    email: map[tblUserEmail],
    name: map[tblUserName],
    password: map[tblUserpass],
    office: map[tblUserOffice],
    phone: map[tblUserPhone],
    position: map[tblUserPosition],
    role: map[tblUserRole],
    userid: map[tblUserID],
    address: map[tblUserAddress],
    area: map[tblUserArea],
  );

}
