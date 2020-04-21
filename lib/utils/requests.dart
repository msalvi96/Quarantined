import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quarantined/models/essentials.dart';
import 'package:quarantined/models/general.dart';
import 'package:quarantined/models/grocery.dart';
import 'package:quarantined/models/organization.dart';
import 'package:rxdart/rxdart.dart';

class RequestService {
  var _instance = Firestore.instance.collection('requests');
  var _db = Firestore.instance.collection('requests').snapshots();
  Observable<List<dynamic>> allRequests;
  PublishSubject loading = PublishSubject();

  RequestService() {
    allRequests = Observable(getRequestFromFirestore());
  }

  Stream<List<dynamic>> getRequestFromFirestore() {
    return _db.map((qshot) => qshot.documents.map((doc) {
      if (doc.data['type'] == 'grocery') {
        return Grocery.fromDocument(doc);
      } else if (doc.data['type'] == 'essentials') {
        return Essentials.fromDocument(doc);
      } else if (doc.data['type'] == 'general') {
        return General.fromDocument(doc);
      } else if (doc.data['type'] == 'organization') {
        return Organization.fromDocument(doc);
      }
    }).toList());
  }

  uploadGroceryForm(Grocery request) async {
    return await _instance.document().setData({
      'type': 'grocery',
      'cart': request.cart,
      'contactInfo': request.contactInfo,
      'latitude': request.latitude,
      'longitude': request.longitude,
      'datePublished': request.datePublished,
      'expiryDate': request.expiryDate,
    });
  }

  uploadEssentialsForm(Essentials request) async {
    return await _instance.document().setData({
      'type': 'essentials',
      'latitude': request.latitude,
      'longitude': request.longitude,
      'contactInfo': request.contactInfo,
      'medicines': request.medicines,
      'description': request.description,
      'datePublished': request.datePublished,
      'expiryDate': request.expiryDate,
      'handSanitizers': request.handSanitizers,
      'toiletPaper': request.toiletPaper,
      'masks': request.masks,
    });
  }

  uploadGeneralForm(General request) async {
    return await _instance.document().setData({
      'type': 'general',
      'latitude': request.latitude,
      'longitude': request.longitude,
      'contactInfo': request.contactInfo,
      'title': request.title,
      'subject': request.subject,
      'priority': request.priority,
      'description': request.description,
      'datePublished': request.datePublished,
      'expiryDate': request.expiryDate,
    });
  }

  uploadOrganizationForm(Organization request) async {
    return await _instance.document().setData({
      'type': 'organization',
      'latitude': request.latitude,
      'longitude': request.longitude,
      'contactInfo': request.contactInfo,
      'description': request.description,
      'medicines': request.medicines,
      'masks': request.masks,
      'volunteers': request.volunteers,
      'handSanitizers': request.handSanitizers,
      'datePublished': request.datePublished,
      'expiryDate': request.expiryDate,
    });
  }
}

final RequestService requestService = RequestService();