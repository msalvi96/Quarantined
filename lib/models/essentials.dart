import 'package:cloud_firestore/cloud_firestore.dart';

class Essentials {
  final String type = 'Essentials';
  final String description;
  final String medicines;
  final int masks;
  final int toiletPaper;
  final int handSanitizers;
  final DocumentReference userId;
  final double latitude;
  final double longitude;


  Essentials({
    this.description,
    this.medicines,
    this.masks,
    this.toiletPaper,
    this.handSanitizers,
    this.longitude,
    this.latitude,
    this.userId,
  });

  //deserialization - take a document snapshot and create an instance of user class
  factory Essentials.fromDocument(DocumentSnapshot doc) {
    return Essentials(
      description: doc['description'],
      medicines: doc['medicines'],
      masks: doc['masks'],
      toiletPaper: doc['toiletPaper'],
      handSanitizers: doc['handSanitizers'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      userId: doc['userId'],
    );
  }
}