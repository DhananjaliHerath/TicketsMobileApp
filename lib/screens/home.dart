import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ticketapp/module/ticketResponse.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});





  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

//  List<TicketResponse> ticketList = [];
List<Body> ticketList = [];


  // getAllTickets () async {
  // var body= {};
 
  //     var response = await http.get(
  //     Uri.parse("http://localhost:8080/tickets"),
  //     headers: {"Content-Type": "application/json"},
      
  //   );
       
   

  //   setState(() {
      
  //   });

  // }
  //  print("User JWT: ${authResponse?.body.jwt}");
  getAllTickets() async {
  var url = Uri.parse("http://localhost:8080/tickets");
  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer"+"eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBjY21zLmNvbSIsImV4cCI6MTY5MDMxMTg0MSwiaWF0IjoxNjkwMjc1ODQxfQ.P8r2gOeGM2BMDvTQ6HuOlIetyYL4v2KTWrjVNnHq_Tg",
    },
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    var jsonData = json.decode(response.body);
    var ticketResponse = ticketResponseFromJson(jsonData);

    setState(() {
      // Assuming this is the StatefulWidget's setState method
      ticketList = ticketResponse.body;
    });
    
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
    return const Placeholder();
  }
}