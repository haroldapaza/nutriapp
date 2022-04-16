

import 'package:nutriapp/models/objetivo/objetivo.models.dart';

List getObjetivos() {
  List<ObjetivoI> objetivos = [];
  for (var item in infoObjetivo) {
    objetivos.add(ObjetivoI(
      url: item[0],
      titulo: item[1],
      texto: item[2]
    ));
  }
  // print(allFansToDraw.length);
  return objetivos;
}
List infoObjetivo = [
  [
    "assets/imagenes/1.png",
    "Perder Grasa",
    "Maximiza la perdida de grasa y conserva tu masa muscular",
  ],
  [
    "assets/imagenes/2.png",
    "Mantener Peso",
    "Conserva tu estado fisico y mantente saludable",
  ],
  [
    "assets/imagenes/3.png",
    "Ganar Músculo",
    "Incrementa tu masa muscular y vuelvete mas fuerte",
  ]
];
