import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySlider extends StatelessWidget {

  Function fn;
  double _years;
  MySlider(Function this.fn,double this._years);

  _getStyle({required double size,required Color color, FontWeight = FontWeight.bold}){
    return GoogleFonts.oswald(fontSize: size,fontWeight: FontWeight,color : color);
  }

  @override
  Widget build(BuildContext context) {
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
            fn(years);
          }
        ),
        Text(_years.toStringAsPrecision(3),style: _getStyle(size: 20, color: Colors.black),)
      ],
      ),
    );
  }
}