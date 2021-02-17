import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;
  ImageList(this.images);

  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, int index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                child: Image(
                  image: NetworkImage(images[index].url),
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    return Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"));
                  },
                ),
              ),
              Text('${images[index].name}'),
            ],
          );
        });
  }
}
