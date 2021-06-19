import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var _color =Color.fromRGBO(32, 36, 52,1);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      child: ListView(
        children: [

        ],
      ),
    );
  }
}
