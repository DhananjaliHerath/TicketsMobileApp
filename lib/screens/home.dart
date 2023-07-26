import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ticketapp/module/ticketResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static getInstance() {}
}

class _HomeState extends State<Home> {
  String? jwtToken;

  List<Body> ticketList = [];

  
  getAllTickets() async {
    var url = Uri.parse("http://localhost:8080/tickets");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwtToken = prefs.getString('jwtToken');
   ;

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      var jsonData = json.decode(response.body);
      var ticketResponse = ticketResponseFromJson(response.body);


      setState(() {
        // Assuming this is the StatefulWidget's setState method
        ticketList = ticketResponse.body;
     
      });
         print("ticketlist:"  + ticketList.toString());
    } else {
      // If the server did not return a 200 OK response, throw an error.
      throw Exception('Failed to load tickets');
    }
  }

  @override
  void initState() {
    getAllTickets();
    super.initState();
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket List'),
      ),
      body: Container(
        height: 500,
        child: ListView.builder(
          itemCount: ticketList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(ticketList[index].title ?? ''),
              subtitle: Text(ticketList[index].description),
            );
          },
        ),
      ),
    );
  }
}
