import 'package:fcr_report/db/dbhelper.dart';
import 'package:flutter/foundation.dart';

import '../models/FishModel.dart';

class FishProvider extends ChangeNotifier {
  List<FishModel> FishList = [];
  List<FishModel> ReportList = [];

  Future<void> addTialapiaData(FishModel fishModel) {
    return DbHelper.addTialapiaData(fishModel);
  }

  getAllReport(String collectionName) {
    DbHelper.getAllReport(collectionName).listen((event) {
      ReportList = List.generate(event.docs.length,
          (index) => FishModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  FishModel getReportById(String itemId){
    return ReportList.firstWhere((element) => element.fishid == itemId);
  }
}