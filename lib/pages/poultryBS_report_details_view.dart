import 'package:fcr_report/models/PoultryBSModel.dart';
import 'package:fcr_report/providers/poultry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoultryBSReportDetailsView extends StatefulWidget {
  static const String routeName = '/poultryBSReportDetailsView';
  const PoultryBSReportDetailsView({super.key});

  @override
  State<PoultryBSReportDetailsView> createState() => _PoultryBSReportDetailsViewState();
}

class _PoultryBSReportDetailsViewState extends State<PoultryBSReportDetailsView> {

  late PoultryProvider poultryProvider;
  late PoultryBSModel poultryBSModel;
  String poultryId='';
  String poultrytype='';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    poultryProvider = Provider.of<PoultryProvider>(context);
    final argValue = ModalRoute.of(context)!.settings.arguments as Map;
    poultryId = argValue['cattleid'];
    poultrytype = argValue['cattleType'];
    poultrytype == 'Boiler' ? poultryBSModel = poultryProvider.getBoilerReportById(poultryId) : poultryBSModel = poultryProvider.getSonaliReportById(poultryId);
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
                        Center(child: Text(poultryBSModel.fName)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Phone Number')),
                        Center(child: Text(poultryBSModel.fPhone)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Address')),
                        Center(child: Text(poultryBSModel.fAddress)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Area')),
                        Center(child: Text(poultryBSModel.fArea)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Visiting Date')),
                        Center(child: Text(poultryBSModel.visitingDate.toString())),
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
                child: Text("Dealer Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                // textDirection: Align(alignment : Alignment.center),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Dealer Name')),
                        Center(child: Text(poultryBSModel.dName)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Dealer Address')),
                        Center(child: Text(poultryBSModel.dAddress)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Dealer Phone')),
                        Center(child: Text(poultryBSModel.dPhone)),
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
                  TableRow(
                      children: [
                        Center(child: Text('DOC Name')),
                        Center(child: Text(poultryBSModel.docName)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Feed Company Name')),
                        Center(child: Text(poultryBSModel.feedCompany)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Number of DOC Received')),
                        Center(child: Text(poultryBSModel.docReceived)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Age of Chicken (day)')),
                        Center(child: Text(poultryBSModel.chickenAge)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Mortality With in 1st 3day')),
                        Center(child: Text(poultryBSModel.mortality1st3day)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Total Mortality')),
                        Center(child: Text(poultryBSModel.totalMortality)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Avg. Feed Intake (gm)')),
                        Center(child: Text(poultryBSModel.avgIntake)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Avg. Body Weight (gm)')),
                        Center(child: Text(poultryBSModel.avgWeight)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('FCR')),
                        Center(child: Text(poultryBSModel.fcr)),
                      ]
                  ),TableRow(
                      children: [
                        Center(child: Text('Remark')),
                        Center(child: Text(poultryBSModel.remark)),
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
