import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class Confirm extends StatefulWidget {
  final String title, description, cancelBtnText, okayBtnText;
  Function onOkay, onCancel;
  Color color;

  Confirm({
    @required this.color,
    @required this.title,
    @required this.description,
    this.cancelBtnText,
    this.okayBtnText,
    this.onOkay,
    this.onCancel,
  });

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  CustomAnimationControl control;
  bool isForward, isCanceled;
  @override
  void initState() {
    super.initState();
    isForward = true;
    isCanceled = false;
    control = CustomAnimationControl.PLAY;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Lengths(context).padding16()),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    CustomAnimation animation = CustomAnimation<double>(
      curve: Curves.bounceOut,
      control: control,
      tween: (0.0).tweenTo(1.0),
      duration: 700.milliseconds,
      child: content(context), // <-- specify widget called "child"
      builder: (context, child, value) {

        if(value == 0.0 && !isForward) {
          WidgetsBinding.instance.addPostFrameCallback((_){
            if(widget.onCancel != null && isCanceled) widget.onCancel();
            if(widget.onOkay != null && !isCanceled) widget.onOkay();
            Navigator.of(context).pop();
          });
        }

        return Transform(
          transform: Matrix4.identity()..scale(value),
          child: Opacity(
            opacity: value,
            child: child,
          ),
          alignment: Alignment.center,
        );
      },
    );
    return animation;
  }

  Widget content(BuildContext context) {
    return Container(
      height: 200.0,
      width: 300.0,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(Lengths(context).padding16()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Lengths(context).padding16()),
                    topRight: Radius.circular(Lengths(context).padding16())
                )
            ),
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: Lengths(context).padding16(),),
                Text(widget.title, style: TextStyle(fontSize: 18, color: Colors.white), ),
              ],
            ),
          ),
          Container(
            height: 92,
            color: Colors.black87.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Center(
                  child: Text(widget.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white,),),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Lengths(context).padding16()),
                    bottomRight: Radius.circular(Lengths(context).padding16())
                )
            ),
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Lengths(context).padding16()),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    setState(() {
                      isForward = false;
                      control = CustomAnimationControl.PLAY_REVERSE;
                    });
                  },
                  child: Text(
                    widget.okayBtnText,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white,),
                  ),
                ),
                SizedBox(
                  width: Lengths(context).padding16()*2,
                ),
                FlatButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Lengths(context).padding16()),
                  ),
                  onPressed: () {
                    setState(() {
                      isForward = false;
                      isCanceled = true;
                      control = CustomAnimationControl.PLAY_REVERSE;
                    });
                  },
                  child: Text(
                    widget.cancelBtnText,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
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


class Lengths {
  static var context;
  MediaQueryData _mediaQueryData;

  Lengths(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  double padding16() {
    return _mediaQueryData.size.width * 0.044444444444444;
  }
}