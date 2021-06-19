import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Device extends StatefulWidget {
  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  final databaseReference = FirebaseDatabase.instance.reference();
  String  _window ="";
  String _fan="";
  String _light="";
  bool isSwitched=false;
  bool isSwitched1=false;
  bool isSwitched2=false;
  var _color =Color.fromRGBO(32, 36, 52,1);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                            child: Text("Light",style: TextStyle(color: Colors.white,fontSize: 25),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: Align(
                              alignment: Alignment.center,
                              child:Switch(
                                splashRadius: 145,
                                value: isSwitched2,
                                onChanged: toggleSwitch2,
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
            ],
          )
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
  void toggleSwitch2(bool value) {
    if(isSwitched2 == false) {
      setState(() {
        isSwitched2 = true;
        databaseReference.update({
          'light': '1',
        });
      });
    }
    else {
      setState(() {
        isSwitched2 = false;
        databaseReference.update({
          'light': '0',
        });
      });
    }
  }

  @override
  void initState() {
    databaseReference.once().then((DataSnapshot snapshot) {
    setState(() {
      _window="${snapshot.value['window']}";
      _light="${snapshot.value['light']}";
      _fan="${snapshot.value['fan']}";
      if(_fan=="1"){
        isSwitched=true;
      }
      if(_window=="1"){
        isSwitched1=true;
      }
      if(_light=="1"){
        isSwitched2=true;
      }
    });
    });
  }
}
