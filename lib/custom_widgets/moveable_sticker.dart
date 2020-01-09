import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:clima/screens/movable_widgets.dart';

class MoveableStackItem extends StatefulWidget {
  String stickerURL;
  MoveableStackItem(this.stickerURL);
  @override
  _MoveableStackItemState createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  Matrix4 matrix = Matrix4.identity();
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
        /*var wp =  (wtContainerDrag * 95)/720;
        var wm =  (wtContainerDrag * -58)/720;
        
        var hp = (htContainerDrag * 57)/451;
        var hm = (htContainerDrag * -45)/451;*/
        //SE ESTABLECE LAS COORDENADAS X,Y , SI DETECTA QUE SALE DEL AREA NO SE MUEVE MAS (HAY QUE HACERLO DINAMICO SEGUN EL TAMAÑO DE LA IMAGEN)
          double x = 0;
          double y = 0;
          //COMPROBACIÓN X+ X-
          if (m.getTranslation()[0] < 95 && m.getTranslation()[0] > -58) {
            x = m.getTranslation()[0];
          } else{
            if(m.getTranslation()[0] < 0){
              x = -58;
            }else{
              x = 95;
            }
          }
          //COMPROBACIÓN Y+ Y-
          if (m.getTranslation()[1] < 57 && m.getTranslation()[1] > -45) {
            y = m.getTranslation()[1];
          }else{
            if(m.getTranslation()[1] < 0){
              y = -45;
            }else{
              y = 57;
            }
          }
          //SE AGREGA EL CAMBIO EN X Y - Z SE QUEDA IGUAL
          m.setTranslationRaw(x, y, m.getTranslation()[2]);
         if (m.determinant() > 0.99) {
            notifier.value = m;
          } else {
            m.setIdentity();
            notifier.value.setIdentity();
          }
          
        setState(() {
          matrix = m;
        });
      },
      //SE DESACTIVO EL ROTAR Y LA ESCALA PARA HACER PRUEBAS YA QUE ESTAS FALLAN CON EL NUEVO MÉTODO, EL PIVOTE CENTRAL DEL STICKER SE MUEVE
      shouldRotate: false,
      shouldScale: false,
      child: Transform(
        transform: matrix,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(widget.stickerURL),
        // child: Container(
        //   width: 300,
        //   height: 150,
        //   child: Image.network(widget.stickerURL),
        ),
      ),
    );
    // return Positioned(
    //   top: yPosition,
    //   left: xPosition,
    //   child: GestureDetector(
    //     onPanUpdate: (tapInfo) {
    //       setState(() {
    //         xPosition += tapInfo.delta.dx;
    //         yPosition += tapInfo.delta.dy;
    //       });
    //     },
    //     child: Container(
    //       width: 150,
    //       height: 150,
    //       child: Image.network(widget.stickerURL),
    //     ),
    //   ),
    // );
  }
}
