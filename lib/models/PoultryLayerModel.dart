const String LayerTblName = 'Layer';

const String tblOfficerName = 'Officer Name';
const String tblPoultryID = 'Poultry ID';
const String tblPoultryType = 'Poultry Type';
const String tblVisitingDate = 'Visiting Data';

const String tblFarmerName = 'Farmer Name';
const String tblFarmerAddress = 'Farmer Address';
const String tblFarmerArea = 'Farmer Area';
const String tblFarmerPhone = 'Farmer Phone';

const String tblDealerName = 'Dealer Name';
const String tblDealerAddress = 'Dealer Address';
const String tblDealerphone = 'Dealer Phone';

const String tblDOCBreed = 'DOC Breed Name';
const String tblDOCCompanyName = 'DOC Company Name';
const String tblInitialQuantity = 'Initial Quantity';
const String tblPresentQuantity = 'Present Quantity';
const String tblMortality = 'Mortality';
const String tblAvgBirdWeight = 'Avg Bird Weight';
const String tblBirdsAge = 'Birds Age';
const String tblFeedCompanyName = 'Feed Company Name';
const String tblAvgFeedIntake = 'Avg Feed Intake';
const String tblLighting = 'Lighting';
const String tblVaccination = 'Vaccination';
const String tblPresentProduction = 'Present Production';
const String tblEggWeight = 'Egg Weight';
const String tblRemark = 'Remark';

class PoultryLayerModel {
  String officerName;
  String? poultryid;
  String poultrytype;
  String? visitingDate;

  String fname;
  String fAddress;
  String fArea;
  String fPhone;

  String dName;
  String dAddress;
  String dPhone;

  String docBreed;
  String docCompany;
  String initialQuantity;
  String presentQuantity;
  String mortality;
  String avgBirdWeight;
  String birdAge;
  String feedName;
  String avgIntake;
  String lighting;
  String vaccination;
  String production;
  String eggWeight;
  String remark;

  PoultryLayerModel({
    required this.officerName,
    this.poultryid,
    required this.poultrytype,
    this.visitingDate,
    required this.fname,
    required this.fAddress,
    this.fArea = '',
    this.fPhone = '',
    this.dName = '',
    this.dAddress = '',
    this.dPhone = '',
    this.docBreed = '',
    this.docCompany = '',
    this.initialQuantity = '',
    this.presentQuantity = '',
    this.mortality = '',
    this.avgBirdWeight = '',
    this.birdAge = '',
    this.feedName = '',
    this.avgIntake = '',
    this.lighting = '',
    this.vaccination = '',
    this.production = '',
    this.eggWeight = '',
    this.remark = '',
  });

  Map<String, dynamic> toMap(){
    final map = <String, dynamic> {
      tblOfficerName: officerName,
      tblPoultryID: poultryid,
      tblPoultryType: poultrytype,
      tblVisitingDate: visitingDate,
      tblFarmerName: fname,
      tblFarmerAddress: fAddress,
      tblFarmerArea: fArea,
      tblFarmerPhone: fPhone,
      tblDealerName: dName,
      tblDealerAddress: dAddress,
      tblDealerphone: dPhone,
      tblDOCBreed: docBreed,
      tblDOCCompanyName: docCompany,
      tblInitialQuantity: initialQuantity,
      tblPresentQuantity: presentQuantity,
      tblMortality: mortality,
      tblAvgBirdWeight: avgBirdWeight,
      tblBirdsAge: birdAge,
      tblFeedCompanyName: feedName,
      tblAvgFeedIntake: avgIntake,
      tblLighting: lighting,
      tblVaccination: vaccination,
      tblPresentProduction: production,
      tblEggWeight: eggWeight,
      tblRemark: remark,
    };
    return map;
  }

  factory PoultryLayerModel.fromMap(Map<String, dynamic> map) => PoultryLayerModel(
      officerName: map[tblOfficerName],
      poultryid: map[tblPoultryID],
      poultrytype: map[tblPoultryType],
      visitingDate: map[tblVisitingDate],
      fname: map[tblFarmerName],
      fAddress: map[tblFarmerAddress],
      fArea: map[tblFarmerArea],
      fPhone: map[tblFarmerPhone],
      dName: map[tblDealerName],
      dAddress: map[tblDealerAddress],
      dPhone: map[tblDealerphone],
      docBreed: map[tblDOCBreed],
      docCompany: map[tblDOCCompanyName],
      initialQuantity: map[tblInitialQuantity],
      presentQuantity: map[tblPresentQuantity],
      mortality: map[tblMortality],
      avgBirdWeight: map[tblAvgBirdWeight],
      birdAge: map[tblBirdsAge],
      feedName: map[tblFeedCompanyName],
      avgIntake: map[tblAvgFeedIntake],
      lighting: map[tblLighting],
      vaccination: map[tblVaccination],
      production: map[tblPresentProduction],
      eggWeight: map[tblEggWeight],
      remark: map[tblRemark],
  );

}
