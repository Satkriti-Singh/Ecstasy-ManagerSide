import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class Hello extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Manager App",
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                "Events Manager",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
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
            body: ListRow()));
  }
}

class ListRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: StreamBuilder(
                stream: Firestore.instance.collection('bandnames').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text('Loading...'));
                  return ListView.builder(
                      itemExtent: 80.0,
                      itemCount: snapshot.data.documents.length,
                      padding: new EdgeInsets.symmetric(vertical: 4.0),
                      itemBuilder: (context, index) => _buildListItemCard(
                          context, snapshot.data.documents[index]));
                })),
        RaisedButton(
          padding: EdgeInsets.all(13.0),
          onPressed: () => debugPrint("Hello"),
//                color: Colors.grey[350],fl
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
            left: Radius.circular(80.0),
            right: Radius.circular(80.0),
          )),
          //disabledColor: Colors.pink,
          elevation: 2.0,
          child: Text(
            "Add Event",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Text(
          "COMPLETED EVENTS",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        Expanded(
            child: StreamBuilder(
                stream: Firestore.instance.collection('bandnames').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: Text('Loading...'));
                  return ListView.builder(
                      itemExtent: 80.0,
                      itemCount: snapshot.data.documents.length,
                      padding: new EdgeInsets.symmetric(vertical: 4.0),
                      itemBuilder: (context, index) => _buildListItemCard(
                          context, snapshot.data.documents[index]));
                })),
      ],
    );
  }

  Widget _buildListItemCard(BuildContext context, DocumentSnapshot document) {
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 4.0,
        ),
        child: new Stack(
          children: <Widget>[
            new Container(
                margin: new EdgeInsets.only(left: 30.0, right: 30.0),
                decoration: new BoxDecoration(
                  color: new Color(0xFF333366),
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      offset: new Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: new Column(children: <Widget>[
                  new Card(
                      margin: EdgeInsets.all(0.0),
                      elevation: 2.0,
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new ListTile(
                              title: new Text(
                                document['name'],
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: new Text(document['votes'].toString()),
                            )
                          ])),
                ])),
          ],
        ));
  }
}
