import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'lengths.dart';

class Error extends StatefulWidget {
  final String title, description;
  final int animDuration;
  final Function onOkay;
  final Icon icon;
  final Color color, btnOneColor;
  final Curve animationCurve;
  final Text btnOneText;
  final bool transparent;

  Error({
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
  _ErrorState createState() => _ErrorState();
}

class _ErrorState extends State<Error> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.animDuration,
      ),
    )..addListener(
        () {
          setState(
            () {},
          );
        },
      );

    _animation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
          parent: _animationController, curve: widget.animationCurve),
    )..addStatusListener(
        (state) {
          if (state == AnimationStatus.dismissed) {
            Navigator.of(context).pop();
            if (widget.onOkay != null) widget.onOkay();
          }
        },
      );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Lengths(context).padding16(),
        ),
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
        color: bgColor(widget.color, widget.transparent, error),
        borderRadius: BorderRadius.circular(
          Lengths(context).padding16(),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: widget.color != null ? widget.color : error,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Lengths(context).padding16(),
                ),
                topRight: Radius.circular(
                  Lengths(context).padding16(),
                ),
              ),
            ),
            height: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon != null
                    ? widget.icon
                    : Icon(
                        Icons.highlight_off,
                        color: Colors.white,
                        size: 20.0,
                      ),
                SizedBox(
                  width: Lengths(context).padding16() * .5,
                ),
                Text(
                  widget.title != null ? widget.title : errorTitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 92,
            color: Colors.black87.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Wrap(
                  children: [
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.color != null ? widget.color : error,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  Lengths(context).padding16(),
                ),
                bottomRight: Radius.circular(
                  Lengths(context).padding16(),
                ),
              ),
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
                      borderRadius: BorderRadius.circular(
                        Lengths(context).padding16(),
                      ),
                    ),
                    color:
                        widget.btnOneColor != null ? widget.btnOneColor : white,
                    onPressed: () {
                      setState(() {
                        _animationController.reverse();
                      });
                    },
                    child: widget.btnOneText != null
                        ? widget.btnOneText
                        : Text(
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

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
