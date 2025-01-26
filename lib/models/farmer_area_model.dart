import 'package:flutter/material.dart';

const String tblFarmer = "FarmerArea";

const String tblFarmerAreaId = 'id';
const String tblFarmerArea = 'area';

class FarmerAreaModel {
  String? id;
  String area;

  FarmerAreaModel({
    this.id,
    required this.area,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      tblFarmerAreaId: id,
      tblFarmerArea: area,
    };
  }

  factory FarmerAreaModel.fromMap(Map<String, dynamic> map) => FarmerAreaModel(
    id: map[tblFarmerAreaId],
    area: map[tblFarmerArea],
  );

}
