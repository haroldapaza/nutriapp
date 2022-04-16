import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutriapp/data/datosglobal.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:nutriapp/pages/publicidad/data/publi.data.dart';
import 'package:nutriapp/pages/publicidad/models/publi.model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyAlertD extends StatefulWidget {
  const MyAlertD({Key? key}) : super(key: key);

  @override
  State<MyAlertD> createState() => _MyAlertDState();
}

class _MyAlertDState extends State<MyAlertD> {
  String urlImg="";

  String mensaje="";

   bool downloading = true;

  String downloadingStr = "No data";

  String savePath = "";
  
  SharedPreferences? sharedPreferences;
  DateTime now= DateTime.now();
  @override
  Widget build(BuildContext context) {
    
     Future.delayed(const Duration(milliseconds: 5000), () => showAlert(context));
    return WillPopScope(
      onWillPop: () async => false,
      child: const Text("")
      );
  }

  void showAlert(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: variableGlobal,
        builder: (context) => WillPopScope(
          onWillPop: () async => variableGlobal,
          child: AlertDialog(
                title: const Text("Compartir "),
                content:FutureBuilder<List<PublicidadC>>(
              future: fetchPublicidadImg(http.Client()),
              // // initialData: [],
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ocurrio un Error!'),
                  );
                } else if (snapshot.hasData) {
                  if(snapshot.data!.isEmpty){
                    return const Text("Error al cargar datos");
                  }else{
                    urlImg=snapshot.data![0].url;
                    mensaje=snapshot.data![0].recomendacion;
                    return  Image.network(urlImg);
                    
                  }
                } else {
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      child: CircularProgressIndicator()),
                  );
                }
              },
            ),
                  
                actions: <Widget>[
                  TextButton(
                    child: const Icon(Icons.share),
                    onPressed: () async{
                      if(urlImg!=""){
                        final url=Uri.parse(urlImg);
                        final response =await http.get(url);
                        final bytes =response.bodyBytes;
                        final temp =await getTemporaryDirectory();
                        final path='${temp.path}/imagen.png';

                        File(path).writeAsBytesSync(bytes);
                        await Share.shareFiles([path],text:mensaje);
                        setState(() {
                          variableGlobal=true;
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  
                ],
              ),
        ) ,

            
            );
  }

  
  // void _shareText() async {
  //   try {
  //     WcFlutterShare.share(
  //         sharePopupTitle: 'Share',
  //         subject: 'This is subject',
  //         text: 'This is text',
  //         mimeType: 'text/plain');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void _shareImage() async {
  //   try {
  //     final ByteData bytes = await rootBundle.load(savePath);
  //     await WcFlutterShare.share(
  //         sharePopupTitle: 'share',
  //         fileName: 'share.png',
  //         mimeType: 'image/png',
  //         bytesOfFile: bytes.buffer.asUint8List());
  //   } catch (e) {
  //     print('error: $e');
  //   }
  // }
}