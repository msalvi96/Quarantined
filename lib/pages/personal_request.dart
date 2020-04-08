import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quarantined/pages/contact_screen.dart';
import 'package:quarantined/utils/data.dart';
import 'package:quarantined/widgets/counter.dart';

List<String> groceryEssentials = [
    "Brown Rice",
    "White Rice",
    "All Purpose Flour",
    "Pasta",
    "Cooking Oil",
    "Juices",
    "Protein Bars",
    "Nutella",
    "Peanut Butter",
  ];

class PersonalRequest extends StatefulWidget {
  PersonalRequest({Key key}) : super(key: key);

  @override
  _PersonalRequestState createState() => _PersonalRequestState();
}

class _PersonalRequestState extends State<PersonalRequest> {
  
  List<bool> isSelected = [true, false];
  List<String> toggleList = ["grocery", "essentials"];
  bool isLoading = false;
  bool isGrocery = true;
  Geolocator geolocator = Geolocator();

  final _essentialsKey = GlobalKey<FormState>();
  int toiletPaper;
  int masks;
  int handSanitizers;
  String medicines;
  String description;

  List<dynamic> myList = [];
  List<dynamic> yourList = [];

  @override
  void initState() { 
    super.initState();
    toiletPaper = 0;
    masks = 0;
    handSanitizers = 0;
    medicines = '';
    description = '';
    myList = dataService.getEssentials();
    yourList = [];
  }

  addToCart(String item) {
    if (yourList.length < 5) {
      setState(() {
        yourList.add(item);
        myList.remove(item);
      });
      print('list length ${yourList.length}');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              child: Text("You cannot request for more than 5 items"),
            ),
          );
        }
      );
    }
  }
  
  removeFromCart(String item) {
    setState(() {
      myList.add(item);
      yourList.remove(item);
    });
  }


  buildGrocery() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          height: MediaQuery.of(context).size.height * 0.15,
          child: yourList.length == 0 ? Card(
            child: Container(
              child: Center(child: Text("No items added"),),
            ),
          ) : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: yourList.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Card(
                  color: Colors.blue,
                  child: Container(
                    child: Center(child: Text(yourList[index]),),
                  ),
                ),
              );
            }
          ),
        ),
        ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
//          mainAxisSize: MainAxisSize.max,
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
              itemCount: myList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    title: Text(myList[index]),
                    onTap: () => addToCart(myList[index]),
                  ),
                );
              }
            ),
          ],
        ),
      ],
    );
  }

  buildEssentialsForm() {
    return Container(
      child: Form(
        key: _essentialsKey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Text(
                  'Sanitary Masks: $masks',
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
              Text('Toilet Paper', style: TextStyle(fontSize: 15.0),),
              SizedBox(height: 5.0,),
              Slider(
                value: toiletPaper.toDouble(),
                min: 0.0,
                max: 5.0,
                divisions: 5,
                label: "$toiletPaper",
                onChanged: (double value) {
                  setState(() {
                    toiletPaper = value.toInt();
                  });
                },
                activeColor: Colors.red,
                inactiveColor: Colors.red,
              ),
              SizedBox(height: 5.0,),
              Text('Medicine Description', style: TextStyle(fontSize: 15.0),),
              SizedBox(height: 5.0,),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Briefly describe your request.',
                    helperText: 'Use this section to explain your request',
                    labelText: 'Description'
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Briefly describe your request.',
                  helperText: 'Use this section to explain your request',
                  labelText: 'Description'
                ),
                autovalidate: true,
                maxLines: 3,
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

  saveRequest() {
    Map<String, dynamic> request;
    if (isGrocery == true && yourList.length != 0) {
      request = {
        'type': 'grocery',
        'cart': yourList,
      };
      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen(request: request,)));
    }

    if (isGrocery == false && _essentialsKey.currentState.validate()) {
      _essentialsKey.currentState.save();
      request = {
        'type': 'essentials',
        'description': description,
        'medicines': medicines,
        'masks': masks,
        'toiletPaper': toiletPaper,
        'handSanitizers': handSanitizers,
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
          isGrocery ? buildGrocery() : buildEssentialsForm(),
        ],
      ),
    );
  }
}