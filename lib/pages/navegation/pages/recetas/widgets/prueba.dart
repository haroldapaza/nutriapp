import 'package:flutter/material.Dart';
import 'package:http/http.Dart' show get;
import 'Dart:io';
import 'package:path_provider/path_provider.Dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Test Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? imageData;
  bool dataLoaded = false;
  @override
  initState() {
    _downloadAndSavePhoto();
    super.initState();
  }

  _downloadAndSavePhoto() async {
    // Get file from internet
    var url = "https://www.muycomputer.com/wp-content/uploads/2021/02/android.jpg"; //%%%
    var response = await get(Uri.parse(url)); //%%%
    // documentDirectory is the unique device path to the area you'll be saving in
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images"; //%%%
    //You'll have to manually create subdirectories
    await Directory(firstPath).create(recursive: true); //%%%
    // Name the file, create the file, and save in byte form.
    var filePathAndName = documentDirectory.path + '/images/pic.jpg';
    File file2 = File(filePathAndName); //%%%
    file2.writeAsBytesSync(response.bodyBytes); //%%%
    setState(() {
      // When the data is available, display it
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    if (dataLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // imageData holds the path AND the name of the picture.
              Image.file(File(imageData!), width: 600.0, height: 290.0)
            ],
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator(
        backgroundColor: Colors.cyan,
        strokeWidth: 5,
      );
    }
  }
}