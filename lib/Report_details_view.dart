import 'package:fcr_report/models/FishModel.dart';
import 'package:fcr_report/providers/fish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportDetailsView extends StatefulWidget {
  static const String routeName = '/reportdetailsview';
  const ReportDetailsView({super.key});

  @override
  State<ReportDetailsView> createState() => _ReportDetailsViewState();
}

class _ReportDetailsViewState extends State<ReportDetailsView> {
  late FishProvider fishProvider;
  late FishModel fishModel;
  String fishId='';
  @override
  void didChangeDependencies() {
    fishProvider = Provider.of<FishProvider>(context);
    final argValue = ModalRoute.of(context)!.settings.arguments as String;
    fishId = argValue;
    fishModel = fishProvider.getReportById(fishId);
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
                      Center(child: Text(fishModel.fname)),
                    ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Phone Number')),
                        Center(child: Text(fishModel.fphonenumber)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Address')),
                        Center(child: Text(fishModel.faddress)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Area')),
                        Center(child: Text(fishModel.farea)),
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
                child: Text("Baby Fish Information", style: TextStyle(color: Colors.white),),
                ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                // textDirection: Align(alignment : Alignment.center),
                children: [
                  TableRow(
                    children: [
                      Center(child: Text('Age (Day)')),
                      Center(child: Text(fishModel.fishage)),
                    ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Initial Baby Fish Weight')),
                        Center(child: Text(fishModel.fishweight)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Stocking Date')),
                        Center(child: Text(fishModel.fishstockingday)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Source of Baby Fish')),
                        Center(child: Text(fishModel.fishsource)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Stocking Density in Decimal')),
                        Center(child: Text(fishModel.fishdensity)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Mortality')),
                        Center(child: Text(fishModel.fishmortality)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Sampling Date')),
                        Center(child: Text(fishModel.fishsamplingday)),
                      ]
                  ),
                ],
              ),
          
              // Feed Information
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.deepPurple,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                child: Text("Feed Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Feed Company')),
                        Center(child: Text(fishModel.ffeedcompany.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Feed Type')),
                        Center(child: Text(fishModel.ffeedtype.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Feed Size')),
                        Center(child: Text(fishModel.ffeedsize.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Daily Amount of Feed (Kg/Day)')),
                        Center(child: Text(fishModel.famountoffeed.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Total Feed (Kg)')),
                        Center(child: Text(fishModel.ftotalfeed.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Percentage of Feed')),
                        Center(child: Text(fishModel.fpercentageoffeed.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Total Fish Weight')),
                        Center(child: Text(fishModel.ftotalfishweight.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Average Daily Gain (In/pc/Day)')),
                        Center(child: Text(fishModel.fdailygain.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('FCR')),
                        Center(child: Text(fishModel.ffcr.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Daily Applied Time (day/fish)')),
                        Center(child: Text(fishModel.fappliedtime.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Daily Applied Time (day/fish)')),
                        Center(child: Text(fishModel.fappliedtime.toString())),
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
                child: Text("Management", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Feed Company')),
                        Center(child: Text(fishModel.ffeedcompany.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Depth')),
                        Center(child: Text(fishModel.fdepth.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Daily Water Supply')),
                        Center(child: Text(fishModel.fwatersupply.toString())),
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
