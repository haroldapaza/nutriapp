
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nutriapp/pages/navegation/pages/distribucionCalorica/data/distribucion.data.dart';
import 'package:nutriapp/pages/navegation/pages/distribucionCalorica/data/distridisaen.data.dart';
import 'package:nutriapp/pages/navegation/pages/distribucionCalorica/models/macrositem.model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DistribucionC extends StatefulWidget {
  const DistribucionC({Key? key}) : super(key: key);

  @override
  _DistribucionCState createState() => _DistribucionCState();
}

class _DistribucionCState extends State<DistribucionC> {
  int touchedIndex = 0;
  bool _isLoading = false;
  dynamic token;
  dynamic userId;
  dynamic nombre;
  dynamic apellido;
  dynamic sexo;
  dynamic edad;
  dynamic altura=1.0;
  dynamic peso=1.0;
  dynamic actiFisica=2;
  SharedPreferences? sharedPreferences;
  MacroNutrienetes? macroNutrientes;
  
  double indiceMasaCorporal=0.0;
  double edadMetabolica=0.0;
  double tasaMetabolicaBsal=0.0;

  List<String> nombreCardCuarto = [
    'Indice Masa Corporal (IMC)',
    'Edad Metabolica (EM)',
    'Tasa Metabolica Basal (TMB)'
  ];

  var imageUrl =
      "https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";

  @override
  void initState() {
    sharedPref();
    
    super.initState();
  }
  
  sharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // token =sharedPreferences!.getString('token');
    // userId= sharedPreferences!.getInt('userid');
    // nombre= sharedPreferences!.getString('nombre');
    // apellido= sharedPreferences!.getString('apellido');

    sexo = sharedPreferences!.getString('sexo');
    edad = sharedPreferences!.getInt('edad');
    altura = sharedPreferences!.getInt('altura');
    peso = sharedPreferences!.getInt('peso');
    actiFisica = sharedPreferences!.getInt('actifisica');

    if (sexo != "" && edad != "" && altura != "" &&sexo != null && edad != null && altura != null) {
      // print(edad);
      // print(altura);
      await sharedPreferences!.setString("proteinas",getMacrosItem(peso, altura, edad, actiFisica, sexo)[0].gramos.toString());
      await sharedPreferences!.setString("grasas",getMacrosItem(peso, altura, edad, actiFisica, sexo)[1].gramos.toString());
      await sharedPreferences!.setString("carbs",getMacrosItem(peso, altura, edad, actiFisica, sexo)[2].gramos.toString());
      await sharedPreferences!.setString("kcal",getMacrosTotalKcal(peso, altura, edad, actiFisica, sexo).toString());
      indiceMasaCorporal=getIndiceMasaCorporal(peso, altura, edad, actiFisica, sexo);
      edadMetabolica=getEdadMetabolica(peso, altura, edad, actiFisica, sexo);
      tasaMetabolicaBsal=getTasaMetabolicaBasal(peso, altura, edad, actiFisica, sexo);
      setState(() {
        
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  
                  
                  cardPrimero(),
                  cardSegundo(),
                  cardTercero(),
                  cardCuarta()
                ],
              ));
  }
  
  cardPrimero() {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          // ElevatedButton(
          //     child: Text('Basic Waiting Alert'),
          //     // onPressed: () =>
          // ),
          Container(
              margin: const EdgeInsets.only(top: 15.0, left: 15, right: 10),
              child: const Text(
                  "En funcionamiento de sus necesidades y objetivos, debe comer esta cantidad de calorias por dia",
                  style: TextStyle(fontFamily: 'genostff',fontSize: 18),                  
                  )),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 12, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                      // padding: const EdgeInsets.all(10.0),
                      height: 50,
                      child: Image.asset(
                        "assets/imagenes/calorias.png",
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Text(
                        "CALORÍAS",
                        style: TextStyle(color: Colors.lightBlue, fontSize: 20,fontFamily: 'genostff'),
                      ),
                      Text.rich(
                        TextSpan(
                          text: (getMacrosTotalKcal(peso, altura, edad, actiFisica, sexo)).toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 49,
                              fontFamily: 'genostff',
                              color: Colors.lightBlue), // default text style
                          children: const <TextSpan>[
                            TextSpan(
                                text: "Calorias por dias",
                                style: TextStyle(
                                    fontFamily: 'genostff',fontSize: 15, color: Colors.blueGrey)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  cardSegundo() {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 15.0, left: 0, right: 10),
              child: const Text("Distribucion de Macronutrientes",style: TextStyle(fontFamily: 'genostff',fontSize: 18),)),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 3; i++)
                  cardSegundoItem(getMacrosItem(peso, altura, edad, actiFisica, sexo)[i]),
              ],
            ),
          ),
          queso(getMacrosItem(peso, altura, edad, actiFisica, sexo))
        ],
      ),
    );
  }

  coloresItem(int valor) {
    if (valor == 0) {
      return const Color(0xFFF9A825);
    }
    if (valor == 1) {
      return const Color(0xFF4CAF50);
    }
    if (valor == 2) {
      return const Color(0xFFFF5722);
    }
  }

  cardSegundoItem(MacrosItemC macrosItem) {
    return Column(
      children: [
        Text(macrosItem.tituloG.toString(),style: const TextStyle(fontFamily: 'genostff',fontWeight: FontWeight.bold,fontSize: 16)),
        Card(
          elevation: 10,
          color: coloresItem(macrosItem.colorG!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, left: 15, right: 10, bottom: 10),
                  height: 40,
                  child: Image.asset(macrosItem.imagenG.toString())),
              Container(
                  margin: const EdgeInsets.only(top: 0.0, left: 15, right: 10),
                  child: Text(
                    macrosItem.calorias.toString() + " Kcal",
                    style: const TextStyle(color: Colors.white,fontFamily: 'genostff',fontSize: 15),
                  )),
              Container(
                  margin:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  child: Text(
                    macrosItem.gramos.toString() + " g",
                    style: const TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'genostff'),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  queso(List<MacrosItemC> macrosItem) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(macrosItem)),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<MacrosItemC> macrosItem) {
    double totalKcal = 0.0;
    for (int h = 0; h < 3; h++) {
      totalKcal += redondeo(macrosItem[h].caloriasG!, 1);
    }

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFFF9A825),
            value: procentaje(macrosItem[i].caloriasG, totalKcal),
            title:
                procentaje(macrosItem[i].caloriasG, totalKcal).toString() + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'genostff',
                color: const Color(0xffffffff)),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFF4CAF50),
            value: procentaje(macrosItem[i].caloriasG, totalKcal),
            title:
                procentaje(macrosItem[i].caloriasG, totalKcal).toString() + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'genostff',
                color: const Color(0xffffffff)),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFFFF5722),
            value: procentaje(macrosItem[i].caloriasG, totalKcal),
            title:
                procentaje(macrosItem[i].caloriasG, totalKcal).toString() + "%",
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                fontFamily: 'genostff',
                color: const Color(0xffffffff)),
            badgePositionPercentageOffset: .98,
          );

        default:
          throw 'Oh no';
      }
    });
  }

  cardTercero() {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 15.0, left: 0, right: 10),
              child: const Text("Distribucion de Comidas",style: TextStyle(fontFamily: 'genostff',fontSize: 18))),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for(int i=0;i<3;i++)
                cardTerceroItem(getMacrosItem(peso, altura, edad, actiFisica, sexo)[i],i),
              ],
            ),
          ),
        ],
      ),
    );
  }

  cardTerceroItem(MacrosItemC macrosItem,i) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 0.0, left: 15, right: 10),
            child: Text(
              macrosItem.tituloG.toString(),
              style: TextStyle(color: coloresItem(i),fontFamily: 'genostff',fontSize: 16,fontWeight: FontWeight.bold),
            )),
        Container(
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
            child: Text(
              macrosItem.gramos.toString() + " g",
              style: const TextStyle(color: Colors.black,fontFamily: 'genostff',fontSize: 18,fontWeight: FontWeight.bold),
            ))
      ],
    );
  }

  cardCuarta() {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          for (int i = 0; i < 3; i++) 
            cardCuartoItem(getMacrosItem(peso, altura, edad, actiFisica, sexo)[i],i),
        ],
      ),
    );
  }
  condicionIndice(int i){
    if(i==0){
      return indiceMasaCorporal.toString();
    }
    if(i==1){
      return edadMetabolica.toString();
    }
    if(i==2){
      return tasaMetabolicaBsal.toString();
    }
  }
  cardCuartoItem(MacrosItemC macrosItem,int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: const Icon(Icons.accessibility_rounded,color: Colors.blueAccent,),
        ),
        Text(nombreCardCuarto[i],style: const TextStyle(fontFamily: 'genostff',fontSize: 18)),
        Text(
          condicionIndice(i),
          style: const TextStyle(color: Colors.black,fontFamily: 'genostff',fontSize: 18,fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}


class MyAlert extends StatelessWidget {
  const MyAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Show Dialog'),
    );
  }
}