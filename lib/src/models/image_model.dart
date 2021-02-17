class ImageModel {
  int id;
  String name;
  String url;

  // ImageModel(this.id, this.name);
  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    // print(parsedJson['data']['results'][0]['thumbnail']['path']);
    // if (parsedJson['data']['results'][0]['thumbnail']['path'] !=
    //     "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available") {
    id = parsedJson['data']['results'][0]['id'];
    name = parsedJson['data']['results'][0]['name'];
    url = parsedJson['data']['results'][0]['thumbnail']['path'] + ".jpg";
    // }
  }
}
