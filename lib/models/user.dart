import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String photoURL;
  final String displayName;
  final double latitude;
  final double longitude;
  final GeoPoint geoPoint;

  User({
    this.uid,
    this.email,
    this.photoURL,
    this.displayName,
    this.longitude,
    this.latitude,
    this.geoPoint,
  });

  //deserialization - take a document snapshot and create an instance of user class
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      uid: doc['uid'],
      email: doc['email'],
      photoURL: doc['photoURL'],
      displayName: doc['displayName'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      geoPoint: doc['geoPoint'],
    );
  }
}