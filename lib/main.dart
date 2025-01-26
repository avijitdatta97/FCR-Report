import 'package:fcr_report/CategoryPage.dart';
import 'package:fcr_report/FishFormPage.dart';
import 'package:fcr_report/LogInPage.dart';
import 'package:fcr_report/Report_details_view.dart';
import 'package:fcr_report/Report_list.dart';
import 'package:fcr_report/SubCategoryPage.dart';
import 'package:fcr_report/SummaryPage.dart';
import 'package:fcr_report/UseCasePage.dart';
import 'package:fcr_report/edit_profile.dart';
import 'package:fcr_report/fcr_calculator.dart';
import 'package:fcr_report/map_page.dart';
import 'package:fcr_report/pages/cattleFormPage.dart';
import 'package:fcr_report/pages/cattle_report_details_view.dart';
import 'package:fcr_report/pages/cattle_repot_list.dart';
import 'package:fcr_report/pages/layer_report_details_view.dart';
import 'package:fcr_report/pages/layer_report_list.dart';
import 'package:fcr_report/pages/poultryBSForm.dart';
import 'package:fcr_report/pages/poultryBS_report_details_view.dart';
import 'package:fcr_report/pages/poultryBS_report_list.dart';
import 'package:fcr_report/pages/poultryLayerForm.dart';
import 'package:fcr_report/providers/cattle_provide.dart';
import 'package:fcr_report/providers/fish_provider.dart';
import 'package:fcr_report/providers/poultry_provider.dart';
import 'package:fcr_report/providers/user_provider.dart';
import 'package:fcr_report/show_farmers.dart';
import 'package:fcr_report/show_user_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';
import 'auth/authservice.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => FishProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => PoultryProvider()),
    ChangeNotifierProvider(create: (_) => CattleProvider(),),
  ],child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.green,
      ),
      initialRoute: SplashScreen.routeName,
      builder: EasyLoading.init(),
      routes: {
        LogInPage.routeName: (context) => const LogInPage(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        UserCasePage.routeName: (context) => const UserCasePage(),
        CategoryPage.routeName: (context) => const CategoryPage(),
        SubCategoryPage.routeName: (context) => const SubCategoryPage(),
        SummaryPage.routeName: (context) => const SummaryPage(),
        FishFormPage.routeName: (context) => const FishFormPage(),
        MapPage.routeName: (context) => const MapPage(),
        ShowFarmer.routeName: (context) => const ShowFarmer(),
        ShowUserDetails.routeName: (context) => const ShowUserDetails(),
        ReportListView.routeName: (context) => const ReportListView(),
        ReportDetailsView.routeName: (context) => const ReportDetailsView(),
        EditProfilePage.routeName: (context) => const EditProfilePage(),
        FCRCalculator.routName: (context) => const FCRCalculator(),
        PoultryBSForm.routeName: (context) => const PoultryBSForm(),
        PoultryBSReportList.routeName: (context) => const PoultryBSReportList(),
        PoultryBSReportDetailsView.routeName: (context) => const PoultryBSReportDetailsView(),
        LayerReportList.routeName:  (context) => const LayerReportList(),
        LayerReportDetailsView.routeName:(context) => const LayerReportDetailsView(),
        PoultryLayerForm.routeName: (context) => const PoultryLayerForm(),
        CattleFormPage.routeName: (context) => const CattleFormPage(),
        CattleReportList.routeName: (context) => const CattleReportList(),
        CattleReportDetailsView.routeName: (context) => const CattleReportDetailsView(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if(AuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
      else{
        Navigator.pushReplacementNamed(context, LogInPage.routeName);
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return AnimatedSplashScreen(
    //     splash: Column(
    //       children: [
    //         Image.asset('images/f1.png'),
    //         Text('farm Performance', style: TextStyle(fontSize: 25),)
    //       ],
    //     ),
    //     nextScreen: const HomePage(),
    //     backgroundColor: Colors.blue,
    //     splashIconSize: 250,
    //     duration: 1000,
    //     splashTransition: SplashTransition.fadeTransition,
    // );
  }
}
