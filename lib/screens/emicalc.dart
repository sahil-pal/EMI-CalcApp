import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import '../widgets/textbox.dart';
import '../widgets/chart.dart';
import '../widgets/output.dart';
import '../widgets/slider.dart';

class EMICalcWidget extends StatefulWidget {

  @override
  _EMICalcWidgetState createState() => _EMICalcWidgetState();

}

class _EMICalcWidgetState extends State<EMICalcWidget> {

  //String path_rupeesymbol = 'images/symbol-rupees.png';

  TextEditingController tcAmount = TextEditingController();
  TextEditingController tcROI = TextEditingController();
  late double loanEMI;
  late double _years;
  late double interestPayable;
  late double totalPayment;
  late Map<String, double> dataMap;

  @override
  void initState(){
    _years = 0;
    loanEMI = 0;
  }

  _setSliderValue(double years){
    this._years = years;
    setState(() {
      
    });
  }

  _calEMI({required principalAmount,required roi, required years}){
    print('==> inside the cal emi method .... ${principalAmount.runtimeType} , ${roi.runtimeType} ');
    interestPayable = (principalAmount*(roi/100)*years);
    totalPayment = principalAmount + interestPayable;
    loanEMI = totalPayment/12;
    dataMap = {
      "Principal Loan Amount": 50000,
      "Total Interest": interestPayable,
    };
  }

  _getSizeBox({double height = 10,double width = 10}){
    return SizedBox(height: height,width: width,);
  }

  _getTextStyle(){
    return GoogleFonts.oswald(fontSize: 25,color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('EMI Calculator',style : _getTextStyle())),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _getSizeBox(),
                TextBox('Enter Loan Amount', 'Enter Amount in Rupees', tcAmount, Icons.money_sharp),
                _getSizeBox(),
                 TextBox('Enter ROI ', 'Enter Percentage', tcROI, Icons.stacked_bar_chart_sharp),
                _getSizeBox(),
                MySlider(_setSliderValue, _years),
                _getSizeBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: _getTextStyle(),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  onPressed: (){ 
                    setState(() {
                      _calEMI(principalAmount: double.parse(tcAmount.text), roi: double.parse(tcROI.text), years: _years);
                    });
                },
                child: Text('calculate'.toUpperCase()),
                ),
                _getSizeBox(height: 10),
                OutputWidget(dataMap, loanEMI, interestPayable, totalPayment),
              ],
            ),
          ),
        ),
      )
    );
  }

}