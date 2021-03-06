import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  var data = await readData();

  if (data != null) {
    String message = await readData();
    print(message);
  }
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
  var _enterDataField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read/Write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(13.4),
        child: Column(
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: _enterDataField,
                decoration: InputDecoration(labelText: 'Write Something'),
              ),
            ),
            ListTile(
                title: FlatButton(
              color: Colors.blueGrey,
              onPressed: () {
                if (_enterDataField.text.isNotEmpty) {
                  writeData(_enterDataField.text);
                }
              },
              child: Column(
                children: <Widget>[
                  Text('Save Data'),
                  Padding(padding: EdgeInsets.all(14.5)),
                  FutureBuilder(
                    future: readData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> data) {
                      if (data.hasData != null) {
                        return Text(data.data.toString(),
                            style: TextStyle(color: Colors.white));
                      } else {
                        return Text('No Data saved');
                      }
                    },
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
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
