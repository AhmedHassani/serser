import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:senser/notification/db.dart';
import 'package:senser/notification/model1.dart';

import '../main.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final databaseReference = FirebaseDatabase.instance.reference();
  String _humidity="";
  String _rainy="";
  String _temp="";
  String _window ="";
  String _fan="";
  String _light="";
  var _color =Color.fromRGBO(32, 36, 52,1);
   double _sizeIcon = 40;
   double _sizeFont = 25;
   double _sizeFontTitle = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      child: Column(
        children: [
          Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [
                          Colors.white.withOpacity(0.2),
                          Colors.white.withOpacity(0.2),
                        ])),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,
                                3), // changes position of shadow
                          ),
                        ]),
                  ),
                  Text(
                    '${_temp}°C',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600),
                  )
                ],
              )
          ),
          Expanded(
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.ac_unit_outlined,size: _sizeIcon,color: Colors.lightBlue,),
                        Text("Humidity",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text("${_humidity}",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.waves_outlined,size: _sizeIcon,color: Colors.cyan,),
                        Text("Rainy",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_rainy=="0"?"0%":"100%",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.thermostat_outlined,size: _sizeIcon,color: Colors.redAccent,),
                        Text("temperature",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_temp,style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.sensor_window,size: _sizeIcon,color: Colors.green,),
                        Text("Window",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_window=="0"?"close":"open",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.stream,size: _sizeIcon,color: Colors.blueAccent,),
                        Text("Fan",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_fan=="0"?"close":"open",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.highlight,size: _sizeIcon,color: Colors.amber,),
                        Text("Light",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_light=="0"?"close":"open",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                  ],
                ),



              ],
            )),

        ],
      ),
    );
  }


  @override
  void initState() {
    getData();
    ModelNotifci item = new ModelNotifci(
        title: "error",
        bady: "sent",
        time: '44'
    );
    DB.insert(ModelNotifci.table, item);
  }

  void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print(snapshot.value);
      databaseReference.onChildChanged.listen((event) {
        var msg ="There is a fire in the house";
        var msg1 = "There is a Gas in the house";
        if(event.snapshot.key=='fires_ensor'){
          if(event.snapshot.value==1){
            scheduleAlarm(msg);
          }
        }
        if(event.snapshot.key=='gas_sensor'){
          if(event.snapshot.value>600){
            scheduleAlarm(msg1);
          }
        }


      });
      setState(() {
        _humidity="${snapshot.value['Humidity']}";
        _rainy="${snapshot.value['rainy_sensor']}";
        _temp="${snapshot.value['tempC_sensor']}";
        _window="${snapshot.value['window']}";
        _light="${snapshot.value['light']}";
        _fan="${snapshot.value['fan']}";
      });
    });
  }

  void scheduleAlarm(var massage) async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Warning !',massage,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }


}
