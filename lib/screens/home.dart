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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwtToken = prefs.getString('jwtToken');
    // String token = jwtToken;
    // String token =
    //     'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbkBjY21zLmNvbSIsImV4cCI6MTY5MDMxMTg0MSwiaWF0IjoxNjkwMjc1ODQxfQ.P8r2gOeGM2BMDvTQ6HuOlIetyYL4v2KTWrjVNnHq_Tg';

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
  return Scaffold(
      appBar: AppBar(
        title: Text('Rays Tickets'),
      ),
      body: ListView.builder(
     
        itemBuilder: (context, index) {
        
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              color: Color.fromARGB(255, 255, 255, 255), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), 
                side: BorderSide(
                  color: Colors.grey, 
                  width: 0.5, 
                ),
              ),
              child: ListTile(
                title: Text(
                  'User Name: ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, 
                    color: const Color.fromARGB(255, 33, 184, 243), 
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date:',
                      style: TextStyle(
                        fontSize: 16,
                       
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Reason: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold, 
                        color: const Color.fromARGB(255, 0, 0, 0), 
                    ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
