import 'package:fcr_report/models/UserModel.dart';
import 'package:fcr_report/providers/user_provider.dart';
import 'package:fcr_report/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ShowUserDetails extends StatefulWidget {
  static const String routeName = '/showfarmerdetails';
  const ShowUserDetails({super.key});

  @override
  State<ShowUserDetails> createState() => _ShowUserDetailsState();
}

class _ShowUserDetailsState extends State<ShowUserDetails> {
  late UserProvider userProvider;
  late UserModel userModel;
  String userType= '';
  String id = '';

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    final argvalue = ModalRoute.of(context)!.settings.arguments as String;
    id = argvalue;
    userModel = userProvider.getUserById(id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  CircleAvatar(
                    child: Image.asset('images/profilePic.png'),
                    radius: 100,
                  ),
                  SizedBox(height: 25,),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('Name: ${userModel.name.toString()}'),
                      leading: Icon(Icons.account_circle),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('Phone: ${userModel.phone.toString()}'),
                      leading: Icon(Icons.phone_android),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: (){
                            _callAndMegContact('tel:', userModel.phone);
                          }, icon: Icon(Icons.call_outlined)),
                          IconButton(onPressed: (){
                            _callAndMegContact('sms:', userModel.phone);
                          }, icon: Icon(Icons.message_outlined)),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('Area: ${userModel.area.toString()}'),
                      leading: Icon(Icons.location_on_outlined),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text('Address: ${userModel.address.toString()}'),
                      leading: Icon(Icons.location_city),
                      trailing: IconButton(onPressed: (){}, icon: Icon(Icons.map_outlined)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _callAndMegContact(String header, String? phone) async{
    final url = '$header$phone';
    if(await canLaunchUrlString(url)){
      launchUrlString(url);
    }
    else{
      showMsg(context, 'Could not perform this operation');
    }
  }
}
