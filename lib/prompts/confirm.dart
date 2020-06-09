import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Confirm extends StatefulWidget {
  final String title, description;
  Function onOkay, onCancel;
  Color color, btnOneColor, btnTwoColor;
  Icon icon;
  Curve animationCurve;
  int animDuration;
  Text btnOneText, btnTwoText;
  bool transparent;

  Confirm({
    this.icon,
    this.color,
    this.title,
    this.transparent,
    this.btnOneText,
    this.btnTwoText,
    this.btnOneColor,
    this.btnTwoColor,
    @required this.description,
    @required this.animationCurve,
    @required this.animDuration,
    this.onOkay,
    this.onCancel,
  });

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  bool isCanceled = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.animDuration),
    )..addListener(() {
      setState(() {});
    });

    _animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
          parent: _animationController,
          curve: widget.animationCurve
      ),
    )..addStatusListener((state) {
      if (state == AnimationStatus.dismissed) {
        Navigator.of(context).pop();
        if(widget.onCancel != null && isCanceled) widget.onCancel();
        if(widget.onOkay != null && !isCanceled) widget.onOkay();
      }
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Lengths(context).padding16()),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Transform.scale(
        scale: _animation.value,
        child: Opacity(
          opacity: _animation.value,
          child: content(context),
        ),
        alignment: Alignment.center,
      ),
    );
  }

  Widget content(BuildContext context) {
    return Container(
      height: 200.0,
      width: 300.0,
      decoration: BoxDecoration(
        color: widget.color != null ? widget.color : widget.transparent ? primary.withOpacity(0.3) : primary,
        borderRadius: BorderRadius.circular(Lengths(context).padding16()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: widget.color != null ? widget.color : primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Lengths(context).padding16()),
                    topRight: Radius.circular(Lengths(context).padding16())
                )
            ),
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon != null ? widget.icon :
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: Lengths(context).padding16()*.5,),
                Text(widget.title != null ? widget.title : confirmTitle, style: TextStyle(fontSize: 18, color: Colors.white), ),
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
                color: widget.color != null ? widget.color : primary,
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
                  color: widget.btnOneColor != null ? widget.btnOneColor : success,
                  onPressed: () {
                    setState(() {
                      _animationController.reverse();
                    });
                  },
                  child: widget.btnOneText != null ? widget.btnOneText:
                  Text(
                      okText,
                      style: textBtnLight
                  ),
                ),
                SizedBox(
                  width: Lengths(context).padding16()*2,
                ),
                FlatButton(
                  color: widget.btnTwoColor != null ? widget.btnTwoColor : error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Lengths(context).padding16()),
                  ),
                  onPressed: () {
                    setState(() {
                      isCanceled = true;
                      _animationController.reverse();
                    });
                  },
                  child: widget.btnOneText != null ? widget.btnOneText:
                  Text(
                      cancelText,
                      style: textBtnLight
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