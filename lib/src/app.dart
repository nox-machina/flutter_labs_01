import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/image_model.dart';
import 'widgets/image_list.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  List<ImageModel> images = [];

  void getImage() async {
    counter++;
    final res =
        await http.get('http://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(res.body));
    setState(() {
      images.add(imageModel);
    });
  }

  void removeImage() async {
    if (counter > 0) {
      counter--;
      setState(() {
        images.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(Icons.add_rounded),
              onPressed: getImage,
            ),
            FloatingActionButton(
                child: Icon(Icons.remove), onPressed: removeImage),
          ],
        ),
        appBar: AppBar(
          title: Text('Labs_01'),
        ),
      ),
    );
  }
}
