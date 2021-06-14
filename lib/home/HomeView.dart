import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  var _color =Color.fromRGBO(32, 36, 52,1);
   bool isSwitched=false;
   bool isSwitched1=false;

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
                        Icon(Icons.ac_unit_outlined,size: 30,color: Colors.lightBlue,),
                        Text("Humidity",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text("${_humidity}",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.waves_outlined,size: 30,color: Colors.cyan,),
                        Text("Rainy",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_rainy=="0"?"0%":"100%",style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                    Expanded(child:  Column(
                      children: [
                        Icon(Icons.thermostat_outlined,size: 30,color: Colors.redAccent,),
                        Text("temperature",style: TextStyle(color: Colors.white,fontSize: 17),),
                        Text(_temp,style: TextStyle(color: Colors.white,fontSize: 13),)
                      ],
                    ),),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                       child: Container(
                         margin: EdgeInsets.only(left: 12,top: 16,right: 6),
                         width: 130,
                         height: 100,
                         color: Color.fromRGBO(27, 27, 48, 1),
                         child: Column(
                           children: [
                             Padding(
                               padding: const EdgeInsets.only(top: 8),
                               child: Align(
                                 alignment: Alignment.center,
                                 child: Text("Fan",style: TextStyle(color: Colors.white,fontSize: 25),),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.all(1),
                               child: Align(
                                 alignment: Alignment.center,
                                 child:Switch(
                                   splashRadius: 145,
                                   value: isSwitched,
                                   onChanged: toggleSwitch,
                                   activeColor: Colors.blue,
                                   activeTrackColor: Colors.yellow,
                                   inactiveThumbColor: Colors.redAccent,
                                   inactiveTrackColor: Colors.orange,
                                 )
                               ),
                             )
                           ],
                         )
                       ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 12,top: 16,left: 6),
                        width: 130,
                        height: 100,
                        color: Color.fromRGBO(27, 28, 48, 1),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Window",style: TextStyle(color: Colors.white,fontSize: 25),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Align(
                                  alignment: Alignment.center,
                                  child:Switch(
                                    splashRadius: 145,
                                    value: isSwitched1,
                                    onChanged: toggleSwitch1,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.yellow,
                                    inactiveThumbColor: Colors.redAccent,
                                    inactiveTrackColor: Colors.orange,
                                  )
                              ),
                            )
                          ],
                        ),

                      ),
                    )

                  ],
                )


              ],
            )),

        ],
      ),
    );
  }

  void toggleSwitch(bool value) {
    if(isSwitched == false) {
      setState(() {
        isSwitched = true;
        //textValue = 'Switch Button is ON';
        databaseReference.update({
          'fan': '1',
        });
      });
    }
    else {
      setState(() {
        isSwitched = false;
        databaseReference.update({
          'fan': '0',
        });
      });
      print('Switch Button is OFF');
    }
  }
  void toggleSwitch1(bool value) {
    if(isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
        databaseReference.update({
          'window': '1',
        });
      });
    }
    else {
      setState(() {
        isSwitched1 = false;
        databaseReference.update({
          'window': '0',
        });
      });
    }
  }


  @override
  void initState() {
    getData();
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
