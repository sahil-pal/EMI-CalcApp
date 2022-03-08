import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class EMICalcWidget extends StatefulWidget {

  @override
  _EMICalcWidgetState createState() => _EMICalcWidgetState();

}


class _EMICalcWidgetState extends State<EMICalcWidget> {

  //String path_rupeesymbol = 'images/symbol-rupees.png';

  TextEditingController tcAmount = TextEditingController();
  TextEditingController tcROI = TextEditingController();
  
  late var principalAmount;
  late var roi;
  late double _years;
  late double loanEMI;
  late double interestPayable;
  late double totalPayment;

  late Map<String, double> dataMap;

  @override
  void initState(){
    principalAmount = 0.0;
    roi = 0;
    _years = 0;
    loanEMI = 0;
    interestPayable = 0.0;
    totalPayment = 0;
    dataMap = {
      "Principal Loan Amount": this.principalAmount,
      "Total Interest": this.interestPayable,
    };
  }

  _calEMI({required principalAmount,required roi, required years}){
    print('==> inside the cal emi method .... ${principalAmount.runtimeType} , ${roi.runtimeType} ');
    interestPayable = (principalAmount*(roi/100)*years);
    totalPayment = principalAmount + interestPayable;
    loanEMI = totalPayment/12;
    dataMap = {
      "Principal Loan Amount": 50000,
      "Total Interest": this.interestPayable,
    };
  }

  _getTextField({required String label,required String helpertext,required TextEditingController tc,required Icon icon}){
    return TextField(
      controller: tc,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      border : OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(label.toUpperCase(),style: GoogleFonts.roboto(fontSize:22,color:Colors.orange,fontWeight:FontWeight.bold)),
      hintText: 'Type Here...',
      helperText: helpertext,
      hintStyle: GoogleFonts.openSans(fontSize: 18),
      suffixIcon: icon
      ),
    );
  }

  _getSlider(){
    return Container(
      height: 120,
      decoration: BoxDecoration(
      border: Border.all(
      width: 1,
      color: Colors.grey,
      ),
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
        Text('Tenure Years',style : _getStyle(size: 25, color: Colors.red)),
        Slider(
          value: _years, 
          max: 50,
          divisions: 20,
          label: _years.toStringAsPrecision(3),
          onChanged: (double years){
          setState(() {
          _years = years;
        });
      }),
      Text(_years.toStringAsPrecision(3),style: _getStyle(size: 30, color: Colors.black),)
      ],
      ),
    );
  }

  _getStyle({required double size,required Color color, FontWeight = FontWeight.bold}){
    return GoogleFonts.oswald(fontSize: size,fontWeight: FontWeight,color : color);
  }

  _getSizeBox({double height = 10,double width = 10}){
    return SizedBox(height: height,width: width,);
  }

  _getResultBox(Size deviceSize,{required String heading,required String value}){
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
          height: 90,
          width: deviceSize.width/2 - 20,
          decoration: BoxDecoration(
          border: Border.all(
          width: 1,
          color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10)
        ) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(heading,style: _getStyle(size: 18, color: Colors.purple),),
            Text('₹ '+value,style: _getStyle(size: 18, color: Colors.black),)
          ],
        ),
      ),
    );
  }

  _printResult(Size deviceSize){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getResultBox(deviceSize,heading: 'Loan EMI',value : loanEMI.toStringAsFixed(2)),
            _getResultBox(deviceSize,heading: 'Interest Payable',value : interestPayable.toStringAsFixed(2)),
            _getResultBox(deviceSize,heading: 'Total Payable Amount',value: totalPayment.toStringAsFixed(2)),
          ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Break-up for total Payment',style: _getStyle(size: 15, color: Colors.black, FontWeight: FontWeight.bold)),
          PieChart(
            chartRadius: (MediaQuery.of(context).size.width/2)-150 / 3.2,
            dataMap: dataMap,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
            chartValuesOptions:const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: true,
              showChartValuesInPercentage: true,
            ),
          ) 
        ],
      )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('EMI Calculator',style : GoogleFonts.oswald(fontSize: 25,color: Colors.black))),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _getSizeBox(),
                _getTextField(label: 'Enter Loan Amount', helpertext: 'Enter Amount in Rupees', tc:tcAmount,icon: Icon(Icons.money_sharp,color: Colors.black,)),
                _getSizeBox(),
                _getTextField(label: 'Enter ROI ', helpertext: 'Enter Percentage', tc: tcROI,icon: Icon(Icons.stacked_bar_chart_sharp,color: Colors.black,)),
                _getSizeBox(),
                _getSlider(),
                _getSizeBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    textStyle: _getStyle(size: 25, color: Colors.black),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  ),
                  onPressed: (){ 
                  this.principalAmount = tcAmount.text;
                  this.roi = tcROI.text;
                  setState(() {
                    _calEMI(principalAmount: double.parse(principalAmount), roi: double.parse(roi), years: _years);
                  });
                },
                child: Text('calculate'.toUpperCase()),
                ),
                _getSizeBox(height: 10),
                _printResult(deviceSize),
              ],
            ),
          ),
        ),
      )
    );
  }

}