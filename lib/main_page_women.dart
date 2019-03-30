import "package:flutter/material.dart";
import 'package:ecstasy/class/products.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ecstasy/addProduct.dart';


class ShowWomenPage extends StatefulWidget{
  @override
  ShowWomenPageState createState() => ShowWomenPageState();
}
class ShowWomenPageState extends State<ShowWomenPage>{
  List<Products> allData = [];

  @override
  void initState(){

    DatabaseReference ref =FirebaseDatabase.instance.reference();
    ref.child('product').once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data =  snap.value;
      allData.clear();
      for(var key in keys){
        if(data[key]['gender']=='Female'){
          allData.add(new Products(key,data[key]['name'], data[key]['company'], data[key]['descrpition'],data[key]['price'], data[key]['gender'],data[key]['quantity'],data[key]['type'],data[key]['size']));
        }
        else{

        }
         }
      setState(() {
      //print('Length: $allData.length'); 
      });
    });
  }

_deleteTodo(String id, int index) {
  FirebaseDatabase.instance.reference().child('product').child(id).remove().then((_) {
  
    print("Delete $id successful");
       Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("$id dismissed")));
 
    setState(() {
      allData.removeAt(index);
    });
  });
}
  @override
  Widget build(BuildContext context){
return Scaffold(
  /*drawer: SizedBox(
                width: 250.0,
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.all(0.0),
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.white12),
                        accountEmail: Text(
                          googleUser.email,
                          style: TextStyle(color: Colors.black),
                        ),
                        accountName: Text(
                          googleUser.displayName,
                          style: TextStyle(color: Colors.black),
                        ),
                        currentAccountPicture: Container(
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(googleUser.photoUrl)),
                        ),
                      ),
                      ListTile(
                        title: Text("Sign Out"),
                        onTap: () {
                          auth.signOut();
                          googleSignIn.signOut();
                          Navigator.pushAndRemoveUntil<void>(
                              context,
                              MaterialPageRoute(builder: (_) => AuthScreen()),
                              (_) => false);
                        },
                      )
                    ],
                  ),
                )),*/
  appBar: new AppBar(
    title: new Text("Ecstasy"),
  ),
  body:Container(
      margin: EdgeInsets.all(20.0),
      child: (allData.length == 0) ? new Center(child: Text('No data is available'),):
      new ListView.builder(
      itemBuilder: (_,index){
         final item = allData[index].name;
        return Dismissible(
         key:Key(item),
          onDismissed: (direction){
            _deleteTodo(allData[index].id, index);
 },
 background: Container(color:Color.fromRGBO(255,219,88, 0.95),
 child: Icon(Icons.delete),
 margin: EdgeInsets.all(5.0),
 ),
          child:  Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
           leading: Container(
          padding: EdgeInsets.only(right: 12.0,top: 10.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.account_circle ,color: Colors.white),
        ),
          title: Text(allData[index].name , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
          subtitle: Text(allData[index].company.toString() , style: TextStyle(color: Colors.white)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //onTap: () => onTapped(allData[index].id,allData[index].name,allData[index].address,allData[index].date,allData[index].age,allData[index].credits,allData[index].gender),
        ),
      ),
    ),
        );
    },
    itemCount: allData.length,
    )
  ),
  

  floatingActionButton: FloatingActionButton(
    backgroundColor: Color.fromRGBO(255,219,88, .85),
    
    child: const Icon(
      Icons.add,
      size: 30.0,
      color: Colors.blueGrey,
    ),
    onPressed: () {
       Navigator.push(context, MaterialPageRoute(builder:(context) => new AddProduct()),);
    },

  ),

  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

  bottomNavigationBar: BottomAppBar(
    child: new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
      
      ],
    ),
    color: Color.fromRGBO(64, 75, 96, .9),
    shape: CircularNotchedRectangle()
    
  ),
  );
  }

void onTapped(String id,String name, String address, String date, String age,int credits,String gender){
 // Navigator.push(context, MaterialPageRoute(builder:(context) => new AddProduct(id: id,name : name,address:address,date:date,age:age,credits:credits,gender: gender)));
  }


}



