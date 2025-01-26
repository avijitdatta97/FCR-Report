import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcr_report/models/CattleModel.dart';
import 'package:fcr_report/models/FishModel.dart';
import 'package:fcr_report/models/PoultryBSModel.dart';
import 'package:fcr_report/models/UserModel.dart';

import '../models/PoultryLayerModel.dart';

class DbHelper {
  static final _db = FirebaseFirestore.instance;
  static final String collectionFarmer = 'Farmer';
  static final String collectionFarmerArea = 'FarmerArea';


  static Future<bool> isUser(String uid) async {
    final snapshot = await _db.collection(tblUser).doc(uid).get();
    return snapshot.exists;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
      String uid) =>
      _db.collection(tblUser).doc(uid).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() =>
      _db.collection(tblUser).snapshots();

  static Future<void> addTialapiaData(FishModel fishModel){
    final doc = _db.collection(fishModel.fishtype).doc();
    fishModel.fishid = doc.id;
    return doc.set(fishModel.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllFarmer(){
    return _db.collection(collectionFarmer).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllFarmerArea(){
    return _db.collection(collectionFarmerArea).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsByCategory(
      String area) =>
      _db
          .collection(collectionFarmer)
          .where('$tblUserArea',
          isEqualTo: area).snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllReport(String collectionName){
    return _db.collection(collectionName).snapshots();
  }


  // Poultry boiler and Sonali
  static Future<void> addBoilerData(PoultryBSModel poultryBSModel){
    final doc = _db.collection(poultryBSModel.poultrytype).doc();
    poultryBSModel.poultryid = doc.id;
    return doc.set(poultryBSModel.toMap());
  }

  static Future<void> addSonaliData(PoultryBSModel poultryBSModel){
    final doc = _db.collection(poultryBSModel.poultrytype).doc();
    poultryBSModel.poultryid = doc.id;
    return doc.set(poultryBSModel.toMap());
  }

  static Future<void> addLayerData(PoultryLayerModel poultryLayerModel){
    final doc = _db.collection(poultryLayerModel.poultrytype).doc();
    poultryLayerModel.poultryid = doc.id;
    return doc.set(poultryLayerModel.toMap());
  }

  static Future<void> addcattleData(CattleModel cattleModel){
    final doc = _db.collection(cattleModel.cattletype).doc();
    cattleModel.cattleid = doc.id;
    return doc.set(cattleModel.toMap());
  }



}