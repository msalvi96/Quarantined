import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  final String type = 'organization';
  final String description;
  final String medicines;
  final int masks;
  final int volunteers;
  final int handSanitizers;
  final double latitude;
  final double longitude;
  final int datePublished;
  final int expiryDate;
  final Map<dynamic, dynamic> contactInfo;

  Organization({
    this.description,
    this.medicines,
    this.masks,
    this.volunteers,
    this.handSanitizers,
    this.longitude,
    this.latitude,
    this.datePublished,
    this.expiryDate,
    this.contactInfo,
  });

  //deserialization - take a document snapshot and create an instance of user class
  factory Organization.fromDocument(DocumentSnapshot doc) {
    return Organization(
      description: doc['description'],
      medicines: doc['medicines'],
      masks: doc['masks'],
      volunteers: doc['volunteers'],
      handSanitizers: doc['handSanitizers'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      datePublished: doc['datePublished'],
      expiryDate: doc['expiryDate'],
      contactInfo: doc['contactInfo'],
    );
  }
}