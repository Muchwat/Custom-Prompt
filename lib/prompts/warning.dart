import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class Warning extends StatefulWidget {
  final String title, description;
  int animDuration;
  bool transparent;
  Function onOkay;
  Icon icon;
  Color color, btnOneColor;
  Curve animationCurve;
  Text btnOneText;
  Warning({
    this.icon,
    this.color,
    this.title,
    this.transparent,
    @required this.description,
    @required this.animationCurve,
    @required this.animDuration,
    this.btnOneColor,
    this.btnOneText,
    this.onOkay,
  });

  @override
  _WarningState createState() => _WarningState();
}

class _WarningState extends State<Warning> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

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
        if(widget.onOkay != null) widget.onOkay();
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
        color: widget.color != null ? widget.color : widget.transparent ? warning.withOpacity(0.3) : warning,
        borderRadius: BorderRadius.circular(Lengths(context).padding16()),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: widget.color != null ? widget.color : warning,
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
                  Icons.warning,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: Lengths(context).padding16()*.5,),
                Text(widget.title != null ? widget.title : warningTitle, style: TextStyle(fontSize: 18, color: Colors.white), ),
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
                color: widget.color != null ? widget.color : warning,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Lengths(context).padding16()),
                    bottomRight: Radius.circular(Lengths(context).padding16())
                )
            ),
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Lengths(context).padding16()),
                    ),
                    color: widget.btnOneColor != null ? widget.btnOneColor : white,
                    onPressed: () {
                      setState(() {
                        _animationController.reverse();
                      });
                    },
                    child: widget.btnOneText != null ? widget.btnOneText :
                    Text(
                      okText,
                      style: textBtnDark,
                    ),
                  ),
                ),
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