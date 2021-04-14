import 'package:firebase_database/firebase_database.dart';

class ReadData {
  final dataRef = FirebaseDatabase.instance.reference();

  void readData() {
    dataRef.once().then((DataSnapshot snapshot) {
      // print('Data: ${snapshot.value}');
    });
  }
}
