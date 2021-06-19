import 'package:flutter/material.dart';
import 'package:senser/otp/otpui.dart';
class OTPNumber extends StatelessWidget {
  var _color=Color.fromRGBO(32, 36, 52,1);
  TextEditingController _controller = new TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [

    ];

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: _color,
          title: Text("Login", style: TextStyle(
            color:Colors.white,
            fontWeight: FontWeight.bold,

          ),
          ),
        ),
        backgroundColor: _color,
        body:ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 20.0, right: 16.0),
                  child: Text("Enter your phone number",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,),
                ),

              /* Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Image(
                    image: AssetImage('Assets/images/otp-icon.png'),
                    height: 120.0,
                    width: 120.0,),
                ),*/

                Row(
                  children: <Widget>[

                    Flexible(
                      child: new Container(
                      ),
                      flex: 1,
                    ),

                    Flexible(
                      child: new TextFormField(

                        textAlign: TextAlign.center,
                        autofocus: false,
                        initialValue: "+964",
                        enabled: false,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      flex: 3,
                    ),

                    Flexible(
                      child: new Container(
                      ),
                      flex: 1,
                    ),

                    Flexible(
                      child: new TextFormField(
                        textAlign: TextAlign.start,
                        autofocus: false,
                        enabled: true,
                        controller: _controller,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      flex: 9,
                    ),

                    Flexible(
                      child: new Container(
                      ),
                      flex: 1,
                    ),

                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: new Container (
                    width: 200,
                    height: 40.0,
                    child: new RaisedButton(onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => OTPUI(_controller.text)),
                      );
                    },
                        child: Text("Get OTP"),
                        textColor: Colors.white,
                        color: _color,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))
                    ),
                  ),
                )
              ]
          )],)
    );
  }

}