import 'package:fcr_report/pages/cattle_report_details_view.dart';
import 'package:fcr_report/providers/cattle_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CattleReportList extends StatefulWidget {
  static const String routeName = '/cattlereportlist';
  const CattleReportList({super.key});

  @override
  State<CattleReportList> createState() => _CattleReportListState();
}

class _CattleReportListState extends State<CattleReportList> {

  String cattleTypeForPrint = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),

      body: Consumer<CattleProvider>(
        builder: (context, cattleProvider, child) {
          final argument = ModalRoute.of(context)!.settings.arguments as String;
          cattleTypeForPrint = argument;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cattleTypeForPrint == 'Dairy' ? cattleProvider.DairyReportList.length: cattleProvider.FatteningReportList.length,
                  itemBuilder: (context, index) {
                    final reportItem = cattleTypeForPrint == 'Dairy' ? cattleProvider.DairyReportList[index] : cattleProvider.FatteningReportList[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      child: ListTile(
                        leading: CircleAvatar(child: Text((index+1).toString()),),
                        title: Text(reportItem.fName),
                        subtitle: Text('Enter By: ${reportItem.officerName}, Total Quantity: ${reportItem.totalQuantity}'),
                        trailing: Text(reportItem.visitingDate.toString()),
                        onTap: (){
                          Navigator.pushNamed(context, CattleReportDetailsView.routeName, arguments: {'cattleid': '${reportItem.cattleid}', 'cattleType': '${cattleTypeForPrint}'});
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
