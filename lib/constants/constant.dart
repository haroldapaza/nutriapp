import 'package:flutter/material.dart';

abstract class Constant {
  static const TextStyle menuStyle =TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static const TextStyle tituloReceta =TextStyle(fontSize: 28, fontWeight: FontWeight.bold,fontFamily: 'genostff');
  static const BoxDecoration colorHorizontal= BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        );
  static const BoxDecoration colorVertical= BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.cyan]),
        );
  static const Color botonColorAlimento =Colors.amber;
  static const Color botonColorReceta = Colors.black26;

  static double containerMarginLeft = 20;
  static double containerMarginTop = 20;
  static double containerMarginRight = 20;
  static double containerMarginBottom = 20;

  static Color primaryColor = const Color(0xFF040466);
  static Color colorLogoBack = const Color.fromRGBO(4, 20, 79, 1);

  static TextStyle globalTextStyle = const TextStyle(
    fontSize: 18,
  );
  static TextStyle globalTextStyleFooter = const TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontWeight: FontWeight.w700,
    fontSize: 15,
  );
  static TextStyle globalTextStyleFooterPuntaje = const TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static TextStyle globalTextStyleFind = const TextStyle(
    // color: Colors.green[600],
    fontSize: 40,
  );
  static TextStyle globalTextStyleFail = const TextStyle(
    color: Colors.red,
    fontSize: 40,
  );
  static TextStyle globalTextStyleFinDelJuego = const TextStyle(
    color: Colors.black87,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static TextStyle globalTextStyleFanLevel = const TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontWeight: FontWeight.w700,
    fontSize: 17,
  );
  static TextStyle globalTextStyleLevel = const TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static TextStyle globalTextStyleCreator = const TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static TextStyle globalTextStylePuntaje = const TextStyle(
    color: Colors.white,
    fontFamily: 'Avenir',
    fontWeight: FontWeight.w700,
    fontSize: 40,
  );

  static ButtonStyle styleElevatedButtom = ElevatedButton.styleFrom(
    primary: Colors.teal,
    onPrimary: Colors.white,
    onSurface: Colors.grey,
  );
  static ButtonStyle styleElevatedButtomResetGame = ElevatedButton.styleFrom(
    primary: Colors.teal[300],
    onPrimary: Colors.white70,
    onSurface: Colors.black,
    elevation: 0.0,
  );

  static BoxDecoration globalBoxDecoration = BoxDecoration(
    // borderRadius: BorderRadius.only(
    //   bottomLeft: Radius.circular(20.0),
    //   bottomRight: Radius.circular(10.0),
    // ),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        // Colors.red,
        Colors.green[400]!,
        Colors.blue,
      ],
    ),
  );
  static BoxDecoration globalBoxDecorationInverse = BoxDecoration(
    // borderRadius: BorderRadius.only(
    //   bottomLeft: Radius.circular(20.0),
    //   bottomRight: Radius.circular(10.0),
    // ),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        // Colors.red,
        Colors.green[400]!,
        Colors.blue,
      ],
    ),
  );
  static BoxDecoration globalBoxDecorationFinDelJuego = BoxDecoration(
    // borderRadius: BorderRadius.only(
    //   bottomLeft: Radius.circular(20.0),
    //   bottomRight: Radius.circular(10.0),
    // ),
    borderRadius: const BorderRadius.all(
      Radius.circular(16.0),
    ),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        // Colors.red,
        Colors.green[400]!,
        Colors.blue,
      ],
    ),
  );

  // ####################### ESTILOS DE BONUS ###########################
  // ####################### FIN ESTILOS DE BONUS ###########################
}
