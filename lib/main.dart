import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    title: 'IO',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read/Write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; //home/dir/....
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return new File('$path/data.txt'); //home/dir/data.txt
  }

  //Write and Read from our file
  Future<File> writeData(String message) async {
    final file = await _localFile;

    //write to file
    return file.writeAsString('$message');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;
      //Read
      String data = await file.readAsString();
      return data;
    } catch (e) {
      return "Nothing saved yet";
    }
  }
}
