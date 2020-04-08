import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:quarantined/pages/contact_screen.dart';

class GeneralRequest extends StatefulWidget {
  GeneralRequest({Key key}) : super(key: key);

  @override
  _GeneralRequestState createState() => _GeneralRequestState();
}

class _GeneralRequestState extends State<GeneralRequest> {
  final title = TextEditingController();
  final subject = TextEditingController();
  final description = TextEditingController();
  String priority;

  bool titleValid = true;
  bool subjectValid = true;
  bool descriptionValid = true;
  bool prioritySelected = false;


  @override
  void initState() { 
    super.initState();
  }

  saveRequest() {
    Map<String, dynamic> request;
    setState(() {
      title.text.trim().length < 3 || title.text.isEmpty ? titleValid = false : titleValid = true;
      subject.text.trim().length > 50 || subject.text.isEmpty ? subjectValid = false : subjectValid = true;
      description.text.trim().length > 150 || description.text.isEmpty ? descriptionValid = false : descriptionValid = true;
      priority == null ? prioritySelected = false : prioritySelected = true;
    });

    if (titleValid && subjectValid && descriptionValid && prioritySelected) {
      request = {
        'type': 'general',
        'title': title.text,
        'subject': subject.text,
        'description': description.text,
        'priority': priority,
      };
      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen(request: request,)));
    }
  }

  buildGeneralForm() {
    return Container(
      child: Form(

      ),
    );
  }

  buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Title",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: title,
          decoration: InputDecoration(
            hintText: "Title Input",
            errorText: titleValid ? null : "Title Inavlid",
          ),
        ),
      ],
    );
  }

  buildSubjectField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Subject",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: subject,
          decoration: InputDecoration(
            hintText: "Subject Input",
            errorText: subjectValid ? null : "Subject Inavlid",
          ),
        ),
      ],
    );
  }

  buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Description",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextField(
          controller: description,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: "Description Input",
            errorText: descriptionValid ? null : "Name Inavlid",
          ),
        ),
      ],
    );
  }

  buildPriorityField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Priority",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          RadioButtonGroup(
            labels: <String>[
              "Low Priority",
              "Medium Priority",
              "High Priority"
            ],
            onSelected: (String selected) {
              setState(() {
                priority = selected;
                prioritySelected = true;
              });
            },
          ),
        ],
      ),
    );
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
          buildTitleField(),
          buildSubjectField(),
          buildDescriptionField(),
          buildPriorityField(),
        ]
      ),
    );
  }
}