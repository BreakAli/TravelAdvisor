import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:travel_advisor/firebaseData.dart';
import 'firebaseData.dart';

class SavePage extends StatefulWidget {
  SavePage({this.app});
  final FirebaseApp app;

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  DatabaseReference databaseReference;

  @override
  void initState() {
    print("Inside init state");
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);

    databaseReference = database.reference().child('National Parks');
    print("end  init state");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Inside build");
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Saved National Parks"),
        backgroundColor: Colors.grey[850],
      ),
      backgroundColor: Colors.brown,
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: new FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return new Card(
                    color: Colors.brown[900],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    margin: EdgeInsets.all(7.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                snapshot.value['image'],
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 15)),
                            new Flexible(
                              child: new Text(
                                snapshot.value['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[200], fontSize: 22),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                            new IconButton(
                              onPressed: () {
                                databaseReference.child(snapshot.key).remove();
                              },
                              icon: const Icon(Icons.delete),
                              iconSize: 30,
                            ),
                            Padding(padding: EdgeInsets.all(5)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
