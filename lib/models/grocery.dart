import 'package:cloud_firestore/cloud_firestore.dart';

class Grocery {
  final String type = 'grocery';
  final double latitude;
  final double longitude;
  final List<dynamic> cart;
  final int datePublished;
  final int expiryDate;
  final Map<dynamic, dynamic> contactInfo; 

  Grocery({
    this.longitude,
    this.latitude,
    this.cart,
    this.datePublished,
    this.expiryDate,
    this.contactInfo,
  });

  //deserialization - take a document snapshot and create an instance of user class
  factory Grocery.fromDocument(DocumentSnapshot doc) {
    return Grocery(
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      cart: doc['cart'],
      datePublished: doc['datePublished'],
      expiryDate: doc['expiryDate'],
      contactInfo: doc['contactInfo'],
    );
  }
}