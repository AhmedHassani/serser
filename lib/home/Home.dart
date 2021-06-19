
import 'package:flutter/material.dart';
import 'package:senser/device/deviceView.dart';
import 'package:senser/home/HomeView.dart';
import 'package:senser/notification/notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  var _color =Color.fromRGBO(32, 36, 52,1);
  final List<Widget> _children = [
    HomeView(),
    Device(),
    Notifications(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Align(
             alignment: Alignment.centerLeft,
              child: Text("IOT HOME SENSOR",
                 style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                     color: Colors.white),
              )),
        backgroundColor:_color,
        elevation: 0.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color.fromRGBO(27, 28, 48, 1),
        elevation: 0.0,
        currentIndex: 0, //
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        onTap: onTabTapped,// this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex==0? new Icon(Icons.home,color:  Colors.yellow,size: 30,) : new Icon(Icons.home,color: Colors.white,size: 25),
            backgroundColor: Colors.yellow,
            title: new Text('Home',style: TextStyle(color: _currentIndex==0?   Colors.yellow :Colors.white )),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex==1? new Icon(Icons.widgets_outlined,color:  Colors.yellow,size: 30) :new Icon(Icons.widgets_outlined,color: Colors.white,size: 25),
            backgroundColor:  Colors.yellow,
            title: new Text('Device',style: TextStyle(color: _currentIndex==1?  Colors.yellow :Colors.white )),
          ),
          BottomNavigationBarItem(
              icon:  _currentIndex==2? Icon(Icons.notifications,color:  Colors.yellow,size: 30):Icon(Icons.notifications,color: Colors.white,size: 25),
              backgroundColor:  Colors.yellow,
              title: Text('notifications',style: TextStyle(color: _currentIndex==2?   Colors.yellow :Colors.white,),)
          )
        ],
      ),
      body: _children[_currentIndex]
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
