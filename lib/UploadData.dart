import 'package:firebase_database/firebase_database.dart';

class UploadData {
  var name;
  var lat;
  var lon;
  var img;
  var desc;

  final dataRef = FirebaseDatabase.instance.reference();

  UploadData(var name, var lat, var lon, var img, var desc) {
    this.img = img;
    this.name = name;
    this.lat = lat;
    this.lon = lon;
    this.desc = desc;
  }

  void sendData() {
    dataRef.child('Scenic Spots').push().set({
      'name': name,
      'image': img,
      'lat': lat,
      'lon': lon,
      'desc': desc
    }).asStream();
  }
}
