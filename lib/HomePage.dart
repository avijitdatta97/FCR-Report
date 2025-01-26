import 'package:fcr_report/FishFormPage.dart';
import 'package:fcr_report/Report_list.dart';
import 'package:fcr_report/auth/authservice.dart';
import 'package:fcr_report/edit_profile.dart';
import 'package:fcr_report/fcr_calculator.dart';
import 'package:fcr_report/main.dart';
import 'package:fcr_report/pages/cattleFormPage.dart';
import 'package:fcr_report/pages/cattle_repot_list.dart';
import 'package:fcr_report/pages/layer_report_details_view.dart';
import 'package:fcr_report/pages/layer_report_list.dart';
import 'package:fcr_report/pages/poultryBSForm.dart';
import 'package:fcr_report/pages/poultryBS_report_list.dart';
import 'package:fcr_report/pages/poultryLayerForm.dart';
import 'package:fcr_report/providers/cattle_provide.dart';
import 'package:fcr_report/providers/fish_provider.dart';
import 'package:fcr_report/providers/poultry_provider.dart';
import 'package:fcr_report/providers/user_provider.dart';
import 'package:fcr_report/show_farmers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homepage';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserProvider userProvider;
  late FishProvider fishProvider;
  late CattleProvider cattleProvider;
  late PoultryProvider poultryProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context);
    fishProvider = Provider.of<FishProvider>(context);
    cattleProvider = Provider.of<CattleProvider>(context);
    poultryProvider = Provider.of<PoultryProvider>(context);
    super.didChangeDependencies();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).getAllUsers();
    Provider.of<UserProvider>(context, listen: false).getUserInfo();
    Provider.of<UserProvider>(context, listen: false).getAllFarmer();
    Provider.of<UserProvider>(context, listen: false).getAllFarmerArea();
    String fishTypetilapia = 'Tialapia';
    String fishTypekoi = 'Koi';
    String fishTypeCatFish = 'CatFish';
    return Scaffold(
        appBar: AppBar(
          title: userProvider.userModel == null
              ? Center(
                  child: const Text('Please Wait'),
                )
              : Container(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                    ),
                    title: Text(
                      userProvider.userModel!.name.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      '${userProvider.userModel!.office.toString()}${', '}${userProvider.userModel!.position.toString()}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
          elevation: 10,
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(
                      userProvider.userModel == null ? 'Please Wait' : userProvider.userModel!.name.toString()
                  ),
                  accountEmail: Text(
                      userProvider.userModel == null ? 'Please Wait' : userProvider.userModel!.email.toString()
                  ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(child: Image.asset('images/profilePic.png')),
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(image: AssetImage('images/drawerBackground.png'), fit: BoxFit.cover),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, EditProfilePage.routeName);
                        },
                        child: Text('Edit Profile')),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('Report'),
                leading: Icon(Icons.data_exploration),
                childrenPadding: EdgeInsets.only(left: 30),
                children: [
                  ExpansionTile(
                    title: Text('Fish'),
                    leading: Icon(Icons.arrow_forward),
                    childrenPadding: EdgeInsets.only(left: 80),
                    children: [
                      ListTile(
                        title: Text('Tialapia'),
                        onTap: () {
                          fishProvider.getAllReport('Tialapia');
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, ReportListView.routeName);
                        },
                      ),
                      ListTile(
                        title: Text('Koi'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Cat Fish'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Pangash'),
                        onTap: () {},
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Poultry'),
                    leading: Icon(Icons.arrow_forward),
                    childrenPadding: EdgeInsets.only(left: 80),
                    children: [
                      ListTile(
                        title: Text('Boiler'),
                        onTap: () {
                          poultryProvider.getBoilerReport('Boiler');
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, PoultryBSReportList.routeName,
                              arguments: 'Boiler');
                        },
                      ),
                      ListTile(
                        title: Text('Sonali'),
                        onTap: () {
                          poultryProvider.getSonaliReport('Sonali');
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, PoultryBSReportList.routeName,
                              arguments: 'Sonali');
                        },
                      ),
                      ListTile(
                        title: Text('Layer'),
                        onTap: () {
                          poultryProvider.getLayerReport('Layer');
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, LayerReportList.routeName);
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Cattle'),
                    leading: Icon(Icons.arrow_forward),
                    childrenPadding: EdgeInsets.only(left: 80),
                    children: [
                      ListTile(
                        title: Text('Dairy'),
                        onTap: () {
                          cattleProvider.getDairyReport('Dairy');
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, CattleReportList.routeName,
                              arguments: 'Dairy');
                        },
                      ),
                      ListTile(
                        title: Text('Fattening'),
                        onTap: () {
                          cattleProvider.getFatteningReport('Fattening');
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, CattleReportList.routeName,
                              arguments: 'Fattening');
                        },
                      ),
                    ],
                  ),
                ],
              ),
              ListTile(
                title: const Text('Log Out'),
                leading: Icon(Icons.logout),
                onTap: () {
                  AuthService.SignOut().then((value) =>
                      Navigator.pushReplacementNamed(
                          context, SplashScreen.routeName));
                },
                tileColor: Colors.red[50],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
              if (currentIndex == 1) {
                currentIndex = 0;
                Navigator.pushNamed(context, ShowFarmer.routeName);
              } else if (currentIndex == 2) {
                currentIndex = 0;
                Navigator.pushNamed(context, FCRCalculator.routName);
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                activeIcon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.man_outlined),
                label: 'Farmer',
                activeIcon: Icon(Icons.man),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate),
                label: 'FCR Calculator',
                activeIcon: Icon(Icons.calculate_outlined),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       ElevatedButton(
              //           onPressed: () {
              //             Navigator.pushNamed(context, UserCasePage.routeName);
              //           },
              //           child: const Text('Agata Feed')),
              //       ElevatedButton(
              //           onPressed: () {
              //             Navigator.pushNamed(context, MapPage.routeName);
              //           },
              //           child: const Text('Other Feed')),
              //     ],
              //   ),
              // ),

              // **** Fish ****
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20.0),
                child: Text(
                  "Fish",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 230,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, FishFormPage.routeName,
                              arguments: {
                                'fishType': 'Tialapia',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/f1.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Tilapia',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, FishFormPage.routeName,
                              arguments: {
                                'fishType': 'Koi',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/f2.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Koi',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, FishFormPage.routeName,
                              arguments: {
                                'fishType': 'CatFish',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/f3.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Cat Fish',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, FishFormPage.routeName,
                              arguments: {
                                'fishType': 'Pangush',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/f4.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Pangush',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // **** Poultry ****
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Poultry",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PoultryBSForm.routeName,
                              arguments: {
                                'poultryType': 'Boiler',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/p5.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Boiler',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, PoultryBSForm.routeName,
                              arguments: {
                                'poultryType': 'Sonali',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/p7.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Sonali',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PoultryLayerForm.routeName, arguments: {
                            'poultryType': 'Layer',
                            'userName': '${userProvider.userModel!.name}'
                          });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/p6.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Layer',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // **** Cattle ****
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Cattle",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CattleFormPage.routeName,
                              arguments: {
                                'cattleType': 'Dairy',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/c8.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Dairy',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CattleFormPage.routeName,
                              arguments: {
                                'cattleType': 'Fattening',
                                'userName': '${userProvider.userModel!.name}'
                              });
                        },
                        child: Card(
                          color: Colors.green[50],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Image.asset(
                                "images/c9.png",
                                width: 70,
                                height: 70,
                              ),
                              Text(
                                'Fattening',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
