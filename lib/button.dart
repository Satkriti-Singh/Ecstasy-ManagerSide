import "package:flutter/material.dart";
import 'package:ecstasy/main_page_men.dart';
import 'package:ecstasy/main_page_women.dart';
import 'package:ecstasy/main_page_other.dart';


class ShowButtonPage extends StatefulWidget{
  @override
  ShowButtonPageState createState() => ShowButtonPageState();
}
class ShowButtonPageState extends State<ShowButtonPage>{
 
  @override
  Widget build(BuildContext context){
return Scaffold(
  appBar: new AppBar(
    title: new Text("Choose Gender"),
  ),
  body:Container(
    margin: EdgeInsets.only(top: 50.0),
    child: 
  Center(
    child: 
  Column(
    children: <Widget>[
      Container(
        margin: EdgeInsets.all(20.0),
        child: RaisedButton(onPressed: sendToMen,child: Text('Men'),color: Colors.lightBlueAccent,textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
      ),
       Container(
        margin: EdgeInsets.all(20.0),
        child: RaisedButton(onPressed: sendToWomen,child: Text('Women'),color: Colors.lightBlueAccent,textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
      ),
       Container(
        margin: EdgeInsets.all(20.0),
        child: RaisedButton(onPressed: sendToOther,child: Text('Other'),color: Colors.lightBlueAccent,textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
      ),  
    ],

    )
      
  )
 ) );
  }

  void sendToMen(){
  Navigator.push(context, MaterialPageRoute(builder:(context) => new ShowMenPage() ));
  }

  void sendToWomen(){
  Navigator.push(context, MaterialPageRoute(builder:(context) => new ShowWomenPage() ));
  }

  void sendToOther(){
  Navigator.push(context, MaterialPageRoute(builder:(context) => new ShowOtherPage() ));
  }


}



