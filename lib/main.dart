import 'package:flutter/material.dart';

import 'database_helper.dart';
// change `flutter_database` to whatever your project name is
//import 'package:flutter_database/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',      
      theme: ThemeData(
        primarySwatch: Colors.cyan,        
      ),
      home: MyHomePage(        
      ),      
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text('SQFLite',
        style: TextStyle(fontSize: 25,color: Colors.white),
        ),
      
        centerTitle: true,
       leading: new Icon(Icons.people,
       color: Colors.white),
      ),
      body: Center(
        child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            ClipRRect(
               child:Image.network(
                 'https://img.icons8.com/bubbles/2x/work.png',
                 width: 200,
                 height: 200,
                 fit: BoxFit.cover,
                 ),
            ),
          Padding(padding: EdgeInsets.only(top: 50)),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
            Column(
              children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
              color: Colors.teal[100],
            ),]
            ),
            
          
          Column(
              children: <Widget>[
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
              color: Colors.teal[100],
            ),          
          ]
          )
          ]
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
            Column(
              children: <Widget>[
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
              color: Colors.teal[100],
            ),]
            ),
            Column(
              children: <Widget>[
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
              color: Colors.teal[100],
            ),
             ]
          )
          ]
        ),
        Padding(padding: EdgeInsets.only(bottom: 90)),


          ],
        ),
      ),
      ),
    );
  }
  
  // Button onPressed methods
  
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Wendi',
      DatabaseHelper.columnAge  : 20
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Nengah',
      DatabaseHelper.columnAge  : 19
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}