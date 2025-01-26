import 'package:fcr_report/db/dbhelper.dart';
import 'package:fcr_report/models/CattleModel.dart';
import 'package:flutter/material.dart';

class CattleProvider extends ChangeNotifier{
  List<CattleModel> DairyReportList = [];
  List<CattleModel> FatteningReportList = [];

  Future<void> addcattleData(CattleModel cattleModel){
    return DbHelper.addcattleData(cattleModel);
  }

  getDairyReport(String collectionName) {
    DbHelper.getAllReport(collectionName).listen((event) {
      DairyReportList = List.generate(event.docs.length,
              (index) => CattleModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  getFatteningReport(String collectionName) {
    DbHelper.getAllReport(collectionName).listen((event) {
      FatteningReportList = List.generate(event.docs.length,
              (index) => CattleModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  CattleModel getDairyReportById(String itemId){
    return DairyReportList.firstWhere((element) => element.cattleid == itemId);
  }
  CattleModel getFatteningReportById(String itemId){
    return FatteningReportList.firstWhere((element) => element.cattleid == itemId);
  }
}