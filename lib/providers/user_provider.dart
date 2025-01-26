import 'package:fcr_report/auth/authservice.dart';
import 'package:fcr_report/db/dbhelper.dart';
import 'package:fcr_report/models/farmer_area_model.dart';
import 'package:flutter/material.dart';

import '../models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  List<UserModel> userList = [];
  List<UserModel> currentUserList = [];
  List<UserModel> farmerList = [];
  List<FarmerAreaModel> farmerArea = [];

  Future<bool> doesUserExist(String uid) => DbHelper.isUser(uid);

  List<FarmerAreaModel> getFarmerAreaListForFilttering() {
    farmerArea.sort((a, b) => a.area.compareTo(b.area));
    return [FarmerAreaModel(area: 'All'), ...farmerArea];
  }

  getUserInfo() {
    DbHelper.getUserInfo(AuthService.currentUser!.uid).listen((snapshot) {
      if (snapshot.exists) {
        userModel = UserModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  getAllUsers() {
    DbHelper.getAllUsers().listen((snapshot) {
      userList = List.generate(snapshot.docs.length,
          (index) => UserModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllFarmer() {
    DbHelper.getAllFarmer().listen((event) {
      farmerList = List.generate(event.docs.length,
          (index) => UserModel.fromMap(event.docs[index].data()));
      farmerList.sort((a, b) => a.area!.compareTo(b.area as String));
      notifyListeners();
    });
  }

  getAllFarmerArea() {
    DbHelper.getAllFarmerArea().listen((event) {
      farmerArea = List.generate(event.docs.length,
          (index) => FarmerAreaModel.fromMap(event.docs[index].data()));
    });
  }

  UserModel getUserById(String userid) {
    return farmerList.firstWhere((element) => element.userid == userid);
  }


  getAllProductsByCategory(String area) {
    DbHelper.getAllProductsByCategory(area).listen((snapshot) {
      farmerList = List.generate(snapshot.docs.length, (index) =>
          UserModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
