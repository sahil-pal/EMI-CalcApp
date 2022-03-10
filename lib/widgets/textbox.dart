import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatelessWidget {
  
  String label;
  String helpertext;
  TextEditingController tc;
  IconData icon;
  
  TextBox(this.label,this.helpertext,this.tc,this.icon);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: tc,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      border : OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      label: Text(label.toUpperCase(),style: GoogleFonts.roboto(fontSize:22,color:Colors.orange,fontWeight:FontWeight.bold)),
      hintText: 'Type Here...',
      helperText: helpertext,
      hintStyle: GoogleFonts.openSans(fontSize: 18),
      suffixIcon: Icon(icon,color: Colors.black,)
      ),
    );
  }
}