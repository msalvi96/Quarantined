import 'package:cloud_firestore/cloud_firestore.dart';

class General {
  final String type = 'general';
  final String description;
  final String title;
  final String subject;
  final String priority;
  final double latitude;
  final double longitude;
  final int datePublished;
  final int expiryDate;
  final Map<dynamic, dynamic> contactInfo;

  General({
    this.description,
    this.title,
    this.subject,
    this.priority,
    this.latitude,
    this.longitude,
    this.datePublished,
    this.expiryDate,
    this.contactInfo
  });

  factory General.fromDocument(DocumentSnapshot doc) {
    return General(
      description: doc['description'],
      title: doc['title'],
      subject: doc['subject'],
      priority: doc['priority'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      datePublished: doc['datePublushed'],
      expiryDate: doc['expiryDate'],
      contactInfo: doc['contactInfo'],
    );
  }
}