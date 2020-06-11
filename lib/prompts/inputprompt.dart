import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cp_utils/cp_constants.dart';
import 'lengths.dart';

class InputPrompt extends StatefulWidget {
  final String title, description, inputHint;
  final int animDuration;
  final bool transparent;
  final Function onSubmit;
  final Icon icon;
  final Color color, btnOneColor;
  final Curve animationCurve;
  final Text btnOneText;

  InputPrompt({
    this.icon,
    this.color,
    this.title,
    this.onSubmit,
    this.transparent,
    this.inputHint,
    @required this.description,
    @required this.animationCurve,
    @required this.animDuration,
    this.btnOneColor,
    this.btnOneText,
  });

  @override
  _InputPromptState createState() => _InputPromptState();
}

class _InputPromptState extends State<InputPrompt>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
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
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    )..addStatusListener((state) {
        if (state == AnimationStatus.dismissed) {
          Navigator.of(context).pop();
          if (widget.onSubmit != null) widget.onSubmit(_textController.text);
        }
      });

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
        color: bgColor(widget.color, widget.transparent, cp_primary),
        borderRadius: BorderRadius.circular(
          Lengths(context).padding16(),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: widget.color != null ? widget.color : cp_primary,
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
                        Icons.help_outline,
                        color: Colors.white,
                        size: 20.0,
                      ),
                SizedBox(
                  width: Lengths(context).padding16() * .5,
                ),
                Text(
                  widget.title != null ? widget.title : inputTitle,
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
            padding: EdgeInsets.symmetric(
              horizontal: Lengths(context).padding16(),
              vertical: Lengths(context).padding16() * 1.25,
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Lengths(context).padding16(),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Lengths(context).padding16(),
                  ),
                  color: widget.transparent ? Colors.white70 : Colors.white,
                  border: Border.all(
                    color: widget.color != null ? widget.color : cp_primary,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: _textController,
                  autocorrect: true,
                  decoration: InputDecoration(
                    hintText: widget.inputHint,
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white70,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.color != null ? widget.color : cp_primary,
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
                        widget.btnOneColor != null ? widget.btnOneColor : cp_white,
                    onPressed: () {
                      setState(() {
                        _animationController.reverse();
                      });
                    },
                    child: widget.btnOneText != null
                        ? widget.btnOneText
                        : Text(
                            inputText,
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
