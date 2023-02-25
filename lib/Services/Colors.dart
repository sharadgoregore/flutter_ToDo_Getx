
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorTheme{
Color bluishcolor = const Color(0xff4e5ae8);
Color yellowcolor = const Color(0xffffb746);
Color pinkcolor = const Color(0xffff4667);
}

TextStyle get subheadingstyle{
  return GoogleFonts.lato(
    textStyle:const TextStyle(
      fontSize: 20,
         //color: Colors.black,
    
    ) 
  );
}

TextStyle get headingstyle{
  return GoogleFonts.lato(
    textStyle:const TextStyle(
      fontSize: 26,
      //color: Colors.black,
      fontWeight: FontWeight.bold
    ) 
  );
}