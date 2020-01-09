import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:clima/screens/save_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' as prefix0;
import 'package:image_picker/image_picker.dart';
import 'package:clima/custom_widgets/moveable_sticker.dart';
import 'package:flutter/widgets.dart';
int wtContainerDrag = 0;
int htContainerDrag = 0;

class HomeView extends StatefulWidget {
  List stickerURLS;
  HomeView(this.stickerURLS);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey _globalKey = new GlobalKey();
  List<Widget> movableItems = [];
  List<Widget> stickersAvailable = [];
  
  @override
  void initState() {
    for (var stickerURL in widget.stickerURLS) {
      Widget stickerContainer = FlatButton(
        color: Colors.black26,
        onPressed: () {
          setState(() {
            movableItems.add(MoveableStackItem(stickerURL));
          });
        },
        //barra de estiquer
        child: Padding(

          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Container( width: 80, child: Image.network(stickerURL)),
        ),
      );
      stickersAvailable.add(stickerContainer);
    }

    movableItems.add(
      Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Center(
              child: Text("TU FOTO AQUI",
                  style: TextStyle(
                    color: Color(0xFF00AFF0),
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
    super.initState();
  }

  File imageFile;

  _openGallery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    //VARIABLE QUE OBTIENE LA INFORMACION PARA OBTENER EL ALTO Y EL ANCHO DE LA IMAGEN SELECCIONADA
     var decodedImage = await decodeImageFromList(picture.readAsBytesSync());
    this.setState(() {
      imageFile = picture;
      //AQUI SE EXTRAE EL ALTO Y ANCHO DE LA IMAGEN SELECCIONADA
      print(decodedImage.width);
      print(decodedImage.height);
      //VARIABLES QUE OBTIENEN EL ANCHO Y ALTO PARA LUEGO USARLAS EN MOVEABLE_STICKER.DART
      wtContainerDrag = decodedImage.width;
      htContainerDrag = decodedImage.height;
      if (imageFile == null) {
      } else {
        movableItems = [];
        // movableItems.add(
        //   Container(
        //     width: 1000,
        //     height: 1000,
        //     child: Image.file(imageFile),
        //   ),
        // );
        // movableItems.add(
        //   BackdropFilter(
        //     filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        //     child: new Container(
        //       // width: double.infinity,
        //       // height: double.infinity,
        //       decoration: new BoxDecoration(
        //           color: Colors.blue.shade200.withOpacity(0.5)),
        //     ),
        //   ),
        // );
        movableItems.add(
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Image.file(imageFile),
            ),
          ),
        );
        // movableItems.add(Image.file(imageFile));
      }
    });
  }

  _openCamera() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      if (imageFile == null) {
      } else {
        movableItems = [];
        movableItems.add(
          Positioned(
            height: SizeConfig.blockSizeHorizontal * 130,
            child: Image.file(imageFile),
          ),
        );
      }
    });
  }

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
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            //PRUEBA - EN LOS DOS CASOS ES LO MISMO: SE PUEDE DEJAR SOLO SizeConfig.blockSizeHorizontal * 130 , SizeConfig.blockSizeVertical * 75
            width: wtContainerDrag == 0 ? SizeConfig.blockSizeHorizontal * 130: SizeConfig.blockSizeHorizontal * 130,
            height: htContainerDrag == 0 ? SizeConfig.blockSizeVertical * 75: SizeConfig.blockSizeVertical * 75,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 50, 15, 50),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(
                        0xFF404097), //                   <--- border color
                    width: 10.0,
                  ),
                ),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Center(
                    child: Stack(
                      children: movableItems,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF404097), width: 1),
            ),
            height: SizeConfig.blockSizeVertical * 12,
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: stickersAvailable),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (movableItems.length > 1) {
                        movableItems.removeLast();
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Image.asset("images/regresar.png"),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _openGallery();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "GALERÍA",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
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
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CAMARA",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF404097),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _capturePng();
                  },
                  child: Container(
                    // margin: EdgeInsets.all(10.0),
                    child: Center(
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Image.asset("images/aceptar.png"),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
