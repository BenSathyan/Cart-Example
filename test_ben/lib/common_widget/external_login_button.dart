import 'package:flutter/material.dart';

class ExternalLoginButton extends StatefulWidget {
  final String title;
  final String imagePath;
  final Function onTap;
  final Color textColor;
  final Color buttonColor;

  ExternalLoginButton({
    this.title,
    this.imagePath,
    this.onTap,
    this.textColor,
    this.buttonColor
  });

  @override
  _ExternalLoginButtonState createState() => _ExternalLoginButtonState();
}

class _ExternalLoginButtonState extends State<ExternalLoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            color: widget.buttonColor,
            shape: RoundedRectangleBorder(
              side: new BorderSide(
                  color: widget.buttonColor, width: 1.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              height: 60.0,
              width: 350,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        widget.imagePath,
                        width: 25.0,
                      ),
                    Spacer(),
                      Center(
                        child: Text(
                          '${widget.title}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.textColor,
                              fontSize: 20),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            )),
      ),
      onTap: () async {
        widget.onTap();
      },
    );
  }
}
