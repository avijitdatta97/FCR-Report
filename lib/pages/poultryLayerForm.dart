import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fcr_report/models/PoultryLayerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/poultry_provider.dart';
import '../utils/helper_functions.dart';

class PoultryLayerForm extends StatefulWidget {
  static const String routeName = '/poultryLayerForm';
  const PoultryLayerForm({super.key});

  @override
  State<PoultryLayerForm> createState() => _PoultryLayerFormState();
}

class _PoultryLayerFormState extends State<PoultryLayerForm> {

  late PoultryProvider poultryProvider;
  final _farmerNameController = TextEditingController();
  final _farmerPhoneController = TextEditingController();
  final _farmerAddressController = TextEditingController();
  final _farmerAreaController = TextEditingController();

  final _dealerNameController = TextEditingController();
  final _dealerPhoneController = TextEditingController();
  final _dealerAddressController = TextEditingController();

  final _docNameController = TextEditingController();
  final _docCompanyController = TextEditingController();
  final _initialQuantityController = TextEditingController();
  final _presentQuantityController = TextEditingController();
  final _mortalityController = TextEditingController();
  final _avgWeightController = TextEditingController();
  final _birdsAgeController = TextEditingController();

  final _feedCompanyController = TextEditingController();
  final _avgIntakeController = TextEditingController();
  final _lightingController = TextEditingController();
  final _vaccinationController = TextEditingController();

  final _presentProductionController = TextEditingController();
  final _eggWeightController = TextEditingController();
  final _remarkController = TextEditingController();

  final _poultryLayerFormKey = GlobalKey<FormState>();

  late StreamSubscription<ConnectivityResult> subscription;
  bool _isConnected = true;


  int currentStep = 0;
  String poultryType = '';
  String userName = '';

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
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    poultryProvider = Provider.of<PoultryProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  continueStep() {
    if (currentStep < 3) {
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
    } else if (currentStep != 3) {
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
    final argument = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    userName = argument['userName'].toString();
    poultryType = argument['poultryType'].toString();
    return Scaffold(
      appBar: AppBar(title: Text(poultryType),),
      body: Center(
        child: Form(
          key: _poultryLayerFormKey,
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
                            "Farmer and Dealer Information",
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
                        ),
                        SizedBox(height: 10),
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
                            "Bird's Information",
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
                            prefixIcon: Icon(Icons.house),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _docCompanyController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'DOC Company Name',
                            prefixIcon: Icon(Icons.house),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _initialQuantityController,
                          decoration: InputDecoration(
                            labelText: 'Initial Quantity',
                            prefixIcon: Icon(Icons.production_quantity_limits),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _presentQuantityController,
                          decoration: InputDecoration(
                            labelText: 'Present Quantity',
                            prefixIcon: Icon(Icons.production_quantity_limits),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _mortalityController,
                          decoration: InputDecoration(
                            labelText: 'Mortality (%)',
                            prefixIcon: Icon(Icons.percent),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _avgWeightController,
                          decoration: InputDecoration(
                            labelText: 'Avg. Bird Weight',
                            prefixIcon: Icon(Icons.line_weight),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _birdsAgeController,
                          decoration: InputDecoration(
                            labelText: 'Age of birds (weeks)',
                            prefixIcon: Icon(Icons.calendar_month_outlined),
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
                            'Management Information',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: _feedCompanyController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Feed Company Name',
                            prefixIcon: Icon(Icons.holiday_village_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _avgIntakeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Avg. Feed Intake',
                            prefixIcon: Icon(Icons.read_more),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _lightingController,
                          decoration: InputDecoration(
                            labelText: 'Lighting',
                            prefixIcon: Icon(Icons.lightbulb),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _vaccinationController,
                          decoration: InputDecoration(
                            labelText: 'Vaccination',
                            prefixIcon: Icon(Icons.vaccines),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                      ],
                    )),
              ),
              Step(
                title: Text('Step4'),
                isActive: currentStep == 3,
                state: currentStep > 3
                    ? StepState.complete
                    : currentStep == 3
                    ? StepState.editing
                    : StepState.disabled,
                content: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Eggs Production',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        TextFormField(
                          controller: _presentProductionController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Present Production (%)',
                            prefixIcon: Icon(Icons.production_quantity_limits_outlined),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _eggWeightController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Egg Weight (gm)',
                            prefixIcon: Icon(Icons.gas_meter),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _remarkController,
                          decoration: InputDecoration(
                            labelText: 'Remarks',
                            prefixIcon: Icon(Icons.note_alt),
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
    if (_poultryLayerFormKey.currentState!.validate()) {
      try {
        final poultryLayerModel = PoultryLayerModel(
            officerName : userName,
            poultrytype : poultryType,
            visitingDate: getFormattedDate(DateTime.now()),
            fname : _farmerNameController.text,
            fAddress : _farmerAddressController.text,
            fArea : _farmerAreaController.text,
            fPhone : _farmerPhoneController.text,
            dName : _dealerNameController.text,
            dAddress : _dealerAddressController.text,
            dPhone : _dealerPhoneController.text,
            docBreed : _docNameController.text,
            docCompany : _docCompanyController.text,
            initialQuantity : _initialQuantityController.text,
            presentQuantity : _presentQuantityController.text,
            mortality : _mortalityController.text,
            avgBirdWeight : _avgWeightController.text,
            birdAge : _birdsAgeController.text,
            feedName : _feedCompanyController.text,
            avgIntake : _avgIntakeController.text,
            lighting : _lightingController.text,
            vaccination : _vaccinationController.text,
            production : _presentProductionController.text,
            eggWeight : _eggWeightController.text,
            remark : _remarkController.text,
        );
        await poultryProvider.addLayerData(poultryLayerModel);
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
    _docCompanyController.dispose();
    _initialQuantityController.dispose();
    _presentQuantityController.dispose();
    _mortalityController.dispose();
    _avgWeightController.dispose();
    _birdsAgeController.dispose();
    _feedCompanyController.dispose();
    _avgIntakeController.dispose();
    _lightingController.dispose();
    _vaccinationController.dispose();
    _presentProductionController.dispose();
    _eggWeightController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  void reset() {
    // TODO: implement dispose
    _farmerNameController.clear();
    _farmerPhoneController.clear();
    _farmerAddressController.clear();
    _farmerAreaController.clear();
    _dealerNameController.clear();
    _dealerPhoneController.clear();
    _dealerAddressController.clear();
    _docNameController.clear();
    _docCompanyController.clear();
    _initialQuantityController.clear();
    _presentQuantityController.clear();
    _mortalityController.clear();
    _avgWeightController.clear();
    _birdsAgeController.clear();
    _feedCompanyController.clear();
    _avgIntakeController.clear();
    _lightingController.clear();
    _vaccinationController.clear();
    _presentProductionController.clear();
    _eggWeightController.clear();
    _remarkController.clear();
  }
}
