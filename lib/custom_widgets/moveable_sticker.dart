import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:clima/screens/movable_widgets.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MoveableStackItem extends StatefulWidget {
  String stickerURL;
  MoveableStackItem(this.stickerURL);
  @override
  _MoveableStackItemState createState() => _MoveableStackItemState();
}

class _MoveableStackItemState extends State<MoveableStackItem> {

  Matrix4 matrix;
  ValueNotifier<Matrix4> notifier;
  Boxer boxer;

  @override
  void initState() {
    super.initState();
    matrix = Matrix4.identity();
    notifier = ValueNotifier(matrix);
  }

  @override
  Widget build(BuildContext context) {
    var size = Image.network(widget.stickerURL).width;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        var width = constraints.biggest.width / 1.5;
        var height = constraints.biggest.height / 2.0;
        var dx = (constraints.biggest.width - width) / 2;
        var dy = (constraints.biggest.height - height) / 2;
        matrix.leftTranslate(dx, dy);
        boxer = Boxer(Offset.zero & constraints.biggest,
            Rect.fromLTWH(0, 0, width, height));
        return MatrixGestureDetector(
          onMatrixUpdate: (m, tm, sm, rm) {
            matrix = MatrixGestureDetector.compose(matrix, tm, sm, rm);
            boxer.clamp(matrix);
            notifier.value = matrix;
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.topLeft,
            color: Colors.transparent,
            child: AnimatedBuilder(
              builder: (ctx, child) {
                return Transform(
                  transform: matrix,
                  child: Container(
                    color: Colors.red,
                    width: width,
                    height: height,
                    child: Center(
                      child: Image.network(widget.stickerURL),
                    ),
                  ),
                );
              },
              animation: notifier,
            ),
          ),
        );
      },
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
class Boxer {
  final Rect bounds;
  final Rect src;
  Rect dst;

  Boxer(this.bounds, this.src);

  void clamp(Matrix4 m) {
    dst = MatrixUtils.transformRect(m, src);
    if (bounds.left <= dst.left &&
        bounds.top <= dst.top &&
        bounds.right >= dst.right &&
        bounds.bottom >= dst.bottom) {
      // bounds contains dst
      return;
    }

    if (dst.width > bounds.width || dst.height > bounds.height) {
      Rect intersected = dst.intersect(bounds);
      FittedSizes fs = applyBoxFit(BoxFit.contain, dst.size, intersected.size);

      vector.Vector3 t = vector.Vector3.zero();
      intersected = Alignment.center.inscribe(fs.destination, intersected);
      if (dst.width > bounds.width)
        t.y = intersected.top;
      else
        t.x = intersected.left;

      var scale = fs.destination.width / src.width;
      vector.Vector3 s = vector.Vector3(scale, scale, 0);
      m.setFromTranslationRotationScale(t, vector.Quaternion.identity(), s);
      return;
    }

    if (dst.left < bounds.left) {
      m.leftTranslate(bounds.left - dst.left, 0.0);
    }
    if (dst.top < bounds.top) {
      m.leftTranslate(0.0, bounds.top - dst.top);
    }
    if (dst.right > bounds.right) {
      m.leftTranslate(bounds.right - dst.right, 0.0);
    }
    if (dst.bottom > bounds.bottom) {
      m.leftTranslate(0.0, bounds.bottom - dst.bottom);
    }
  }
}
