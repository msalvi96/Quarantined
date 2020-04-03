import 'package:cloud_firestore/cloud_firestore.dart';

class Grocery {
  final String type = 'grocery';
  final String bread;
  final String condiments;
  final String dairy;
  final String essentials;
  final String meat;
  final String salads;
  final String veggies;
  final DocumentReference userId;
  final double latitude;
  final double longitude;


  Grocery({
    this.bread,
    this.condiments,
    this.dairy,
    this.essentials,
    this.meat,
    this.salads,
    this.veggies,
    this.longitude,
    this.latitude,
    this.userId,
  });

  //deserialization - take a document snapshot and create an instance of user class
  factory Grocery.fromDocument(DocumentSnapshot doc) {
    return Grocery(
      bread: doc['bread'],
      condiments: doc['condiments'],
      dairy: doc['dairy'],
      essentials: doc['essentials'],
      meat: doc['meat'],
      salads: doc['salads'],
      veggies: doc['veggies'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      userId: doc['userId'],
    );
  }
}