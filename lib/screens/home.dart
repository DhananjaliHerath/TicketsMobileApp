
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
// import 'package:stomp_dart_client/stomp_frame.dart';
// import 'package:ticketapp/module/ticketResponse.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ticket App',
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();

//   static getInstance() {}
// }

// class _HomeState extends State<Home> {
//   String? jwtToken;
//   List<Body> ticketList = [];
//   bool isWebSocketConnected = false;
//   StompClient? stompClient;
//   String webSocketMessage = '';

//   getAllTickets() async {
//     var url = Uri.parse("http://localhost:8080/tickets");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     jwtToken = prefs.getString('jwtToken');

//     var response = await http.get(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $jwtToken",
//       },
//     );

//     if (response.statusCode == 200) {
//       var ticketResponse = ticketResponseFromJson(response.body);

//       setState(() {
//         ticketList = ticketResponse.body;
//       });
//       print("ticketlist:" + ticketList.toString());
//     } else {
//       throw Exception('Failed to load tickets');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAllTickets();
//     _connectToWebSocket();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ticket List'),
//       ),
//       body: Container(
//         height: 500,
//         child: ListView.builder(
//           itemCount: ticketList.length + 1, 
//           itemBuilder: (context, index) {
           
//             if (index == 0) {
//               return ListTile(
//                 title: Text('Notification Message'),
//                 subtitle: Text(webSocketMessage),
//               );
//             }

            
//             final ticketIndex = index - 1; 
//             return ListTile(
//               title: Text(ticketList[ticketIndex].title ?? ''),
//               subtitle: Text(ticketList[ticketIndex].description),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _connectToWebSocket() {
//     stompClient = StompClient(
//       config: StompConfig(
//         url: 'ws://localhost:8080/socket',
//         onConnect: (StompFrame frame) async {
//           print('connected');
//           setState(() {
//             isWebSocketConnected = true;
//           });
//           _subscribeToTopic();
//         },
//         onWebSocketError: (dynamic error) => print(error.toString()),
//       ),
//     );
//     stompClient!.activate();
//   }

//   void _subscribeToTopic() {
//     stompClient?.subscribe(
//       destination: '/notifications',
//       headers: {},
//       callback: (StompFrame frame) {
     
//         print("Received message: ${frame.body}");
      
//         setState(() {
//           webSocketMessage = frame.body ?? '';
       
//           var jsonData = json.decode(frame.body ?? '');
//           var newTicket = Body.fromJson(jsonData); 

       
//           ticketList.insert(0, newTicket); 
//         });
//       },
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:ticketapp/module/ticketResponse.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.amber,
        fontFamily: 'Roboto',
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  static getInstance() {}
}

class _HomeState extends State<Home> {
  String? jwtToken;
  List<Content> ticketListPaged = [];
   List<Body> ticketList = [];

  bool isWebSocketConnected = false;
  StompClient? stompClient;
  String webSocketMessage = '';
  PageResponse? pageResponse;

  int currentPage = 1;
  int offset = 10;
           
// getpage function 

  Future<PageResponse> getTicketsPage(int page, int offset) async {
  var url = Uri.parse("http://localhost:8080/tickets/page?page=$page&offset=$offset");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  jwtToken = prefs.getString('jwtToken');

  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwtToken",
    },
  );

  if (response.statusCode == 200) {
    var pageResponse = PageResponse.fromJson(json.decode(response.body));
    return pageResponse;
  } else {
    throw Exception('mukuth naaaaaaaaaaaaaaaaaaaa');
  }
}


void fetchTicketsPage(int page, int offset) async {
  try {
    var pageResponse = await getTicketsPage(page, offset);
    setState(() {
      ticketListPaged = pageResponse.content!;
    });
    print("ticketlist:" + pageResponse.toString());
  } catch (e) {
    print("Error fetching tickets: $e");
  }
}
 void _fetchNextPage() {
    currentPage++;
    fetchTicketsPage(currentPage, offset);
  }

  void _fetchPreviousPage() {
    if (currentPage > 1) {
      currentPage--;
      fetchTicketsPage(currentPage, offset);
    }
  }



  getAllTickets() async {
    var url = Uri.parse("http://localhost:8080/tickets");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jwtToken = prefs.getString('jwtToken');

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwtToken",
      },
    );

    if (response.statusCode == 200) {
      var ticketResponse = ticketResponseFromJson(response.body);

      setState(() {
        ticketList = ticketResponse.body;
      });
      print("ticketlist:" + ticketList.toString());
    } else {
      throw Exception('ticket naaaaaaa');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllTickets();
    _connectToWebSocket();
    int page = 1;
    int offset = 10;
    fetchTicketsPage(page, offset);
    // getTicketsPage(page, offset)

 
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket List',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Notification Message',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              webSocketMessage,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: ticketList.length,
              itemBuilder: (context, index) {
                final ticket = ticketList[index];
                final colorIndex = index % 4;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: _getColor(colorIndex),
                    child: ListTile(
                      title: Text(ticket.title ?? '',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 2, 177, 246))),
                      subtitle: Text(ticket.description),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Color _getColor(int colorIndex) {
    List<Color> colors = [
      Color.fromARGB(255, 202, 205, 206),
    ];

    return colors[colorIndex % colors.length];
  }

  void _connectToWebSocket() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/socket',
        onConnect: (StompFrame frame) async {
          print('connected');
          setState(() {
            isWebSocketConnected = true;
          });
          _subscribeToTopic();
        },
        onWebSocketError: (dynamic error) => print(error.toString()),
      ),
    );
    stompClient!.activate();
  }

  void _subscribeToTopic() {
    stompClient?.subscribe(
      destination: '/notifications',
      headers: {},
      callback: (StompFrame frame) {
        print("Received message: ${frame.body}");

        setState(() {
          webSocketMessage = frame.body ?? '';

          var jsonData = json.decode(frame.body ?? '');
          var newTicket = Body.fromJson(jsonData);

          ticketList.insert(0, newTicket);
        });
      },
    );
  }
}


