import 'package:fcr_report/pages/layer_report_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/poultry_provider.dart';

class LayerReportList extends StatefulWidget {
  static const String routeName = '/layerReportList';
  const LayerReportList({super.key});

  @override
  State<LayerReportList> createState() => _LayerReportListState();
}

class _LayerReportListState extends State<LayerReportList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report List'),
      ),

      body: Consumer<PoultryProvider>(
        builder: (context, poultryProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: poultryProvider.layerList.length,
                  itemBuilder: (context, index) {
                    final reportItem = poultryProvider.layerList[index] ;
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      child: ListTile(
                        leading: CircleAvatar(child: Text((index+1).toString()),),
                        title: Text(reportItem.fname),
                        subtitle: Text('Enter By: ${reportItem.officerName}'),
                        trailing: Text(reportItem.visitingDate.toString()),
                        onTap: (){
                          Navigator.pushNamed(context, LayerReportDetailsView.routeName, arguments: reportItem.poultryid);
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
