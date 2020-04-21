import 'package:cloud_firestore/cloud_firestore.dart';

class Essentials {
  final String type = 'essentials';
  final String description;
  final String medicines;
  final int masks;
  final int toiletPaper;
  final int handSanitizers;
  final double latitude;
  final double longitude;
  final int datePublished;
  final int expiryDate;
  final Map<dynamic, dynamic> contactInfo;

  Essentials({
    this.description,
    this.medicines,
    this.masks,
    this.toiletPaper,
    this.handSanitizers,
    this.longitude,
    this.latitude,
    this.datePublished,
    this.expiryDate,
    this.contactInfo,
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
      datePublished: doc['datePublished'],
      expiryDate: doc['expiryDate'],
      contactInfo: doc['contactInfo'],
    );
  }
}