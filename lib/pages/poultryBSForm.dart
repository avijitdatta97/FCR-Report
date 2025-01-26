import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fcr_report/models/PoultryBSModel.dart';
import 'package:fcr_report/providers/poultry_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../utils/helper_functions.dart';

class PoultryBSForm extends StatefulWidget {
  static const String routeName = '/poultryBSFrom';

  const PoultryBSForm({super.key});

  @override
  State<PoultryBSForm> createState() => _PoultryBSFormState();
}

class _PoultryBSFormState extends State<PoultryBSForm> {

  late PoultryProvider poultryProvider;
  final _farmerNameController = TextEditingController();
  final _farmerPhoneController = TextEditingController();
  final _farmerAddressController = TextEditingController();
  final _farmerAreaController = TextEditingController();

  final _dealerNameController = TextEditingController();
  final _dealerPhoneController = TextEditingController();
  final _dealerAddressController = TextEditingController();

  final _docNameController = TextEditingController();
  final _feedCompanyController = TextEditingController();
  final _docReceivedController = TextEditingController();
  final _chickenAgeController = TextEditingController();
  final _mortality1st3dayController = TextEditingController();
  final _totalMortalityController = TextEditingController();
  final _avgIntakeController = TextEditingController();
  final _avgWeightController = TextEditingController();
  final _fcrController = TextEditingController();
  final _remarkController = TextEditingController();

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
    poultryProvider = Provider.of<PoultryProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  final _poultryFormKey = GlobalKey<FormState>();

  String poultryType = '';
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
    poultryType = argument['poultryType'].toString();
    userName = argument['userName'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(poultryType),
      ),
      body: Center(
        child: Form(
          key: _poultryFormKey,
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
                        "Dealer's Information",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    TextFormField(
                        controller: _dealerNameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Dealer Name',
                          prefixIcon: Icon(Icons.account_circle),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3)),
                        ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                        controller: _dealerPhoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Dealer Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 3)),
                        ),
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _dealerAddressController,
                      decoration: InputDecoration(
                        labelText: 'Dealer Address',
                        prefixIcon: Icon(Icons.location_on),
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
                    TextFormField(
                      controller: _docNameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'DOC Name',
                        prefixIcon: Icon(Icons.medical_information_outlined),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _docReceivedController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Number of DOC Received',
                        prefixIcon: Icon(Icons.bus_alert_outlined),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _feedCompanyController,
                      decoration: InputDecoration(
                        labelText: 'Feed Company Name',
                        prefixIcon: Icon(Icons.house_outlined),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _chickenAgeController,
                      decoration: InputDecoration(
                        labelText: 'Age of Chicken',
                        prefixIcon: Icon(Icons.gas_meter_outlined),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _mortality1st3dayController,
                      decoration: InputDecoration(
                        labelText: 'Mortality with in 1st 3days',
                        prefixIcon: Icon(Icons.numbers),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _totalMortalityController,
                      decoration: InputDecoration(
                        labelText: 'Total Mortality',
                        prefixIcon: Icon(Icons.numbers),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _avgIntakeController,
                      decoration: InputDecoration(
                        labelText: 'Avg. Feed Intaker (gm)',
                        prefixIcon: Icon(Icons.read_more),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _avgWeightController,
                      decoration: InputDecoration(
                        labelText: 'Avg. Body Weight (gm)',
                        prefixIcon: Icon(Icons.line_weight),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3)),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _fcrController,
                      decoration: InputDecoration(
                        labelText: 'FCR',
                        prefixIcon: Icon(Icons.calculate_outlined),
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
    if (_poultryFormKey.currentState!.validate()) {
      try {
        final poultryBSModel = PoultryBSModel(
          officerName: userName,
          poultrytype: poultryType,
          visitingDate: getFormattedDate(DateTime.now()),
          fName: _farmerNameController.text,
          fAddress: _farmerAddressController.text,
          fArea: _farmerAreaController.text,
          fPhone: _farmerPhoneController.text,
          dName: _dealerNameController.text,
          dAddress: _dealerAddressController.text,
          dPhone: _dealerPhoneController.text,
          docName: _docNameController.text,
          docReceived: _docReceivedController.text,
          feedCompany: _feedCompanyController.text,
          chickenAge: _chickenAgeController.text,
          mortality1st3day: _mortality1st3dayController.text,
          totalMortality: _totalMortalityController.text,
          avgIntake: _avgIntakeController.text,
          avgWeight: _avgWeightController.text,
          fcr: _fcrController.text,
          remark: _remarkController.text,
        );
        if(poultryType == 'Boiler'){
          await poultryProvider.addBoilerData(poultryBSModel);
        }else if(poultryType == 'Sonali'){
          await poultryProvider.addSonaliData(poultryBSModel);
        }
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
    _dealerNameController.dispose();
    _dealerPhoneController.dispose();
    _dealerAddressController.dispose();
    _docNameController.dispose();
    _feedCompanyController.dispose();
    _docReceivedController.dispose();
    _chickenAgeController.dispose();
    _mortality1st3dayController.dispose();
    _totalMortalityController.dispose();
    _avgIntakeController.dispose();
    _avgWeightController.dispose();
    _fcrController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void reset() {
    _farmerNameController.clear();
    _farmerPhoneController.clear();
    _farmerAddressController.clear();
    _farmerAreaController.clear();
    _dealerNameController.clear();
    _dealerPhoneController.clear();
    _dealerAddressController.clear();
    _docNameController.clear();
    _feedCompanyController.clear();
    _docReceivedController.clear();
    _chickenAgeController.clear();
    _mortality1st3dayController.clear();
    _totalMortalityController.clear();
    _avgIntakeController.clear();
    _avgWeightController.clear();
    _fcrController.clear();
    _remarkController.clear();
  }
}
