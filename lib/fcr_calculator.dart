import 'package:flutter/material.dart';

class FCRCalculator extends StatefulWidget {
  static const String routName ='/fcrCalculator';
  const FCRCalculator({super.key});

  @override
  State<FCRCalculator> createState() => _FCRCalculatorState();
}

class _FCRCalculatorState extends State<FCRCalculator> {

  var _feedGiven = TextEditingController();
  var _weightGain = TextEditingController();

  var fcrResult ="";
  final _fcrCalculationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FCR Calculator')),
      body: Center(
        child: Form(
          key: _fcrCalculationKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text('FCR Calculator'),
                TextFormField(
                  controller: _feedGiven,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Feed Given'),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3)
                    )
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter the feed given';
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _weightGain,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Weight Gain'),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3)
                    )
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter the weight gain';
                    }
                  },
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed:_calculation, child: Text('Calculate')),
                SizedBox(height: 10,),
                Text(fcrResult),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _calculation(){
    if(_fcrCalculationKey.currentState!.validate()){
      try{
        var fcrFeedGiven = double.parse(_feedGiven.text.toString());
        var fcrWeightGain = double.parse(_weightGain.text.toString());
        var result = (fcrFeedGiven / fcrWeightGain);
        setState(() {
          fcrResult = "FCR is : ${result}";
        });
      }catch(error){}
    }else{

    }
  }
}
