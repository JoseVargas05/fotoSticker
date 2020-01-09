import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:clima/screens/save_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotoEditor extends StatefulWidget {
  @override
  _FotoEditorState createState() => _FotoEditorState();
}

class _FotoEditorState extends State<FotoEditor> {
  GlobalKey _globalKey = new GlobalKey();
  _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      print(pngBytes);
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SaveStratScreen(
                pngData: pngBytes,
              ),
        ),
      );
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  File imageFile;
  
  _openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    var decodedImage = await decodeImageFromList(picture.readAsBytesSync());
    this.setState(() {
      imageFile = picture;
      
      print(decodedImage.width);
      print(decodedImage.height);
    });
  }

  _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Padding(
        padding: const EdgeInsets.all(80.0),
        child: Text("Ninguna Imagen Seleccionada!"),
      );
    } else {
      return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  child: Stack(children: <Widget>[
                    // Image(
                    //   // height: 280,
                    //   image: AssetImage('images/beach.jpg'),
                    // ),
                    Image.file(imageFile, width: 200, height: 300),
                    Draggable(
                      child: Image(
                        height: 50,
                        width: 200,
                        image: AssetImage('images/letras_cancun.png'),
                      ),
                      feedback: Image(
                        height: 50,
                        width: 200,
                        image: AssetImage('images/letras_cancun.png'),
                      ),
                      childWhenDragging: Container(),
                    ),
                  ]),
                ),
              ),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _openGallery();
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        "SELECCIONAR FOTO",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF404097),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _openCamera();
                  },
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        "TOMAR FOTO",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF404097),
                    ),
                  ),
                )
              ],
            ),
            _decideImageView(),
            Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "SELECCIONA LA PLANTILLA QUE QUIERAS USAR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF404097),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 50.0),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 150,
                  decoration: new BoxDecoration(
                    color: Colors.grey[300],
                    border: new Border.all(
                        color: Color(0xFF404097),
                        width: 5.0,
                        style: BorderStyle.solid),
                  ),
                  child: Image(
                    image: AssetImage('images/letras_cancun.png'),
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    _capturePng();
                  },
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        "ACEPTAR",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF404097),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AccessButton extends StatelessWidget {
  AccessButton(this.buttonText);
  final buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        height: 30,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF404097),
        ),
      ),
    );
  }
}
