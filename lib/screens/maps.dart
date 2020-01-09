import 'package:clima/screens/foto_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clima/screens/movable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MapsScreen extends StatefulWidget {
  double latitud;
  double longitud;
  String locale;
  MapsScreen(this.latitud, this.longitud, this.locale);
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  List<Marker> allMarkers = [];
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
    allMarkers.add(
      Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(widget.latitud, widget.longitud),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: 180,
                width: 180,
                child: Center(
                  child: Image(
                    image: AssetImage('images/logo.png'),
                  ),
                ),
              ),
              Text(
                "LUGAR",
                style: TextStyle(
                    color: Color(0xFF404097),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Image(
                    image: AssetImage('images/check.png'),
                  ),
                ),
                margin: EdgeInsets.only(bottom: 10.0),
              ),
              Container(
                decoration: new BoxDecoration(
                  border: new Border.all(
                      color: Color(0xFF404097),
                      width: 5.0,
                      style: BorderStyle.solid),
                ),
                height: 220,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(19.4973621, -99.1450488),
                    zoom: (15.0),
                  ),
                  markers: Set.from(allMarkers),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  var document = await databaseReference
                      .collection("lugares")
                      .document(widget.locale)
                      .get()
                      .then((DocumentSnapshot) => 
                        // print(DocumentSnapshot.data)
                        DocumentSnapshot.data
                      );
                  if (document == null){
                    return Alert(context: context, title: "No se encuentran stickers en tu área").show();
                  } else {
                    print(document);
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(document['stickers']),
                    ),
                  );
                  }

                  // widget.locale

                  
                },
                child: Container(
                  color: Colors.grey[300],
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Opacity(
                          child: Image(
                            image: AssetImage('images/location.png'),
                          ),
                          opacity: 0.2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.locale,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'México',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
