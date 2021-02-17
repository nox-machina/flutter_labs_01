import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  ImageList(this.images);

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, int index) {
          return buildCharacter(images[index]);
        });
  }
}

Widget buildCharacter(ImageModel image) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
    elevation: 10,
    child: Column(
      children: [
        Container(
          child: Image(
            image: NetworkImage(image.url),
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Image(
                  image: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"));
            },
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text('${image.name}'),
          ),
        ),
      ],
    ),
  );
}
