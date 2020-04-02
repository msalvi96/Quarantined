import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quarantined/utils/data.dart';
import 'package:quarantined/widgets/counter.dart';

class PersonalRequest extends StatefulWidget {
  PersonalRequest({Key key}) : super(key: key);

  @override
  _PersonalRequestState createState() => _PersonalRequestState();
}

class _PersonalRequestState extends State<PersonalRequest> {
  
  List<bool> isSelected = [true, false];
  List<String> toggleList = ["grocery", "essentials"];
  
  bool isGrocery = true;

  String veggies;
  String bread;
  String essentials;
  String meat;
  String salads;
  String condiments;
  String dairy;
  final _veggiesKey = GlobalKey<FormState>();
  final _breadKey = GlobalKey<FormState>();
  final _groceryEssentialsKey = GlobalKey<FormState>();
  final _meatKey = GlobalKey<FormState>();
  final _saladsKey = GlobalKey<FormState>();
  final _dairyKey = GlobalKey<FormState>();
  final _condimentsKey = GlobalKey<FormState>();

  final _essentialsKey = GlobalKey<FormState>();
  int toiletPaper;
  int masks;
  int handSanitizers;
  String medicines;
  String description;

  @override
  void initState() { 
    super.initState();
    veggies = '';
    bread = '';
    essentials = '';
    meat = '';
    salads = '';
    condiments = '';
    dairy = '';
  }

  buildGroceryForm() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _groceryEssentialsKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: DropDownFormField(
                    titleText: 'Grocery Essentials',
                    hintText: 'Please choose one or none',
                    value: essentials,
                    onSaved: (value) {
                      setState(() {
                        essentials = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        essentials = value;
                      });
                    },
                    dataSource: dataService.getEssentials(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _veggiesKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: DropDownFormField(
                    titleText: 'Veggies',
                    hintText: 'Please choose one or none',
                    value: veggies,
                    onSaved: (value) {
                      setState(() {
                        veggies = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        veggies = value;
                      });
                    },
                    dataSource: dataService.getVeggies(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _meatKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: DropDownFormField(
                    titleText: 'Meat',
                    hintText: 'Please choose one or none',
                    value: meat,
                    onSaved: (value) {
                      setState(() {
                        meat = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        meat = value;
                      });
                    },
                    dataSource: dataService.getMeat(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _dairyKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Dairy',
                    hintText: 'Please choose one or none',
                    value: dairy,
                    onSaved: (value) {
                      setState(() {
                        dairy = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        dairy = value;
                      });
                    },
                    dataSource: dataService.getDairy(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _breadKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Bread',
                    hintText: 'Please choose one or none',
                    value: bread,
                    onSaved: (value) {
                      setState(() {
                        bread = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        bread = value;
                      });
                    },
                    dataSource: dataService.getBreads(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _saladsKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Salads',
                    hintText: 'Please choose one or none',
                    value: salads,
                    onSaved: (value) {
                      setState(() {
                        salads = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        salads = value;
                      });
                    },
                    dataSource: dataService.getSalads(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _condimentsKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Condiments',
                    hintText: 'Please choose one or none',
                    value: condiments,
                    onSaved: (value) {
                      setState(() {
                        condiments = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        condiments = value;
                      });
                    },
                    dataSource: dataService.getCondiments(),
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


  buildEssentialsForm() {
    return Center(
      child: Form(
        key: _essentialsKey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text('Sanitary Masks'),
              CounterFormField(
                onSaved: (value) {
                  setState(() {
                    masks = value;
                  });
                },
                autovalidate: true,
                validator: (value) {
                  if (value < 0) {
                    return 'Negative values not supported';
                  } else if (value > 2) {
                    return 'Requests over 4 are not accepted';
                  }
                },
              ),
              Text('Hand Sanitizers'),
              CounterFormField(
                autovalidate: true,
                onSaved: (value) {
                  setState(() {
                    handSanitizers = value;
                  });
                },
                validator: (value) {
                  if (value < 0) {
                    return 'Negative values not supported';
                  } else if (value > 4) {
                    return 'Requests over 4 are not accepted';
                  }
                },
              ),
              Text('Toilet Paper'),
              CounterFormField(
                autovalidate: true,
                onSaved: (value) {
                  setState(() {
                    toiletPaper = value;
                  });
                },
                validator: (value) {
                  if (value < 0) {
                    return 'Negative values not supported';
                  } else if (value > 4) {
                    return 'Requests over 4 are not accepted';
                  }
                },
              ),
              Text('Medicine Description'),
              TextFormField(
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
              Text('General Description'),
              TextFormField(
                autovalidate: true,
                onSaved: (value) {
                  setState(() {
                    description = value;
                  });
                },
                validator: (value) {
                  if (value.length > 150) {
                    return 'Description should be less than 150 charachters';
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Save"),
        elevation: 20.0,
        icon: Icon(Icons.save),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: ToggleButtons(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Grocery",
                      style: GoogleFonts.fredokaOne(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Essentials",
                      style: GoogleFonts.fredokaOne(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ],
                isSelected: isSelected,
                selectedColor: Colors.black,
                fillColor: Theme.of(context).accentColor,
                onPressed: (int index) {
                  setState(() {
                    for (int indexBtn = 0; indexBtn < isSelected.length; indexBtn++) {
                      if (indexBtn == index) {
                        isSelected[indexBtn] = true;
                      } else {
                        isSelected[indexBtn] = false;
                      }
                    }
                    if (toggleList[index] == 'grocery') {
                      isGrocery = true;
                    } else {
                      isGrocery = false;
                    }
                  });
                },
              ),
            ),
          ),
          isGrocery ? buildGroceryForm() : buildEssentialsForm(),
        ],
      ),
    );
  }
}