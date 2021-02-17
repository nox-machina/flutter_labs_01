import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/image_model.dart';
import 'widgets/image_list.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  int limit = 1;
  int offset = 0;
  List<ImageModel> images = [];

  void getImage() async {
    counter++;
    offset++;
    var ts = DateTime.now().millisecondsSinceEpoch.toString();
    final pubkey = "f49e6d7f4057e2eff1a2586f3f7929d3";
    final pvtkey = env['PVTKEY'];
    var apikey =
        crypto.md5.convert(utf8.encode(ts + pvtkey + pubkey)).toString();
    print(apikey);
    final res = await http.get(
        'https://gateway.marvel.com:443/v1/public/characters?limit=$limit&offset=$offset&ts=$ts&apikey=$pubkey&hash=$apikey');
    var imageModel = ImageModel.fromJson(json.decode(res.body));
    print(res.statusCode);
    if (imageModel.url !=
        "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg") {
      if (images.length >= 0) {
        var contains = images.where((element) => element.id == imageModel.id);
        if (contains.isEmpty) {
          setState(() {
            images.insert(0, imageModel);
            print("ADDED ONE = $counter: $offset");
          });
        } else {
          getImage();
        }
      }
    } else {
      getImage();
    }
  }

  void removeImage() async {
    if (counter > 0 && offset > 0) {
      setState(() {
        //removes last added element from index 0
        images.removeAt(0);
      });
      //if elements have been skipped, calculate the difference by comparing the counter and number of elements in list and adjust both offset and counter
      if ((counter - images.length) >= 1) {
        var diff = counter - images.length;
        offset -= (diff);
        counter -= (diff);
        //otherwise decrement offset and counter by 1
      } else {
        offset--;
        counter--;
      }
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
          title: Center(child: Text('MARVEL DECK')),
        ),
      ),
    );
  }
}
