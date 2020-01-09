import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clima/screens/movable_widgets.dart';

class CodeForm extends StatefulWidget {
  String tipo;
  CodeForm(this.tipo);
  @override
  _CodeFormState createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF00AFF0), body: MyCustomForm(widget.tipo));
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  String tipo;
  MyCustomForm(this.tipo);
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final databaseReference = Firestore.instance;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text(
            'Ingrese su código de ' + widget.tipo,
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController,
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            child: Text("Ingresar"),
            onPressed: () async {
              print(myController.text);
              var document = await databaseReference
                  .collection(widget.tipo + 's')
                  .document(myController.text)
                  .get()
                  .then((DocumentSnapshot) =>
                      // print(DocumentSnapshot.data)
                      DocumentSnapshot.data);
              if (document == null) {
                print(document);
                return Alert(
                        context: context,
                        title:
                            "No se encuentran stickers para tu " + widget.tipo)
                    .show();
              } else {
                print(document);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeView(document['stickers']),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
