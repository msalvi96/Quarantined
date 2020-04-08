import 'package:flutter/material.dart';
import 'package:quarantined/pages/contact_screen.dart';
import 'package:quarantined/widgets/counter.dart';

class OrgRequest extends StatefulWidget {
  OrgRequest({Key key}) : super(key: key);

  @override
  _OrgRequestState createState() => _OrgRequestState();
}

class _OrgRequestState extends State<OrgRequest> {
  final _orgKey = GlobalKey<FormState>();
  int masks;
  int volunteers;
  int handSanitizers;
  String description;
  String medicines;

  @override
  void initState() { 
    super.initState();
    masks = 0;
    handSanitizers = 0;
    volunteers = 0;
    description = '';
    medicines = '';
  }

  saveRequest() {
    Map<String, dynamic> request;
    if (_orgKey.currentState.validate()) {
      _orgKey.currentState.save();
      request = {
        'type': 'organization',
        'masks': masks,
        'handSanitizers': handSanitizers,
        'volunteers': volunteers,
        'description': description,
        'medicines': medicines,
      };
      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen(request: request)));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: saveRequest,
        label: Text("Save"),
        elevation: 20.0,
        icon: Icon(Icons.save),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Container(
            child: Form(
              key: _orgKey,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text('Surgical Masks: $masks',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 5.0,),
                    Slider(
                      value: masks.toDouble(),
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$masks",
                      onChanged: (double value) {
                        setState(() {
                          masks = value.toInt();
                        });
                      },
                      activeColor: Colors.red,
                      inactiveColor: Colors.red,
                    ),
                    SizedBox(height: 5.0,),
                    Text('Hand Sanitizers: $handSanitizers', style: TextStyle(fontSize: 15.0),),
                    SizedBox(height: 5.0,),
                    Slider(
                      value: handSanitizers.toDouble(),
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$handSanitizers",
                      onChanged: (double value) {
                        setState(() {
                          handSanitizers = value.toInt();
                        });
                      },
                      activeColor: Colors.red,
                      inactiveColor: Colors.red,
                    ),
                    SizedBox(height: 5.0,),
                    Text('Volunteers: $volunteers', style: TextStyle(fontSize: 15.0),),
                    SizedBox(height: 5.0,),
                    Slider(
                      value: handSanitizers.toDouble(),
                      min: 0.0,
                      max: 5.0,
                      divisions: 5,
                      label: "$handSanitizers",
                      onChanged: (double value) {
                        setState(() {
                          handSanitizers = value.toInt();
                        });
                      },
                      activeColor: Colors.red,
                      inactiveColor: Colors.red,
                    ),
                    SizedBox(height: 5.0,),
                    Text('Medicine Description', style: TextStyle(fontSize: 15.0),),
                    SizedBox(height: 5.0,),
                    TextFormField(
                      maxLines: 3,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Briefly describe your medicine request.',
                            helperText: 'Use this section to explain your request',
                            labelText: 'Medicines'
                        ),
                      autovalidate: true,
                      onSaved: (value) {
                        setState(() {
                          medicines = value;
                        });
                      },
                      validator: (value) {
                        if (value.length > 150) {
                          return 'Describe your medical requirements in less than 150 charachters';
                        }
                      }
                    ),
                    SizedBox(height: 5.0,),
                    Text('General Description', style: TextStyle(fontSize: 15.0),),
                    SizedBox(height: 5.0,),
                    TextFormField(
                      maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Briefly describe your request.',
                            helperText: 'Use this section to explain your request',
                            labelText: 'Description'
                        ),
                      autovalidate: true,
                      onSaved: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      validator: (value) {
                        if (value.length > 250) {
                          return 'Description should be less than 250 charachters';
                        }
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),      
    );
  }
}