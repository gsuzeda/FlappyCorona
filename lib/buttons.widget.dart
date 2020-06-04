import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final label;
  final func;
  Buttons({Key key, @required this.label, this.func}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width / 25,
        left: MediaQuery.of(context).size.width / 25,
        top: MediaQuery.of(context).size.height / 80,
        bottom: MediaQuery.of(context).size.height / 80,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.height / 10,
        ),
      ),
      child: FlatButton(
        child: Text(label,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 30,
              fontFamily: "Angry Birds",
            )),
        onPressed: func,
      ),
    );
  }
}
