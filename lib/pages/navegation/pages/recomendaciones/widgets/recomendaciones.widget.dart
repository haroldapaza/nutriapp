
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutriapp/pages/navegation/pages/recomendaciones/data/recomendacion.data.dart';
import 'package:nutriapp/pages/navegation/pages/recomendaciones/models/recomenImg.model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecomendacionesImg extends StatefulWidget {
  const RecomendacionesImg({Key? key}) : super(key: key);


  @override
  _RecomendacionesImgState createState() => _RecomendacionesImgState();
}

class _RecomendacionesImgState extends State<RecomendacionesImg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          FutureBuilder<List<RecomendacionImgC>>(
            future: fetchRecomendacionImg(http.Client()),
            // // initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return Recomendaciones(recomendacioni: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          
          
        ],
      )
    );
  }
}

class Recomendaciones extends StatefulWidget {
  const Recomendaciones({Key? key,required this.recomendacioni}) : super(key: key);

  final List<RecomendacionImgC> recomendacioni;
  @override
  _RecomendacionesState createState() => _RecomendacionesState();
}

class _RecomendacionesState extends State<Recomendaciones> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int h=0;
  @override
  void initState() {
    h=widget.recomendacioni.length;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        h,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey.shade300,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Container(
                color: Colors.white,
                height: 260,
                child: Center(
                    child:  ListView(
                      children: [
                        Container(
                          height: 170.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(widget.recomendacioni[index].url)),
                            borderRadius: const BorderRadius.only(topRight: Radius.elliptical(14, 13),topLeft: Radius.elliptical(14, 13),bottomLeft: Radius.elliptical(14, 13),bottomRight: Radius.elliptical(14, 13)),
                            color: Colors.redAccent,
                          ),
                        ),
                        
                        
                        Card(
                          margin: const EdgeInsets.only(top: 35.0,left: 2,right: 2,bottom: 10), 
                          elevation: 15,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          child:Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16, bottom: 16,left: 20,right: 14),
                                child: Text(
                                  widget.recomendacioni[index].recomendacion,
                                  style: const TextStyle(color: Colors.black,fontSize: 18,fontFamily: 'genostff',fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                ),
              ),
            ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              SizedBox(
                height: 430,
                
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (_, index) {
                    
                    return pages[index % pages.length];
                  },
                ),
              ),
              
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 32,
                    height: 12,
                    color: Colors.amber,
                    rotationAngle: 180,
                    verticalOffset: -10,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  dotDecoration: DotDecoration(
                    width: 24,
                    height: 12,
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                    verticalOffset: 0,
                  ),
                  spacing: 6.0,
                  inActiveColorOverride: (i) =>color(i),
                  
                ),
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
  color(i){
    return colors[i];
  }
}

const colors = [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
