import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photos_saver/photos_saver.dart';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'dart:convert';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SaveStratScreen extends StatelessWidget {
  final Uint8List pngData;

  SaveStratScreen({var this.pngData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00AFF0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                PhotosSaver.saveFile(fileData: pngData);
                return Alert(
                    context: context,
                    title: "¡Guardado Exitosamente!",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "¡Listo!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ]).show();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "GUARDAR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              // width: MediaQuery.of(context).size.width,
              height: 450,
              child: FittedBox(
                child: Image.memory(pngData),
                fit: BoxFit.fill,
              ),
            ),
            GestureDetector(
              onTap: () async {
                await Share.file(
                    'esys image', 'social_location.png', pngData, 'image/png',
                    text: 'Compartido desde foto Loger');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  "COMPARTIR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
