import 'package:fcr_report/models/CattleModel.dart';
import 'package:fcr_report/providers/cattle_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CattleReportDetailsView extends StatefulWidget {
  static const String routeName = '/cattleReportDetails';
  const CattleReportDetailsView({super.key});

  @override
  State<CattleReportDetailsView> createState() => _CattleReportDetailsViewState();
}

class _CattleReportDetailsViewState extends State<CattleReportDetailsView> {
  late CattleProvider cattleProvider;
  late CattleModel cattleModel;
  String cattleId='';
  String cattletype='';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cattleProvider = Provider.of<CattleProvider>(context);
    final argValue = ModalRoute.of(context)!.settings.arguments as Map;
    cattleId = argValue['cattleid'];
    cattletype = argValue['cattleType'];
    cattletype == 'Dairy' ? cattleModel = cattleProvider.getDairyReportById(cattleId): cattleModel = cattleProvider.getFatteningReportById(cattleId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Farmer's Information
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.red,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                child: Text("Farmer's Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Farmer Name')),
                        Center(child: Text(cattleModel.fName)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Phone Number')),
                        Center(child: Text(cattleModel.fPhone)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Address')),
                        Center(child: Text(cattleModel.fAddress)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Area')),
                        Center(child: Text(cattleModel.fArea)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Visiting Date')),
                        Center(child: Text(cattleModel.visitingDate.toString())),
                      ]
                  ),
                ],
              ),

              // Baby Fish Information
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.blue,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                child: Text("Managment Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                // textDirection: Align(alignment : Alignment.center),
                children: [
                  cattletype == 'Dairy'? TableRow(
                      children: [
                        Center(child: Text('Total Milking Cow')),
                        Center(child: Text(cattleModel.totalQuantity)),
                      ]
                  ): TableRow(
                      children: [
                        Center(child: Text('Total Fattening Bull')),
                        Center(child: Text(cattleModel.totalQuantity)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Breed Name')),
                        Center(child: Text(cattleModel.breed)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Feed Ratio')),
                        Center(child: Text(cattleModel.feedRatio)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Feed Brand')),
                        Center(child: Text(cattleModel.feedBrand)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Feed/Month (Kg)')),
                        Center(child: Text(cattleModel.monthlyFeed)),
                      ]
                  ),
                ],
              ),

              // Management
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.teal,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                child: Text("Other Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  cattletype == 'Dairy' ? TableRow(
                      children: [
                        Center(child: Text('Age of Calving')),
                        Center(child: Text(cattleModel.ageCalving)),
                      ]
                  ) : TableRow(
                      children: [
                        Center(child: Text('Age of The Bull')),
                        Center(child: Text(cattleModel.ageBull)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Avg. Body Weight')),
                        Center(child: Text(cattleModel.bodyWeight)),
                      ]
                  ),
                  cattletype == 'Dairy' ? TableRow(
                      children: [
                        Center(child: Text('Avg. Milk/Day (Lit.)')),
                        Center(child: Text(cattleModel.avgMilk)),
                      ]
                  ) : TableRow(
                      children: [
                        Center(child: Text('Weight Gain / Day')),
                        Center(child: Text(cattleModel.weightGain)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Remark')),
                        Center(child: Text(cattleModel.remark)),
                      ]
                  ),
                ],
              ),

              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
