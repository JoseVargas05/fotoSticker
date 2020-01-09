import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 180,
              width: 180,
              child: Center(
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
              ),
              margin: EdgeInsets.all(15.0),
            ),
            Text(
              'TU UBICACIÓN',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // OptionWidget("LUGAR", 'images/mundo.png'),
            // OptionWidget("ESTABLECIMIENTO", 'images/local.png'),
            OptionWidget('EVENTO', 'images/especial.png'),
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  OptionWidget(this.buttonText, this.imagePath);
  final buttonText;
  final imagePath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            height: 45,
            color: Colors.white,
                      child: Container(
              height: 45.0,
              width: 300.0,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
              margin: new EdgeInsets.only(left: 15.0, right: 15.0),
              decoration: new BoxDecoration(
                color: new Color(0xFF404097),
                borderRadius: new BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          alignment: FractionalOffset.centerRight,
          child: Image(
            height: 150.0,
            width: 150.0,
            image: AssetImage(imagePath),
          ),
        ),
      ],
    );
  }
}
