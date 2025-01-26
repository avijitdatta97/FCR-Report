const String tblFish = 'Fish';

const String tblOfficerName = 'Officer Name';
const String tblFishType = 'Type';
const String tblFishId = 'Fish ID';

const String tblFarmerName = 'Name';
const String tblFishPhoneNumber = 'Phone Number';
const String tblFishAddress = 'Address';
const String tblFishArea = 'Area';
const String tblFishDealerName = 'Dealer Name';
const String tblFishNote = 'Note';
const String tblFishAge = 'Age';
const String tblFishWeight = 'Weight';
const String tblFishStockInDay = 'Stock In Day';
const String tblFishSource = 'Source';
const String tblFishDensity = 'Density';
const String tblFishMortality = 'Mortality';
const String tblFishSamplingDay = 'Sampling Day';

const String tblFishFeedCompany = 'ffeedcompany';
const String tblFishFeedType = 'ffeedtype';
const String tblFishFeedSize = 'ffeedsize';
const String tblFishAmountOfFeed = 'famountoffeed';
const String tblFishTotalFeed = 'ftotalfeed';
const String tblFishPercentageOfFeed = 'fpercentageoffeed';
const String tblFishTotalWeight = 'ftotalfishweight';
const String tblFishDailyGain = 'fdailygain';
const String tblFishFCR = 'ffcr';
const String tblFishAppliedTime = 'fappliedtime';
const String tblFishSupplimentory = 'fsupplimentory';
const String tblFishDepth = 'fdepth';
const String tblFishWaterSupply = 'fwatersupply';

class FishModel {
  String? officerName;
  String? fishid;
  String fishtype;

  String fname;
  String fphonenumber;
  String faddress;
  String farea;
  String fdealername;
  String fnote;

  String fishage;
  String fishweight;
  String fishstockingday;
  String fishsource;
  String fishdensity;
  String fishmortality;
  String fishsamplingday;

  String? ffeedcompany;
  String? ffeedtype;
  String? ffeedsize;
  String? famountoffeed;
  String? ftotalfeed;
  String? fpercentageoffeed;
  String? ftotalfishweight;
  String? fdailygain;
  String? ffcr;
  String? fappliedtime;

  String? fsupplimentory;
  String? fdepth;
  String? fwatersupply;

  FishModel({
    this.officerName,
    this.fishid,
    required this.fname,
    required this.fphonenumber,
    this.fishtype = '',
    this.faddress = '',
    this.farea = '',
    this.fdealername = '',
    this.fnote = '',
    this.fishage = '',
    this.fishweight = '',
    this.fishstockingday = '',
    this.fishsource = '',
    this.fishdensity = '',
    this.fishmortality = '',
    this.fishsamplingday = '',
    this.ffeedcompany = '',
    this.ffeedtype,
    this.ffeedsize,
    this.famountoffeed,
    this.ftotalfeed,
    this.fpercentageoffeed,
    this.ftotalfishweight,
    this.fdailygain,
    this.ffcr,
    this.fappliedtime,
    this.fsupplimentory,
    this.fdepth,
    this.fwatersupply,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblOfficerName: officerName,
      tblFishType: fishtype,
      tblFishId: fishid,
      tblFarmerName: fname,
      tblFishPhoneNumber: fphonenumber,
      tblFishAddress: faddress,
      tblFishArea: farea,
      tblFishDealerName: fdealername,
      tblFishNote: fnote,
      tblFishAge: fishage,
      tblFishWeight: fishweight,
      tblFishStockInDay: fishstockingday,
      tblFishSource: fishsource,
      tblFishDensity: fishdensity,
      tblFishMortality: fishmortality,
      tblFishSamplingDay: fishsamplingday,
      tblFishFeedCompany: ffeedcompany,
      tblFishFeedType: ffeedtype,
      tblFishFeedSize: ffeedsize,
      tblFishAmountOfFeed: famountoffeed,
      tblFishTotalFeed: ftotalfeed,
      tblFishPercentageOfFeed: fpercentageoffeed,
      tblFishTotalWeight: ftotalfishweight,
      tblFishDailyGain: fdailygain,
      tblFishFCR: ffcr,
      tblFishAppliedTime: fappliedtime,
      tblFishSupplimentory: fsupplimentory,
      tblFishDepth: fdepth,
      tblFishWaterSupply: fwatersupply,
    };
    return map;
  }

  factory FishModel.fromMap(Map<String, dynamic> map) => FishModel(
        officerName: map[tblOfficerName],
        fishid: map[tblFishId],
        fishtype: map[tblFishType],
        fname: map[tblFarmerName],
        fphonenumber: map[tblFishPhoneNumber],
        faddress: map[tblFishAddress],
        farea: map[tblFishArea],
        fdealername: map[tblFishDealerName],
        fnote: map[tblFishNote],
        fishage: map[tblFishAge],
        fishweight: map[tblFishWeight],
        fishstockingday: map[tblFishStockInDay],
        fishsource: map[tblFishSource],
        fishdensity: map[tblFishDensity],
        fishmortality: map[tblFishMortality],
        fishsamplingday: map[tblFishSamplingDay],
        ffeedcompany: map[tblFishFeedCompany],
        ffeedtype: map[tblFishFeedType],
        ffeedsize: map[tblFishFeedSize],
        famountoffeed: map[tblFishAmountOfFeed],
        ftotalfeed: map[tblFishTotalFeed],
        fpercentageoffeed: map[tblFishPercentageOfFeed],
        ftotalfishweight: map[tblFishTotalWeight],
        fdailygain: map[tblFishDailyGain],
        ffcr: map[tblFishFCR],
        fappliedtime: map[tblFishAppliedTime],
        fsupplimentory: map[tblFishSupplimentory],
        fdepth: map[tblFishDepth],
        fwatersupply: map[tblFishWaterSupply],
      );

  @override
  String toString() {
    return 'FishModel{id: $fishid, fishtype: $fishtype, fname: $fname, fphonenumber: $fphonenumber, faddress: $faddress, farea: $farea, fdealername: $fdealername, fnode: $fnote, fishage: $fishage, fishweight: $fishweight, fishstockingday: $fishstockingday, fishsource: $fishsource, fishdensity: $fishdensity, fishmortality: $fishmortality, fishsamplingday: $fishsamplingday}';
  }
}
