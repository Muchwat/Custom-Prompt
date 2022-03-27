import 'package:flutter/material.dart';

import '../cp_utils/cp_constants.dart';
import 'lengths.dart';

class Warning extends StatefulWidget {
  final String? title, description;
  final int animDuration;
  final bool? transparent;
  final Function? onOkay;
  final Icon? icon;
  final Color? color, btnOneColor;
  final Curve animationCurve;
  final Text? btnOneText;

  Warning({
    this.icon,
    this.color,
    this.title,
    this.transparent,
    required this.description,
    required this.animationCurve,
    required this.animDuration,
    this.btnOneColor,
    this.btnOneText,
    this.onOkay,
  });

  @override
  _WarningState createState() => _WarningState();
}

class _WarningState extends State<Warning> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

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
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    )..addStatusListener(
        (state) {
          if (state == AnimationStatus.dismissed) {
            Navigator.of(context).pop();
            widget.onOkay ?? print('Pressed Okay');
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
    double h = Lengths(context).height(), w = Lengths(context).width();

    return Container(
      height: h * 0.4, // 200.0,
      width: w * 0.6, // 300.0,
      decoration: BoxDecoration(
        color: bgColor(widget.color, widget.transparent, cp_warning),
        borderRadius: BorderRadius.circular(
          Lengths(context).padding16(),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: widget.color ?? cp_warning,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Lengths(context).padding16(),
                ),
                topRight: Radius.circular(
                  Lengths(context).padding16(),
                ),
              ),
            ),
            height: h * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.icon ??
                    Icon(
                      Icons.warning,
                      color: Colors.white,
                      size: w * 0.05, //20
                    ),
                SizedBox(
                  width: Lengths(context).padding16() * .5,
                ),
                Text(
                  widget.title ?? warningTitle,
                  style: TextStyle(
                    fontSize: h * 0.03, //18,
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
              padding: EdgeInsets.all(
                h * 0.03,
              ),
              child: Center(
                child: Wrap(
                  children: [
                    Text(
                      widget.description ?? "Description",
                      style: TextStyle(
                        fontSize: h * 0.03, // 16,
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
              color: widget.color ?? cp_warning,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  Lengths(context).padding16(),
                ),
                bottomRight: Radius.circular(
                  Lengths(context).padding16(),
                ),
              ),
            ),
            height: h * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: w * 0.5, //200
                  height: h * 0.075, //40
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        Lengths(context).padding16(),
                      ),
                    ),
                    color: widget.btnOneColor ?? cp_white,
                    onPressed: () {
                      setState(
                        () {
                          _animationController.reverse();
                        },
                      );
                    },
                    child: widget.btnOneText ??
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

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
