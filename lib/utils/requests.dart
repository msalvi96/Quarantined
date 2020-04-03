import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quarantined/models/essentials.dart';
import 'package:quarantined/models/grocery.dart';
import 'package:rxdart/rxdart.dart';

class RequestService {
  var _db = Firestore.instance.collection('requests').snapshots();
  Observable<List<dynamic>> allRequests;
  PublishSubject loading = PublishSubject();

  RequestService() {
    allRequests = Observable(getRequestFromFirestore());
  }
  List<dynamic> requests = [
    {
      'type': 'grocery',
      'veggies': 'potatoes',
      'bread': 'burger buns',
      'essentials': 'flour',
      'meat': 'chicken',
      'condiments': 'pepper',
      'dairy': 'milk',
      'salads': 'spinach',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 37.4219983,
      'longitude': -122.084,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'grocery',
      'veggies': 'beans',
      'bread': 'brown bread',
      'essentials': 'oil',
      'meat': 'pork',
      'condiments': 'salt',
      'dairy': 'cheese',
      'salads': 'spinach',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 39.4219983,
      'longitude': -121.084,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'grocery',
      'veggies': 'mushrooms',
      'bread': 'white bread',
      'essentials': 'juices',
      'meat': 'red meat',
      'condiments': 'pepper',
      'dairy': 'cheese',
      'salads': 'spring mix',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 35.4219983,
      'longitude': -129.084,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'grocery',
      'veggies': 'Tomatoes',
      'bread': 'bagel',
      'essentials': 'flour',
      'meat': 'sausages',
      'condiments': 'salt',
      'dairy': 'ice cream',
      'salads': 'spring mix',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 37.4219983,
      'longitude': -122.084,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'essentials',
      'toiletPaper': 2,
      'masks': 3,
      'handSanitizers': 1,
      'medicines': 'This is a test medicine description',
      'description': 'This is a general test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 30.4219983,
      'longitude': -120.084,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'essentials',
      'toiletPaper': 2,
      'masks': 1,
      'handSanitizers': 3,
      'medicines': 'This is a test medicine description',
      'description': 'This is a general test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 35.5319983,
      'longitude': -121.184,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'essentials',
      'toiletPaper': 2,
      'masks': 3,
      'handSanitizers': 1,
      'medicines': 'This is a test medicine description',
      'description': 'This is a general test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 39.4219983,
      'longitude': -121.084,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'general',
      'title': 'General Request 1',
      'subtitle': 'This is a test general request',
      'description': 'This is a general test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 25.5219983,
      'longitude': -115.574,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'general',
      'title': 'General Request 2',
      'subtitle': 'This is a test general request',
      'description': 'This is a general test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 35.5219983,
      'longitude': -110.574,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'general',
      'title': 'General Request 3',
      'subtitle': 'This is a test general request',
      'description': 'This is a general test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 45.5219983,
      'longitude': -110.574,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'Organization',
      'title': 'Org Request 1',
      'subtitle': 'This is a test org request',
      'masks': 350,
      'volunteers': 100,
      'handSanitizers': 20,
      'medicines': 'This is a test medicine description',
      'description': 'This is a org test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 37.8219983,
      'longitude': -116.574,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'Organization',
      'title': 'Org Request 2',
      'subtitle': 'This is a test org request',
      'masks': 115,
      'volunteers': 50,
      'handSanitizers': 20,
      'medicines': 'This is a test medicine description',
      'description': 'This is a org test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 33.4219983,
      'longitude': -117.574,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
    {
      'type': 'Organization',
      'title': 'Org Request 3',
      'subtitle': 'This is a test org request',
      'masks': 150,
      'volunteers': 200,
      'handSanitizers': 50,
      'medicines': 'This is a test medicine description',
      'description': 'This is a org test description',
      'userId' : 'PwUq6IVVMhae2mmGLiH9e6sea1K2',
      'userDisplayName': 'Mrunal Salvi',
      'userAddress': '19 Lincoln Street',
      'latitude': 34.9219983,
      'longitude': -119.574,
      'photoURL': 'https://lh3.googleusercontent.com/a-/AOh14GjHqBZZ2FOhS400wLjK5o8MGgdy2nAI6FdSwrDUyw=s96-c'
    },
  ];

  List<dynamic> getRequests() {
    return requests;
  }
  // getRequestsFromFirestore() async {
  //   // List<dynamic> newOne = List<dynamic>();
  //   // await _db.getDocuments().then((snap) {
  //   //   snap.documents.map((doc) {
  //   //     newOne.add(doc.data);
  //   //   });
  //   // });
  //   // return newOne;
  // }

  Stream<List<dynamic>> getRequestFromFirestore() {
    return _db.map((qshot) => qshot.documents.map((doc) {
      if (doc.data['type'] == 'grocery') {
        return Grocery.fromDocument(doc);
      } else if (doc.data['type'] == 'essentials') {
        return Essentials.fromDocument(doc);
      }
    }).toList());
  }
}

final RequestService requestService = RequestService();