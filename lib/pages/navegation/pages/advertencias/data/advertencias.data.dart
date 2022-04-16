import 'package:nutriapp/pages/navegation/pages/advertencias/models/advertencia.model.dart';

List<AdvertenciaC> getDatoAdvertencias(){
  List<AdvertenciaC> newAdvertencia=[];
    for(int i=0;i<8;i++){
      newAdvertencia.add(AdvertenciaC(titulo: infoAdvertencia[i][0], text: infoAdvertencia[i][1], advertencias: infoAdvertencia[i][2]));
    }
  return newAdvertencia;
}
List infoAdvertencia = [
  [
    "DIABETES",
    "Es una enfermedad crónica que aparece cuando el páncreas no produce suficiente insulina (hormona que regula el azúcar en la sangre) o cuando el organismo no utiliza la que tiene de forma eficaz.",
    adver1,
  ],
  [
    "LA HIPERTRIGLICERIDEMIA",
    "Puede incrementar el riesgo de desarrollar enfermedades cardiovasculares, que constituyen la primera causa de muerte en todo el mundo según la Organización Mundial de la Salud (OMS), de ahí la importancia de mantener controlados los niveles de triglicéridos para evitar problemas de salud. ",
    adver2,
  ],
  [
    "HIPERTENSIÓN",
    "Se denomina hipertensión arterial a la presión que sufren las arterias cuando está por encima de los valores normales. Dichos valores son:",
    adver3,
  ],
  [
    "HIGADO GRASO",
    "La enfermedad del hígado graso es cada vez más común, afectando a cerca del 25% de las personas a nivel global. Está relacionado con la obesidad, la diabetes tipo 2 y otros trastornos que se caracterizan por la resistencia a la insulina. Además, si el hígado graso no se controla, puede convertirse en una enfermedad hepática más severa y en otros problemas de salud.",
    adver4,
  ],
  [
    "GASTRITIS",
    "La gastritis es la inflamación aguda o crónica de la mucosa que recubre las paredes del estómago. Puede estar producida por diversos agentes, como la ingesta de ciertos medicamentos o la infección por la bacteria Helicobacter pylori. Puede causar molestias importantes, pero en muchos casos es asintomática.",
    adver5,
  ],
  [
    "HELICOBARTER PYLORI",
    "El Helicobacter pylori (H. pylori) es un tipo de bacteria que causa infecciones en el estómago. Se encuentra, aproximadamente, en dos tercios de la población mundial. Es posible que se transmita por agua y alimentos contaminados, pero los investigadores no están seguros. Puede causar úlceras pépticas y cáncer de estómago.",
    adver6,
  ],
  [
    "COLON IRRITABLE",
    "El colon irritable, cuya denominación más exacta es «Síndrome del Intestino Irritable» (SII), es un cuadro crónico y recidivante, caracterizado por la existencia de dolor abdominal y/o cambios en el ritmo intestinal (diarrea o estreñimiento).\nSe puede acompañar o no de una sensación de distensión abdominal, sin que se demuestre una alteración en la morfología o en el metabolismo intestinales, ni causas infecciosas que lo justifiquen.",
    adver7,
  ],
  [
    "HIPOTIROIDISMO",
    "El hipotiroidismo significa que la glándula tiroides no es capaz de producir suficiente hormona tiroidea para mantener el cuerpo funcionando de manera normal. Las personas hipotiroideas tienen muy poca hormona tiroidea en la sangre. Las causas frecuentes son: enfermedad autoinmune, como es la Tiroiditis de Hashimoto, la eliminación quirúrgica de la tiroides y el tratamiento radiactivo.",
    adver8,
  ]
];

List<String> adver1=[
  "Brócoli",
  "Zanahorias", 
  "Vegetales de hojas verdes", 
  "Pimientos y tomates",
  "Feculentas (ricas en almidón): incluye papas, maíz y arvejas", 
  "Alimentos en base a azúcares",
  "Los postres",
  "Caramelos",
  "Mermeladas",
  "Saborizantes en polvo",
  "Jugos de frutas",
  "Jarabe de miel",
  "Las cremas como la mayonesa, ketchup, mostaza, entre otras", 
  "Grasas no saludables",
  "Las harinas refinadas",
  "Bebidas gaseosas",
  "Lácteos enteros",
  "De la misma forma, hay que evitar las frituras",
  "Los cafés altos en calorías",
];
List<String> adver2=[
  "Bollería industrial, snacks y aperitivos salados, refrescos azucarados y, en general, todos los productos con un elevado contenido de calorías vacías",
  "Bebidas alcohólicas (se deben eliminar por completo en casos de hipertrigliceridemia)",
  "Hidratos de carbono refinados. Sustitúyelos por alimentos elaborados con cereales integrales",
  "Grasas (mantequilla, nata, tocino, quesos grasos, embutidos, aceites de coco o de palma, lácteos enteros…)",
  "Azúcares (repostería y pastelería, almíbares, mermelada, chocolate, miel, frutas secas…)",
  "Alimentos precocinados. Por lo general tienen elevados contenidos de sal y azúcar, así como de grasas saturadas o trans. Si por falta de tiempo para cocinar recurres a la comida rápida, procura limitar su consumo y elegir fast food saludable",
];
List<String> adver3=[
  "Alimentos procesados",
  "Alimentos en conserva; frutas en conserva, atunes, mariscos, verduras",
  "Alimentos pre elaborados; sopas deshidratadas, cremas, gramos enteros, pollo, pescado, semillas, reducir la ingesta de carnes rojas, grasas y dulces",
  "Embutidos",
  "Alimentos de cóctel",
  "Queso maduro",
  "Mantequillas",
  "Aceitunas",
  "Pan y galletas con sal",
  "Mayonesa o kétchup",
  "Mariscos",
];
List<String> adver4=[
  "Alcohol. Se trata del gran enemigo del hígado. ...",
  "Azúcar. Una dieta rica en azúcar contribuye a que la grasa se deposite en el hígado y cause inflamación",
  "Sal. ...",
  "Carne roja. ...",
  "Embutidos. ...",
  "Lácteos con leche entera. ...",
  "Bollería industrial",

];
List<String> adver5=[
  "Lácteos:\nEvita los lácteos ricos en grasa como la nata, los quesos curados o la leche entera. Opta por la leche desnatada o semidesnatada, el queso fresco o los yogures desnatados. Si tu situación mejora puedes tomar moderadamente algún postre lácteo como las natillas o el flan.",
  "Verduras y hortalizas:\nCiertas personas pueden presentar una mala tolerancia personal a las verduras flatulentas (alcachofas, col, coliflor, brócoli, coles de Bruselas, pimiento, pepino, cebolla y ajos) o a los alimentos ácidos como el tomate. En ocasiones también puede generar molestias si se consumen crudos, si es así, cocínalos hervidos o en puré.",
  "Frutas:\n Evita las frutas poco maduras y los cítricos por su elevada acidez. Es recomendable que el consumo de frutas lo hagas en forma de fruta madura, al horno o en compota.",
  "Cereales, tubérculos y legumbres:\nEvita la bollería y pastelería como galletas con chocolate, croissants o bollos. El arroz y la patata suelen ser bien aceptados. Las legumbres por su parte se recomiendan en cocciones suaves y si sientan mal se deben pasar por el pasapurés para quitarles las “pieles” que, por su alto contenido en fibra, pueden crear molestias.",
  "Pescados, carnes y huevos:\nEvita las carnes grasas como la ternera o el buey y los embutidos. Puedes consumir carnes blancas como el pollo o el pavo, huevo y embutidos tipo jamón dulce, pechuga de pavo y, según la tolerancia, el pescado blanco y el jamón serrano"
  "Bebidas:\nEvita, como ya se ha dicho anteriormente, el té, las bebidas de cola, las bebidas con gas o el café, que aunque sea descafeinado aumenta la secreción gástrica. Puedes sustituir estas bebidas por infusiones suaves (hinojo, melisa, hierba luisa o romero) o, consumidos con moderación, zumos no cítricos. Evidentemente, el líquido de consumo preferente será el agua y también podemos tomar caldos suaves desgrasados.",
  "Otros:\nEvita las salsas grasas o a base de nata, los condimentos picantes, los cubos concentrados saborizantes o el chocolate. Todos ellos estimulan la secreción gástrica o dificultan la digestión.Se recomienda, que para cocinar, se consuma aceite de oliva o de semillas antes que mantequillas o margarinas."
];
List<String> adver6=[
  "El té y el café",
  "Los refrescos de cola y los refrescos en general porque todo lo que lleva gas perjudicará el aparato digestivo",
  "El alcohol",
  "El chocolate",
  "Embutidos y quesos muy curados. Tampoco conviene la carne roja.",
];
List<String> adver7=[
  "Alcohol",
  "Café",
  "Refrescos",
  "Chocolate",
  "Verduras crudas",
  "Verduras flatulentas como la col, coliflor, brócoli y las coles de Bruselas",
  "Cebolla",
  "Legumbres",
  "Lácteos",
  "Germen de trigo",
  "Alimentos grasos, especiados y picantes",
];
List<String> adver8=[
  "Cereales con gluten. El consumo de cereales con alto contenido de gluten puede dificultar la absorción de los medicamentos de remplazo de la hormona tiroidea…", 
  "Brócoli. ...",
  "Soja. ...",
  "Azúcar. ...",
  "Aceites vegetales. ...",
  "Alimentos ricos en yodo. ...",
  "Carnes embutidas.",
];