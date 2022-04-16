import 'package:flutter/material.dart';

class MyStatelessWidget extends StatefulWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  State<MyStatelessWidget> createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<MyStatelessWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 180,
            child: Container(
              color: Colors.amber,
              child: const Center(
                child: Text('Above'),
              ),
            ),
          ),
          const Divider(
            height: 00,
            thickness: 0,
            indent: 0,
            endIndent: 1,
          ),
          Expanded(
            
            child: Container(
              color: Colors.blueAccent,

              child: ListView(
                
                children: [
                  for(var i=0;i<5;i++)
                  buttonSection()
                ],
              ),
            )
          ),
        ],
      ),
    );
  }

Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 0),
      margin: const EdgeInsets.only(top: 5.0),
      
      child: Column(
        children: [
          const Text("Desayuno"),
          ListView(
            
            children: [
                  for(var i=0;i<5;i++)
                    desayuno()
                ],
          )
        ],
        
      ),
    );
  }
  desayuno(){
    return Column(
      children: [
        SizedBox(
          child: Image.network("https://peru.info/Portals/0/Images/Productos/6/43-imagen-17292926112018.jpg"),
        ),
        const Text("Tostadas frances"),
        const Text("480 kcal")
      ],
    );
  }
}
