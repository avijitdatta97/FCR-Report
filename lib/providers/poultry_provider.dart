import 'package:fcr_report/db/dbhelper.dart';
import 'package:fcr_report/models/PoultryBSModel.dart';
import 'package:flutter/cupertino.dart';

import '../models/PoultryLayerModel.dart';

class PoultryProvider extends ChangeNotifier{

  List<PoultryBSModel> boilerList = [];
  List<PoultryBSModel> sonaliList = [];
  List<PoultryLayerModel> layerList = [];

  Future<void> addBoilerData(PoultryBSModel poultryBSModel){
    return DbHelper.addBoilerData(poultryBSModel);
  }

  Future<void> addSonaliData(PoultryBSModel poultryBSModel){
    return DbHelper.addSonaliData(poultryBSModel);
  }

  Future<void> addLayerData(PoultryLayerModel poultryLayerModel){
    return DbHelper.addLayerData(poultryLayerModel);
  }

  getBoilerReport(String collectionName) {
    DbHelper.getAllReport(collectionName).listen((event) {
      boilerList = List.generate(event.docs.length,
              (index) => PoultryBSModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
  getSonaliReport(String collectionName) {
    DbHelper.getAllReport(collectionName).listen((event) {
      sonaliList = List.generate(event.docs.length,
              (index) => PoultryBSModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }
  getLayerReport(String collectionName) {
    DbHelper.getAllReport(collectionName).listen((event) {
      layerList = List.generate(event.docs.length,
              (index) => PoultryLayerModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  PoultryBSModel getBoilerReportById(String poultryId){
    return boilerList.firstWhere((element) => element.poultryid == poultryId);
  }

  PoultryBSModel getSonaliReportById(String poultryId){
    return sonaliList.firstWhere((element) => element.poultryid == poultryId);
  }

  PoultryLayerModel getLayerReportById(String poultryId){
    return layerList.firstWhere((element) => element.poultryid == poultryId);
  }

}