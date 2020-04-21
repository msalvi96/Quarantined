import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:quarantined/models/essentials.dart';
import 'package:quarantined/models/general.dart';
import 'package:quarantined/models/grocery.dart';
import 'package:quarantined/models/organization.dart';
import 'package:quarantined/utils/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactScreen extends StatefulWidget {
  Map<String, dynamic> request;
  ContactScreen({ this.request });

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final name = TextEditingController();
  String phoneNumber;
  String phoneIsoCode;
  final address = TextEditingController();
  final city = TextEditingController();
  bool nameValid = true;
  bool addressValid = true;
  DateTime _dateTime;

  @override
  void initState() { 
    super.initState();
    print(widget.request);
  }


  void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }

  buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Your Name",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: name,
          decoration: InputDecoration(
            hintText: "Name Input",
            errorText: nameValid ? null : "Name Inavlid",
          ),
        ),
      ],
    );
  }

  buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Address",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: address,
          decoration: InputDecoration(
            hintText: "Address",
            errorText: addressValid ? null : "Address Valid",
          ),
        ),
      ],
    );
  }
  
  buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Phone Number",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        InternationalPhoneInput(
          onPhoneNumberChange: onPhoneNumberChange,
          initialPhoneNumber: phoneNumber,
          initialSelection: phoneIsoCode,
          enabledCountries: ['+1', '+91'],
        ),
      ],
    );
  }

  getExpiryDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(_dateTime == null ? 'No expiry date picked' : '${_dateTime.month.toString()}, ${_dateTime.day.toString()} ${_dateTime.year.toString()}'),
        ),
        RaisedButton(
          child: Text("Pick an Expiry Date"),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2222),
            ).then((date) {
              setState(() {
                _dateTime = date;
              });
            });
          }
        )
      ],
    );
  }

  publishRequest() async {
    setState(() {
      name.text.trim().length < 2 || name.text.isEmpty ? nameValid = false : nameValid = true;
      address.text.trim().length < 10 || address.text.isEmpty ? addressValid = false : addressValid = true;
    });
    // print("$phoneIsoCode$phoneNumber");
    if (widget.request['type'] == 'grocery' && nameValid && addressValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double latitude = prefs.getDouble('latitude');
      double longitude = prefs.getDouble('longitude');
      Grocery request = new Grocery(
        latitude: latitude,
        longitude: longitude,
        cart: widget.request['cart'],
        datePublished: DateTime.now().millisecondsSinceEpoch,
        expiryDate: _dateTime.millisecondsSinceEpoch,
        contactInfo: {
          'name': name.text,
          'address': address.text,
          'phoneNumber': phoneNumber,
        },
      );
      await requestService.uploadGroceryForm(request);
      SnackBar snackBar = SnackBar(content: Text("Grocery Request Published"),);
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    if (widget.request['type'] == 'essentials' && nameValid && addressValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double latitude = prefs.getDouble('latitude');
      double longitude = prefs.getDouble('longitude');
      Essentials request = new Essentials(
        latitude: latitude,
        longitude: longitude,
        description: widget.request['description'],
        medicines: widget.request['medicines'],
        toiletPaper: widget.request['toiletPaper'],
        handSanitizers: widget.request['handSanitizers'],
        masks: widget.request['masks'],
        datePublished: DateTime.now().millisecondsSinceEpoch,
        expiryDate: _dateTime.millisecondsSinceEpoch,
        contactInfo: {
          'name': name.text,
          'address': address.text,
          'phoneNumber': phoneNumber,
        },
      );

      await requestService.uploadEssentialsForm(request);
      SnackBar snackBar = SnackBar(content: Text("Essentials Request Published"),);
      _scaffoldKey.currentState.showSnackBar(snackBar); 
    }

    if (widget.request['type'] == 'general' && nameValid && addressValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double latitude = prefs.getDouble('latitude');
      double longitude = prefs.getDouble('longitude');
      General request = new General(
        latitude: latitude,
        longitude: longitude,
        description: widget.request['description'],
        title: widget.request['title'],
        subject: widget.request['subject'],
        priority: widget.request['priority'],
        datePublished: DateTime.now().millisecondsSinceEpoch,
        expiryDate: _dateTime.millisecondsSinceEpoch,
        contactInfo: {
          'name': name.text,
          'address': address.text,
          'phoneNumber': phoneNumber,
        }
      );
      
      await requestService.uploadGeneralForm(request);
      SnackBar snackBar = SnackBar(content: Text("General Request Published"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    if (widget.request['type'] == 'organization' && nameValid && addressValid) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double latitude = prefs.getDouble('latitude');
      double longitude = prefs.getDouble('longitude');
      Organization request = new Organization(
        latitude: latitude,
        longitude: longitude,
        description: widget.request['description'],
        medicines: widget.request['medicines'],
        masks: widget.request['masks'],
        volunteers: widget.request['volunteers'],
        handSanitizers: widget.request['handSanitizers'],
        datePublished: DateTime.now().millisecondsSinceEpoch,
        expiryDate: _dateTime.millisecondsSinceEpoch,
        contactInfo: {
          'name': name.text,
          'address': address.text,
          'phoneNumber': phoneNumber,
        }
      );

      await requestService.uploadOrganizationForm(request);
      SnackBar snackBar = SnackBar(content: Text("Organization Request Published"));
      _scaffoldKey.currentState.showSnackBar(snackBar);      
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.request.toString());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text("Contact Info")
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      buildNameField(),
                      buildPhoneNumberField(),
                      buildAddressField(),
                      getExpiryDate(),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: publishRequest,
                  child: Text("Send Request"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}