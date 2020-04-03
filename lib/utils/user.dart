import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:quarantined/models/user.dart';

class UserService {
  var _db = Firestore.instance.collection('users');
  // DocumentReference userRef = _db.collection('users')
  getUserById(profileId) async {
    return await _db.document(profileId).get();
  }

  updateUserProfile(profileId, latitude, longitude) async {
    await _db.document(profileId).updateData({
      "latitude": latitude,
      "longitude": longitude,
      "geoPoint": GeoPoint(latitude, longitude),
    });
    return await getUserById(profileId);
  }

  getUserByReference(DocumentReference userIdRef) async {
    return await userIdRef.get();
  }

}