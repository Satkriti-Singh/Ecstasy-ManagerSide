import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class AddProduct extends StatefulWidget{
  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends State<AddProduct>{
String name,company,description,type,gender,size;
int price,quantity;

List<DropdownMenuItem<String>> items_size = [DropdownMenuItem(child: Text('S'),value: 'Small',),DropdownMenuItem(child: Text('M'),value: 'Medium'),DropdownMenuItem(child: Text('L'),value: 'Large',)];
List<DropdownMenuItem<String>> items_type = [DropdownMenuItem(child: Text('Shirt'),value: 'Shirt',),DropdownMenuItem(child: Text('Dress'),value: 'Dress'),DropdownMenuItem(child: Text('Formal'),value: 'Formal',),DropdownMenuItem(child: Text('Informal'),value: 'Informal'),DropdownMenuItem(child: Text('Jeans'),value: 'Jeans'),DropdownMenuItem(child: Text('Accessories'),value: 'Accessories',),DropdownMenuItem(child: Text('Shoes'),value: 'Shoes')];
List<DropdownMenuItem<String>> items_gender = [DropdownMenuItem(child: Text('Male'),value: 'Male',),DropdownMenuItem(child: Text('Female'),value: 'Female'),DropdownMenuItem(child: Text('Other'),value: 'Other')];
GlobalKey<FormState> _key = new GlobalKey();
bool autovalidate = false;

  @override
  Widget build(BuildContext context){
     return Scaffold(
        appBar: new AppBar(
          title: Text('Add new product'),
        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25.0),
            child: Form(
              key: _key,
              autovalidate: autovalidate,
              child:  formUI(),
            ),
          ),
        ),
    );
  }


  Widget formUI(){
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Flexible(
              child:  TextFormField(
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder()
          ),
          maxLength: 20,
          validator: validateName,
          onSaved: (val){
            name=val;
          },
        ),
            )
          ],
        ),
        new SizedBox(
          height: 20.0,
        ),
      
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Brand',
            border: OutlineInputBorder()
          ),
          maxLength: 20,
          validator: validateCompany,
          onSaved: (val){
            company=val;
          },
        ),

        DropdownButtonHideUnderline(
          child:DropdownButton(
          items: items_gender,
          hint: Text('Gender'),
          value: gender,
          onChanged: (val){
            gender=val;
          },
        ), 
        ),
        new SizedBox(
          height: 20.0,
        ),
         DropdownButtonHideUnderline(
          child:DropdownButton(
          items: items_size,
          hint: Text('Size'),
          value: size,
          onChanged: (val){
            size=val;
          },
        ), 
        ),
        new SizedBox(
          height: 20.0,
          ),
        TextFormField(
           maxLength: 100,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder()
          ),
          validator: validateDescription,
          onSaved: (val){
            description=val;
          },
        ),

        new SizedBox(
          height: 20.0,
        ),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder()
          ),
          maxLength: 10,
          keyboardType: TextInputType.number,
          validator: validatePrice,
          onSaved: (val){
            price=int.parse(val);
          },
        ),
        new SizedBox(
          height: 20.0,
        ),
        DropdownButtonHideUnderline(
          child:DropdownButton(
          items: items_type,
          hint: Text('Type'),
          value: type,
          onChanged: (val){
            type=val;
          },
        ), 
        ),
        new SizedBox(
          height: 20.0,
        ),
      
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Quantity Available',
            border: OutlineInputBorder()
          ),
          maxLength: 5,
          keyboardType: TextInputType.number,
          validator: validateQuantity,
          onSaved: (val){
            quantity=int.parse(val);
          },
        ),
        
        
        Center(
          child: RaisedButton(onPressed: sendToServer,child: Text('Add product'),color: Colors.lightBlueAccent,textColor: Colors.white,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),),
          )
      ],
    );
  }

  sendToServer(){
  if(_key.currentState.validate()){
    _key.currentState.save();
    DatabaseReference ref =FirebaseDatabase.instance.reference();
    var data={
      "name":name,
      "company":company,
      "description":description,
      "gender":gender,
      "price":price,
      "quantity":quantity,
      "type":type,
      "size":size
    };
    ref.child('product').push().set(data).then((v){
      _key.currentState.reset();
    });
    Navigator.of(context).pop();
    } 
  else{
    setState(() {
     autovalidate=true; 
    });
  }
  }    
  String validateName(String val){
    return val.length == 0 ? "Enter the name of the product" : null;
    }
       String validateCompany(String val){
        return val.length == 0 ? "Enter the company of the product" : null;
      }
       String validateDescription(String val){
        return val.length == 0 ? "Enter the description of the product" : null;
      }
      String validatePrice(String value){
        if(value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if(n == null) {
    return 'Enter valid price of the product';
    }
    return null;
    }
    String validateQuantity(String value){
        if(value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if(n == null) {
    return 'Enter valid quantity of the product';
    }
    return null;
    }
}