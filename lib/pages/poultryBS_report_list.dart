import 'package:fcr_report/pages/poultryBS_report_details_view.dart';
import 'package:fcr_report/providers/poultry_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PoultryBSReportList extends StatefulWidget {
  static const String routeName = '/poultryBSReportList';
  const PoultryBSReportList({super.key});

  @override
  State<PoultryBSReportList> createState() => _PoultryBSReportListState();
}

class _PoultryBSReportListState extends State<PoultryBSReportList> {

  String poultryTypeForPrint = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),

      body: Consumer<PoultryProvider>(
        builder: (context, poultryProvider, child) {
          final argument = ModalRoute.of(context)!.settings.arguments as String;
          poultryTypeForPrint = argument;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: poultryTypeForPrint == 'Boiler' ? poultryProvider.boilerList.length : poultryProvider.sonaliList.length,
                  itemBuilder: (context, index) {
                    final reportItem = poultryTypeForPrint == 'Boiler' ? poultryProvider.boilerList[index] : poultryProvider.sonaliList[index] ;
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      child: ListTile(
                        leading: CircleAvatar(child: Text((index+1).toString()),),
                        title: Text(reportItem.fName),
                        subtitle: Text('Enter By: ${reportItem.officerName}'),
                        trailing: Text(reportItem.visitingDate.toString()),
                        onTap: (){
                          Navigator.pushNamed(context, PoultryBSReportDetailsView.routeName, arguments: {'cattleid': '${reportItem.poultryid}', 'cattleType': '${poultryTypeForPrint}'});
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
