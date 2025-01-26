import 'package:fcr_report/models/PoultryLayerModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poultry_provider.dart';

class LayerReportDetailsView extends StatefulWidget {
  static const String routeName = '/layerReportDetailsView';
  const LayerReportDetailsView({super.key});

  @override
  State<LayerReportDetailsView> createState() => _LayerReportDetailsViewState();
}

class _LayerReportDetailsViewState extends State<LayerReportDetailsView> {

  late PoultryProvider poultryProvider;
  late PoultryLayerModel poultryLayerModel;
  String poultryId='';
  // String poultrytype='';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    poultryProvider = Provider.of<PoultryProvider>(context);
    final argValue = ModalRoute.of(context)!.settings.arguments as String;
    poultryId = argValue;
    print(poultryId);
    poultryLayerModel = poultryProvider.getLayerReportById(poultryId);
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
                child: Text("Farmer and Dealer Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Farmer Name')),
                        Center(child: Text(poultryLayerModel.fname)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Phone Number')),
                        Center(child: Text(poultryLayerModel.fPhone)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Address')),
                        Center(child: Text(poultryLayerModel.fAddress)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Area')),
                        Center(child: Text(poultryLayerModel.fArea)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Visiting Date')),
                        Center(child: Text(poultryLayerModel.visitingDate.toString())),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Dealer Name')),
                        Center(child: Text(poultryLayerModel.dName)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Dealer Phone')),
                        Center(child: Text(poultryLayerModel.dPhone)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Dealer Address')),
                        Center(child: Text(poultryLayerModel.dAddress)),
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
                child: Text("Bird's Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                // textDirection: Align(alignment : Alignment.center),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('DOC Name')),
                        Center(child: Text(poultryLayerModel.docBreed)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('DOC Company Name')),
                        Center(child: Text(poultryLayerModel.docCompany)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Initial Quantity')),
                        Center(child: Text(poultryLayerModel.initialQuantity)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Present Quantity')),
                        Center(child: Text(poultryLayerModel.presentQuantity)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Mortailty')),
                        Center(child: Text(poultryLayerModel.presentQuantity)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Avg. Bird Weight')),
                        Center(child: Text(poultryLayerModel.avgBirdWeight)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Age of Birds')),
                        Center(child: Text(poultryLayerModel.birdAge)),
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
                child: Text("Management Information", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Feed Company Name')),
                        Center(child: Text(poultryLayerModel.feedName)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Avg. Feed Intake')),
                        Center(child: Text(poultryLayerModel.avgIntake)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Lighting')),
                        Center(child: Text(poultryLayerModel.lighting)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Vaccination')),
                        Center(child: Text(poultryLayerModel.vaccination)),
                      ]
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.teal,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 80),
                child: Text("Eggs Production", style: TextStyle(color: Colors.white),),
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(150.0),
                children: [
                  TableRow(
                      children: [
                        Center(child: Text('Present Production (%)')),
                        Center(child: Text(poultryLayerModel.production)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Egg Weignt (gm)')),
                        Center(child: Text(poultryLayerModel.eggWeight)),
                      ]
                  ),
                  TableRow(
                      children: [
                        Center(child: Text('Remark')),
                        Center(child: Text(poultryLayerModel.remark)),
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
