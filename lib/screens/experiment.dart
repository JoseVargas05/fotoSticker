import 'package:clima/screens/maps.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/screens/code_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:clima/screens/movable_widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String ubicacion = '';
  double latitud;
  double longitud;
  final databaseReference = Firestore.instance;

  @override
  initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    List<Placemark> placemark =
        await Geolocator().placemarkFromPosition(position);
    Placemark onePlace = placemark[1];

    setState(() {
      this.ubicacion = onePlace.administrativeArea;
      this.latitud = position.latitude;
      this.longitud = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              child: Center(
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
              margin: EdgeInsets.all(10.0),
            ),
            Image(
              image: AssetImage('images/check.png'),
              height: 80,
            ),
            Text(
              "Tú estás en:",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            GestureDetector(
              onTap: () async {
                var document = await databaseReference
                    .collection("lugares")
                    .document(this.ubicacion)
                    .get()
                    .then((DocumentSnapshot) =>
                        DocumentSnapshot.data);
                if (document == null) {
                  return Alert(
                          context: context,
                          title: "No se encuentran stickers en tu área")
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
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    this.ubicacion,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: new Color(0xFF404097),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CodeForm("establecimiento"),
                  ),
                );
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "LUGAR",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: new Color(0xFF404097),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CodeForm("evento"),
                  ),
                );
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "EVENTO",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: new Color(0xFF404097),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
              ),
            ),

            SizedBox(
              height: 40,
            ),
            GestureDetector(
              /*onTap: () async {
                final String _email =
                    'mailto:' + 'fotologer1@gmail.com' + '?subject=' + '&body=';
                await launch(_email);
              },*/
              child: Text(
                'Contacto: fotologer1@gmail.com',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}