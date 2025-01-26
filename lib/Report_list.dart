import 'package:fcr_report/Report_details_view.dart';
import 'package:fcr_report/providers/fish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportListView extends StatefulWidget {
  static const String routeName = '/reportlist';
  const ReportListView({super.key});

  @override
  State<ReportListView> createState() => _ReportListViewState();
}

class _ReportListViewState extends State<ReportListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),
      
      body: Consumer<FishProvider>(
        builder: (context, fishProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: fishProvider.ReportList.length,
                  itemBuilder: (context, index) {
                    final reportItem = fishProvider.ReportList[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      child: ListTile(
                        leading: CircleAvatar(child: Text((index+1).toString()),),
                        title: Text(reportItem.fname),
                        subtitle: Text('Enter By: ${reportItem.officerName}, FCR: ${reportItem.ffcr}'),
                        trailing: Text(reportItem.fishsamplingday),
                        onTap: (){
                          Navigator.pushNamed(context, ReportDetailsView.routeName, arguments: reportItem.fishid);
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
