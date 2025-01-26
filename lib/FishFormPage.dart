import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fcr_report/models/FishModel.dart';
import 'package:fcr_report/providers/fish_provider.dart';
import 'package:fcr_report/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FishFormPage extends StatefulWidget {
  static const String routeName = '/fishformpage';

  const FishFormPage({Key? key}) : super(key: key);

  // final String fishTypetilapia;
  @override
  State<FishFormPage> createState() => _FishFormPageState();
}

class _FishFormPageState extends State<FishFormPage> {
  late FishProvider fishProvider;
  final _farmerNameController = TextEditingController();
  final _farmerPhoneController = TextEditingController();
  final _farmerAddressController = TextEditingController();
  final _farmerAreaController = TextEditingController();
  final _collectionDealerController = TextEditingController();
  final _farmerNoteController = TextEditingController();

  final _babyAgeController = TextEditingController();
  final _babyweightController = TextEditingController();
  final _babyStockingDayController = TextEditingController();
  final _babySourceController = TextEditingController();
  final _babyDensityController = TextEditingController();
  final _babyMortalityController = TextEditingController();
  final _babySamplingDateController = TextEditingController();

  final _feedCompanyController = TextEditingController();
  final _feedTypeController = TextEditingController();
  final _feedSizeController = TextEditingController();
  final _dailyAmountController = TextEditingController();
  final _totalFeedController = TextEditingController();
  final _percentageOfFeedController = TextEditingController();
  final _totalFishWeightController = TextEditingController();
  final _averageDailyGainController = TextEditingController();
  final _fishFCRController = TextEditingController();
  final _appliedTimeController = TextEditingController();

  final _supplimentoryController = TextEditingController();
  final _depthController = TextEditingController();
  final _dailyWaterSupplyController = TextEditingController();

  DateTime? stockingDate;

  String showMeg = '';
  String fishType = '';
  String userName = '';
  late StreamSubscription<ConnectivityResult> subscription;
  bool _isConnected = true;

  final _formkey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    fishProvider = Provider.of<FishProvider>(context, listen: false);
    super.didChangeDependencies();
  }

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

  int currentstep = 0;

  continuestep() {
    if (currentstep < 3) {
      setState(() {
        currentstep += 1;
      });
    }
  }

  cancelstep() {
    if (currentstep > 0) {
      setState(() {
        currentstep -= 1;
      });
    }
  }

  tappedstep(int value) {
    setState(() {
      currentstep = value;
    });
  }

  Widget stepperbuilder(context, details) {
    if (currentstep == 0) {
      return Row(
        children: [
          ElevatedButton(onPressed: continuestep, child: Text("Next")),
        ],
      );
    } else if (currentstep != 3) {
      return Row(
        children: [
          ElevatedButton(onPressed: continuestep, child: Text("Next")),
          SizedBox(
            width: 20,
          ),
          OutlinedButton(onPressed: cancelstep, child: const Text("Back")),
        ],
      );
    } else {
      return Row(
        children: [
          ElevatedButton(onPressed: _save, child: const Text("Finish")),
          SizedBox(
            width: 20,
          ),
          OutlinedButton(onPressed: cancelstep, child: const Text("Back")),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, String>;
    fishType = arguments['fishType'].toString();
    userName = arguments['userName'].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(fishType),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: Stepper(
            currentStep: currentstep,
            onStepContinue: continuestep,
            onStepCancel: cancelstep,
            type: StepperType.horizontal,
            onStepTapped: tappedstep,
            controlsBuilder: stepperbuilder,
            steps: [
              Step(
                title: const Text("Step 1"),
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
                          controller: _collectionDealerController,
                          decoration: InputDecoration(
                            labelText: 'Feed Collection Dealer Name',
                            prefixIcon:
                            Icon(Icons.drive_file_rename_outline_rounded),
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
                          controller: _farmerNoteController,
                          decoration: InputDecoration(
                            labelText: 'Note',
                            prefixIcon: Icon(Icons.note_alt),
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
                isActive: currentstep > 0,
                state: currentstep > 0
                    ? StepState.complete
                    : currentstep == 0
                    ? StepState.editing
                    : StepState.disabled,
              ),
              Step(
                title: const Text("Step 2"),
                content: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Baby Fish Information",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        TextFormField(
                            controller: _babyAgeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Age (Day)',
                              prefixIcon: Icon(Icons.calendar_month),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: _babyweightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Initial Weight',
                              prefixIcon: Icon(Icons.monitor_weight),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _babySourceController,
                          decoration: InputDecoration(
                            labelText: 'Source of Baby Fish',
                            prefixIcon: Icon(Icons.source),
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
                          controller: _babyDensityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Density (Decimal)',
                            prefixIcon: Icon(Icons.confirmation_number),
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
                          controller: _babyMortalityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Mortality',
                            prefixIcon: Icon(Icons.numbers),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 3)),
                          ),
                          validator: (value) {
                            return null;
                          },
                        ),
                        // SizedBox(height: 10),
                        // Card(
                        //   elevation: 5,
                        //   child: Row(
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.all(20.0),
                        //         child: Text('Sampling Date : ${getFormattedDate(DateTime.now())}'),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // TextFormField(
                        //   controller: _babySamplingDateController,
                        //   decoration: InputDecoration(
                        //     labelText: 'Sampling Date',
                        //     prefixIcon: Icon(Icons.calendar_month),
                        //     filled: true,
                        //     border: OutlineInputBorder(
                        //         borderSide: BorderSide(width: 3)),
                        //   ),
                        //   validator: (value) {
                        //     return null;
                        //   },
                        // ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  onPressed: _selectDate,
                                  label: Text('Select Stocking Date'),
                                  icon: Icon(Icons.calendar_month),),
                                Text(stockingDate == null
                                    ? 'No Date Seleted'
                                    : getFormattedDate(stockingDate!)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                isActive: currentstep > 1,
                state: currentstep > 1
                    ? StepState.complete
                    : currentstep == 1
                    ? StepState.editing
                    : StepState.disabled,
              ),
              Step(
                title: const Text("Step 3"),
                content: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Feed Information",
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
                              prefixIcon: Icon(Icons.factory),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: _feedTypeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Feed Type',
                              prefixIcon: Icon(Icons.type_specimen_outlined),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _feedSizeController,
                          decoration: InputDecoration(
                            labelText: 'Feed Size',
                            prefixIcon: Icon(Icons.format_size),
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
                          controller: _dailyAmountController,
                          decoration: InputDecoration(
                            labelText: 'Daily Amount of Feed',
                            prefixIcon: Icon(Icons.line_weight),
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
                          controller: _totalFeedController,
                          decoration: InputDecoration(
                            labelText: 'Total Feed',
                            prefixIcon: Icon(Icons.all_inclusive),
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
                          controller: _percentageOfFeedController,
                          decoration: InputDecoration(
                            labelText: 'Percentage of Feed',
                            prefixIcon: Icon(Icons.percent),
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
                          controller: _totalFishWeightController,
                          decoration: InputDecoration(
                            labelText: 'Total Weight',
                            prefixIcon: Icon(Icons.monitor_weight_outlined),
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
                          controller: _averageDailyGainController,
                          decoration: InputDecoration(
                            labelText: 'Average Daily Gain',
                            prefixIcon: Icon(Icons.grain),
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
                          controller: _fishFCRController,
                          decoration: InputDecoration(
                            labelText: 'FCR',
                            prefixIcon: Icon(Icons.data_exploration),
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
                          controller: _appliedTimeController,
                          decoration: InputDecoration(
                            labelText: 'Applied Time',
                            prefixIcon: Icon(Icons.timer_rounded),
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
                isActive: currentstep > 2,
                state: currentstep > 2
                    ? StepState.complete
                    : currentstep == 2
                    ? StepState.editing
                    : StepState.disabled,
              ),
              Step(
                title: const Text("Step 4"),
                content: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            'Management',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                        TextFormField(
                            controller: _supplimentoryController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Supplimentory',
                              prefixIcon: Icon(Icons
                                  .medical_information_outlined),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                            controller: _depthController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Depth',
                              prefixIcon: Icon(Icons.height_outlined),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 3)),
                            ),
                            validator: (value) {
                              return null;
                            }),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _dailyWaterSupplyController,
                          decoration: InputDecoration(
                            labelText: 'Water Supply',
                            prefixIcon: Icon(Icons.water),
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
                isActive: currentstep > 3,
                state: currentstep > 3
                    ? StepState.complete
                    : currentstep == 3
                    ? StepState.editing
                    : StepState.disabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    if(stockingDate == null){
      showMsg(context, 'Stocking Date Not Selected');
      return;
    }
    EasyLoading.show(status: 'Please Waite', dismissOnTap: false);
    if (_formkey.currentState!.validate()) {
      try {
        final fishModel = FishModel(
          officerName: userName,
          fishtype: fishType,
          fname: _farmerNameController.text,
          fphonenumber: _farmerPhoneController.text,
          faddress: _farmerAddressController.text,
          farea: _farmerAreaController.text,
          fdealername: _collectionDealerController.text,
          fnote: _farmerNoteController.text,
          fishage: _babyAgeController.text,
          fishweight: _babyweightController.text,
          fishstockingday: getFormattedDate(stockingDate!),
          fishsource: _babySourceController.text,
          fishdensity: _babyDensityController.text,
          fishmortality: _babyMortalityController.text,
          fishsamplingday: getFormattedDate(DateTime.now()),
          ffeedcompany: _feedCompanyController.text,
          ffeedtype: _feedTypeController.text,
          ffeedsize: _feedSizeController.text,
          famountoffeed: _dailyAmountController.text,
          ftotalfeed: _totalFeedController.text,
          fpercentageoffeed: _percentageOfFeedController.text,
          ftotalfishweight: _totalFishWeightController.text,
          fdailygain: _averageDailyGainController.text,
          ffcr: _fishFCRController.text,
          fappliedtime: _appliedTimeController.text,
          fsupplimentory: _supplimentoryController.text,
          fdepth: _depthController.text,
          fwatersupply: _dailyWaterSupplyController.text,
        );
        await fishProvider.addTialapiaData(fishModel);
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: 'Upload Done.',
          fontSize: 18,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_LONG,
        );
        _reset();
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
    }
    else {
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
  } //End Save Function

  void _selectDate() async {
    final selectedDate = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 2),
        lastDate: DateTime.now()
    );
    if(selectedDate != null){
      setState(() {
        stockingDate = selectedDate;
      });
    }
  }

  @override
  void dispose() {
    _farmerNameController.dispose();
    _farmerPhoneController.dispose();
    _farmerAddressController.dispose();
    _farmerAreaController.dispose();
    _collectionDealerController.dispose();
    _farmerNoteController.dispose();

    _babyAgeController.dispose();
    _babyweightController.dispose();
    _babyStockingDayController.dispose();
    _babySourceController.dispose();
    _babyDensityController.dispose();
    _babyMortalityController.dispose();
    _babySamplingDateController.dispose();

    _feedCompanyController.dispose();
    _feedTypeController.dispose();
    _feedSizeController.dispose();
    _dailyAmountController.dispose();
    _totalFeedController.dispose();
    _percentageOfFeedController.dispose();
    _totalFishWeightController.dispose();
    _averageDailyGainController.dispose();
    _fishFCRController.dispose();
    _appliedTimeController.dispose();

    _supplimentoryController.dispose();
    _depthController.dispose();
    _dailyWaterSupplyController.dispose();

    super.dispose();
  }

  void _reset() {
    _farmerNameController.clear();
    _farmerPhoneController.clear();
    _farmerAddressController.clear();
    _farmerAreaController.clear();
    _collectionDealerController.clear();
    _farmerNoteController.clear();

    _babyAgeController.clear();
    _babyweightController.clear();
    _babyStockingDayController.clear();
    _babySourceController.clear();
    _babyDensityController.clear();
    _babyMortalityController.clear();
    _babySamplingDateController.clear();

    _feedCompanyController.clear();
    _feedTypeController.clear();
    _feedSizeController.clear();
    _dailyAmountController.clear();
    _totalFeedController.clear();
    _percentageOfFeedController.clear();
    _totalFishWeightController.clear();
    _averageDailyGainController.clear();
    _fishFCRController.clear();
    _appliedTimeController.clear();

    _supplimentoryController.clear();
    _depthController.clear();
    _dailyWaterSupplyController.clear();
  }
}
