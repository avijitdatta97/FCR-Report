const String tblBroilerSonali = 'BrolierSonali';

const String tblOfficerName = 'Officer Name';
const String tblPoultryId = 'Poultry ID';
const String tblPoultryType = 'Poultry Type';
const String tblVisitingDate = 'Visiting Date';

const String tblFarmerName = 'Farmer Name';
const String tblFarmerAddress = 'Farmer Address';
const String tblFarmerArea = 'Farmer Area';
const String tblFarmerPhone = 'Farmer Phone';

const String tblDealerName = 'Dealer Name';
const String tblDealerAddress = 'Dealer Address';
const String tblDealerphone = 'Dealer Phone';

const String tblDOCName = 'DOC Name';
const String tblDOCReceived = 'DOC Received';
const String tblFeedCompany = 'Feed Company';
const String tblChickenAge = 'Chicken Age';
const String tblMortality3day = 'Mortality 1st 3day';
const String tblMortality = 'Total Mortality';
const String tblAvgIntake = 'Avg Intake';
// const String tblStdIntake = 'Std Intake';
const String tblAvgWeight = 'Avg Weight';
// const String tblStdWeight = 'Std Weight';
const String tblFCR = 'FCR';
const String tblRemark = 'Remark';

class PoultryBSModel {
  String officerName;
  String? poultryid;
  String poultrytype;
  String? visitingDate;

  String fName;
  String fAddress;
  String fArea;
  String fPhone;

  String dName;
  String dAddress;
  String dPhone;

  String docName;
  String docReceived;
  String feedCompany;
  String chickenAge;
  String mortality1st3day;
  String totalMortality;
  String avgIntake;
  String avgWeight;
  String fcr;
  String remark;

  PoultryBSModel(
      {required this.officerName,
      this.poultryid,
      required this.poultrytype,
      this.visitingDate,
      required this.fName,
      required this.fAddress,
      this.fArea = '',
      this.fPhone = '',
      this.dName = '',
      this.dAddress = '',
      this.dPhone = '',
      this.docName = '',
      this.docReceived = '',
      this.feedCompany = '',
      this.chickenAge = '',
      this.mortality1st3day = '',
      this.totalMortality = '',
      this.avgIntake = '',
      this.avgWeight = '',
      this.fcr = '',
      this.remark = ''});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblOfficerName: officerName,
      tblPoultryId: poultryid,
      tblPoultryType: poultrytype,
      tblVisitingDate: visitingDate,
      tblFarmerName: fName,
      tblFarmerAddress: fAddress,
      tblFarmerArea: fArea,
      tblFarmerPhone: fPhone,
      tblDealerName: dName,
      tblDealerAddress: dAddress,
      tblDealerphone: dPhone,
      tblDOCName: docName,
      tblDOCReceived: docReceived,
      tblFeedCompany: feedCompany,
      tblChickenAge: chickenAge,
      tblMortality3day: mortality1st3day,
      tblMortality: totalMortality,
      tblAvgIntake: avgIntake,
      tblAvgWeight: avgWeight,
      tblFCR: fcr,
      tblRemark: remark,
    };
    return map;
  }

  factory PoultryBSModel.fromMap(Map<String, dynamic> map) => PoultryBSModel(
        officerName: map[tblOfficerName],
        poultryid: map[tblPoultryId],
        poultrytype: map[tblPoultryType],
        visitingDate: map[tblVisitingDate],
        fName: map[tblFarmerName],
        fAddress: map[tblFarmerAddress],
        fArea: map[tblFarmerArea],
        fPhone: map[tblFarmerPhone],
        dName: map[tblDealerName],
        dAddress: map[tblDealerAddress],
        dPhone: map[tblDealerphone],
        docName: map[tblDOCReceived],
        docReceived: map[tblDOCReceived],
        feedCompany: map[tblFeedCompany],
        chickenAge: map[tblChickenAge],
        mortality1st3day: map[tblMortality3day],
        totalMortality: map[tblMortality],
        avgIntake: map[tblAvgIntake],
        avgWeight: map[tblAvgWeight],
        fcr: map[tblFCR],
        remark: map[tblRemark],
      );
}
