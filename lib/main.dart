import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainScreen(),
  ));
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Map<String, dynamic> map;

  Future<String> getData() async {
    var response = await http
    //https://jsonplaceholder.typicode.com/posts
        .get("http://localhost:3000/api/random-number",
            //this is just in case you have an authentication to use the API
            headers: {"Accept": "application/json"});

    this.setState(() {
      map = json.decode(response.body);
    });
    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Getting Data from API"),
      ),
      body: ListView.builder(
        itemCount: map == null ? 0 : map.length,
        itemBuilder: (BuildContext context, int index) {
          List<dynamic> data = map["dataKey2"];
          print(data[0]["key1"]);
          return Card(
            child: Text(
              //data[index]["title"],
              data[0]["key3"],
            ),
          );
        },
      ),
    );
  }
}