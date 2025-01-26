const String tblFatteningName = 'Cattle';

const String tblOfficerName = 'Officer Name';
const String tblCattleId = 'Cattle ID';
const String tblCattleType = 'Cattle Type';
const String tblVisitingDate = 'Visiting Date';

const String tblFarmerName = 'Farmer Name';
const String tblFarmerAddress = 'Farmer Address';
const String tblFarmerArea = 'Farmer Area';
const String tblFarmerPhone = 'Farmer Phone';
const String tblFarmerExperience = 'Farmer Experience';

const String tblTotalQuantity = 'Total Quantity';
const String tblBreedName = 'Breed Name';
const String tblFeedRatio = 'Feed Ratio';
const String tblMonthlyFeed = 'Feed Per Month';
const String tblFeedCompany = 'Feed Company Name';
const String tblAvgWeight = 'Avg Weight';
const String tblRemark = 'Remark';

const String tblAgeCalving = 'Age of Calving';
const String tblAvgMilk = 'Avg Milk Per Day';

const String tblAgeBulls = 'Age of the Bull';
const String tblWeightGain = 'Weight Gain';

class CattleModel {
  String officerName;
  String? cattleid;
  String cattletype;
  String? visitingDate;

  String fName;
  String fAddress;
  String fArea;
  String fPhone;

  String fExperience;
  String totalQuantity;
  String breed;
  String feedRatio;
  String monthlyFeed;
  String feedBrand;
  String ageCalving;
  String bodyWeight;
  String avgMilk;
  String remark;
  String ageBull;
  String weightGain;

  CattleModel({
    required this.officerName,
    this.cattleid,
    required this.cattletype,
    this.visitingDate,
    required this.fName,
    required this.fAddress,
    this.fArea = '',
    this.fPhone = '',
    this.fExperience = '',
    this.totalQuantity = '',
    this.breed = '',
    this.feedRatio = '',
    this.monthlyFeed = '',
    this.feedBrand = '',
    this.ageCalving = '',
    this.bodyWeight = '',
    this.avgMilk = '',
    this.remark = '',
    this.ageBull = '',
    this.weightGain = '',
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblOfficerName: officerName,
      tblCattleId: cattleid,
      tblCattleType: cattletype,
      tblVisitingDate: visitingDate,
      tblFarmerName: fName,
      tblFarmerAddress: fAddress,
      tblFarmerArea: fArea,
      tblFarmerPhone: fPhone,
      tblFarmerExperience: fExperience,
      tblTotalQuantity: totalQuantity,
      tblBreedName: breed,
      tblFeedRatio: feedRatio,
      tblMonthlyFeed: monthlyFeed,
      tblFeedCompany: feedBrand,
      tblAvgWeight: bodyWeight,
      tblRemark: remark,
      tblAgeCalving: ageCalving,
      tblAvgMilk: avgMilk,
      tblAgeBulls: ageBull,
      tblWeightGain: weightGain,
    };
    return map;
  }

  factory CattleModel.fromMap(Map<String, dynamic> map) => CattleModel(
        officerName: map[tblOfficerName],
        cattleid: map[tblCattleId],
        cattletype: map[tblCattleType],
        visitingDate: map[tblVisitingDate],
        fName: map[tblFarmerName],
        fAddress: map[tblFarmerAddress],
        fArea: map[tblFarmerArea],
        fPhone: map[tblFarmerPhone],
        fExperience: map[tblFarmerExperience],
        totalQuantity: map[tblTotalQuantity],
        breed: map[tblBreedName],
        feedRatio: map[tblFeedRatio],
        monthlyFeed: map[tblMonthlyFeed],
        feedBrand: map[tblFeedCompany],
        ageCalving: map[tblAgeCalving],
        bodyWeight: map[tblAvgWeight],
        avgMilk: map[tblAvgMilk],
        remark: map[tblRemark],
        ageBull: map[tblAgeBulls],
        weightGain: map[tblWeightGain],
      );
}
