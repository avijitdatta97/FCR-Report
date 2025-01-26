import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fcr_report/models/CattleModel.dart';
import 'package:fcr_report/providers/cattle_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../utils/helper_functions.dart';

class CattleFormPage extends StatefulWidget {
  static const String routeName = '/CattleFormPage';
  const CattleFormPage({super.key});

  @override
  State<CattleFormPage> createState() => _CattleFormPageState();
}

class _CattleFormPageState extends State<CattleFormPage> {

  late CattleProvider cattleProvider;
  final _farmerNameController = TextEditingController();
  final _farmerPhoneController = TextEditingController();
  final _farmerAddressController = TextEditingController();
  final _farmerAreaController = TextEditingController();
  final _farmerExperienceController = TextEditingController();

  final _totalQuantityController = TextEditingController();
  final _breedNameController = TextEditingController();
  final _feedRatioController = TextEditingController();
  final _monthlyFeedController = TextEditingController();
  final _feedBrandController = TextEditingController();
  final _ageCalvingController = TextEditingController();
  final _avgWeightController = TextEditingController();
  final _avgMilkController = TextEditingController();
  final _remarkController = TextEditingController();
  final _ageBullController = TextEditingController();
  final _weightGainController = TextEditingController();

  late StreamSubscription<ConnectivityResult> subscription;
  bool _isConnected = true;
  @override
  void initState() {
    // TODO: implement initState
    isConnectedToInternet().then((value) {
      setState(() {
        _isConnected = value;
      });
      subscription = Connectivity().onConnectivityChanged.listen((result) {
        setState(() {
          _isConnected = result == ConnectivityResult.wifi || result == ConnectivityResult.mobile;
        });
      });
    });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cattleProvider = Provider.of<CattleProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  final _cattleFormKey = GlobalKey<FormState>();
  String cattleType = '';
  String userName = '';
  int currentStep = 0;

  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep -= 1;
      });
    }
  }

  Widget stepperBuilder(context, details) {
    if (currentStep == 0) {
      return Row(
        children: [
          ElevatedButton(onPressed: continueStep, child: Text('Next')),
        ],
      );
    } else if (currentStep != 2) {
      return Row(
        children: [
          ElevatedButton(onPressed: continueStep, child: Text('Next')),
          SizedBox(
            width: 20,
          ),
          OutlinedButton(onPressed: cancelStep, child: Text('Back')),
        ],
      );
    } else {
      return Row(
        children: [
          ElevatedButton(onPressed: _save, child: Text('Finish')),
          SizedBox(
            width: 20,
          ),
          OutlinedButton(onPressed: cancelStep, child: Text('Back')),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final argument =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    cattleType = argument['cattleType'].toString();
    userName = argument['userName'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(cattleType),
      ),
      body: Center(
        child: Form(
          key: _cattleFormKey,
          child: Stepper(
            currentStep: currentStep,
            onStepContinue: continueStep,
            onStepCancel: cancelStep,
            controlsBuilder: stepperBuilder,
            type: StepperType.horizontal,
            steps: [
              Step(
                title: Text('Step1'),
                isActive: currentStep == 0,
                state: currentStep > 0
                    ? StepState.complete
                    : currentStep == 0
                    ? StepState.editing
                    : StepState.disabled,
                content: Container(
                    child: Column(
                      children: [
                        if(_isConnected == false) Card(
                          elevation: 5,
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('No Internet Connection.',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Farmers Information',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        TextFormField(
                            controller: _farmerNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Farmer Name',
                              prefixIcon: Icon(Icons.account_circle),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Farmer Name!";
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: _farmerPhoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Farmer Phone Number',
                              prefixIcon: Icon(Icons.phone),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Farmer Phone Number!";
                              }
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _farmerAddressController,
                          decoration: InputDecoration(
                            labelText: 'Farmer Address',
                            prefixIcon: Icon(Icons.location_on),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'Please Enter Address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _farmerAreaController,
                          decoration: InputDecoration(
                            labelText: 'Farmer Area',
                            prefixIcon: Icon(Icons.location_city),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _farmerExperienceController,
                          decoration: InputDecoration(
                            labelText: 'Farmer Experience',
                            prefixIcon: Icon(Icons.timeline),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                      ],
                    )),
              ),
              Step(
                title: Text('Step2'),
                isActive: currentStep == 1,
                state: currentStep > 1
                    ? StepState.complete
                    : currentStep == 1
                    ? StepState.editing
                    : StepState.disabled,
                content: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Managment Information",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        cattleType == 'Dairy' ? TextFormField(
                          controller: _totalQuantityController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Total Milking Cow',
                            prefixIcon: Icon(Icons.production_quantity_limits_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ): TextFormField(
                          controller: _totalQuantityController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Total Fattening Bull',
                            prefixIcon: Icon(Icons.production_quantity_limits_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: _breedNameController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Breed Name',
                              prefixIcon: Icon(Icons.merge_type),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _feedRatioController,
                          decoration: InputDecoration(
                            labelText: 'Feed Ratio',
                            prefixIcon: Icon(Icons.aspect_ratio),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _monthlyFeedController,
                          decoration: InputDecoration(
                            labelText: 'Feed/Month (Kg)',
                            prefixIcon: Icon(Icons.gas_meter),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _feedBrandController,
                          decoration: InputDecoration(
                            labelText: 'Feed Brand',
                            prefixIcon: Icon(Icons.house_sharp),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                      ],
                    )),
              ),
              Step(
                title: Text('Step3'),
                isActive: currentStep == 2,
                state: currentStep > 2
                    ? StepState.complete
                    : currentStep == 2
                    ? StepState.editing
                    : StepState.disabled,
                content: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Other Information',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        cattleType == 'Dairy' ? TextFormField(
                          controller: _ageCalvingController,
                          decoration: InputDecoration(
                            labelText: 'Age of Calving',
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ) : TextFormField(
                          controller: _ageBullController,
                          decoration: InputDecoration(
                            labelText: 'Age of The Bull',
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _avgWeightController,
                          decoration: InputDecoration(
                            labelText: 'Avg Body Weight',
                            prefixIcon: Icon(Icons.monitor_weight_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        cattleType == 'Dairy' ? TextFormField(
                          controller: _avgMilkController,
                          decoration: InputDecoration(
                            labelText: 'Avg Milk/Day',
                            prefixIcon: Icon(Icons.water_drop_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ) : TextFormField(
                          controller: _weightGainController,
                          decoration: InputDecoration(
                            labelText: 'Weight gain',
                            prefixIcon: Icon(Icons.monitor_weight_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _remarkController,
                          decoration: InputDecoration(
                            labelText: 'Remark',
                            prefixIcon: Icon(Icons.note_alt_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    EasyLoading.show(status: 'Please Wait', dismissOnTap: false);
    if (_cattleFormKey.currentState!.validate()) {
      try {
        final cattleModel = CattleModel(
          officerName: userName,
          cattletype: cattleType,
          visitingDate: getFormattedDate(DateTime.now()),
          fName: _farmerNameController.text,
          fAddress: _farmerAddressController.text,
          fArea: _farmerAreaController.text,
          fPhone: _farmerPhoneController.text,
          fExperience: _farmerExperienceController.text,
          totalQuantity: _totalQuantityController.text,
          breed: _breedNameController.text,
          feedRatio: _feedRatioController.text,
          monthlyFeed: _monthlyFeedController.text,
          feedBrand: _feedBrandController.text,
          ageCalving: _ageCalvingController.text,
          bodyWeight: _avgWeightController.text,
          avgMilk: _avgMilkController.text,
          ageBull: _ageBullController.text,
          weightGain: _weightGainController.text,
          remark: _remarkController.text,
        );
        await cattleProvider.addcattleData(cattleModel);
        EasyLoading.dismiss();
        reset();
        Fluttertoast.showToast(
          msg: 'Upload Done.',
          fontSize: 18,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_LONG,
        );
      } catch (error) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: '${error.toString()}',
          fontSize: 18,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }else{
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: 'Required Fields Are Not Fill Up.',
        fontSize: 18,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _farmerNameController.dispose();
    _farmerPhoneController.dispose();
    _farmerAddressController.dispose();
    _farmerAreaController.dispose();
    _farmerExperienceController.dispose();
    _totalQuantityController.dispose();
    _breedNameController.dispose();
    _feedRatioController.dispose();
    _monthlyFeedController.dispose();
    _feedBrandController.dispose();
    _ageCalvingController.dispose();
    _avgWeightController.dispose();
    _avgMilkController.dispose();
    _remarkController.dispose();
    _ageBullController.dispose();
    _weightGainController.dispose();
    super.dispose();
  }
  void reset() {
    // TODO: implement dispose
    _farmerNameController.clear();
    _farmerPhoneController.clear();
    _farmerAddressController.clear();
    _farmerAreaController.clear();
    _farmerExperienceController.clear();
    _totalQuantityController.clear();
    _breedNameController.clear();
    _feedRatioController.clear();
    _monthlyFeedController.clear();
    _feedBrandController.clear();
    _ageCalvingController.clear();
    _avgWeightController.clear();
    _avgMilkController.clear();
    _remarkController.clear();
    _ageBullController.clear();
    _weightGainController.clear();
    super.dispose();
  }

}
