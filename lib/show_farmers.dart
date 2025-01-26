import 'package:fcr_report/models/farmer_area_model.dart';
import 'package:fcr_report/providers/user_provider.dart';
import 'package:fcr_report/show_user_details.dart';
import 'package:fcr_report/utils/helper_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowFarmer extends StatefulWidget {
  static const String routeName = '/showfarmer';

  const ShowFarmer({super.key});

  @override
  State<ShowFarmer> createState() => _ShowFarmerState();
}

class _ShowFarmerState extends State<ShowFarmer> {
  late UserProvider userProvider;
  late FarmerAreaModel farmerAreaModel;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context);
    super.didChangeDependencies();
  }

  String farmerArea = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DropdownButton<FarmerAreaModel>(
            //     hint: Text('Select Area'),
            //     value: farmerAreaModel,
            //     isExpanded: true,
            //     items: userProvider
            //         .getFarmerAreaListForFilttering()
            //         .map((areaModel) => DropdownMenuItem(
            //               value: areaModel,
            //               child: Text(areaModel.area),
            //             ))
            //         .toList(),
            //     onChanged: (value) {
            //       setState(() {
            //         farmerAreaModel = value!;
            //       });
            //       provider.getAllProductsByCategory(farmerAreaModel!.area);
            //     },
            //   ),
            // ),
            Expanded(
                child: ListView.builder(
                    itemCount: provider.farmerList.length,
                    itemBuilder: (context, index) {
                      final farmeritem = provider.farmerList[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                        child: ListTile(
                          leading: CircleAvatar(child: Text((index+1).toString()),),
                          title: Text(farmeritem.name.toString()),
                          subtitle: Text(farmeritem.phone.toString()),
                          trailing: Text(farmeritem.area.toString()),
                          onTap: () {
                            Navigator.pushNamed(context, ShowUserDetails.routeName,
                                arguments: farmeritem.userid);
                          },
                        ),
                      );
                    }),
              ),
          ],
        );
        },
      ),
    );
  }
}
