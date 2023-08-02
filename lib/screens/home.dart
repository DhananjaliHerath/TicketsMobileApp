

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stomp_dart_client/stomp.dart';
// import 'package:stomp_dart_client/stomp_config.dart';
// import 'package:stomp_dart_client/stomp_frame.dart';
// import 'package:ticketapp/module/pageResponse.dart';
// import 'package:ticketapp/module/ticketResponse.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:fluttertoast/fluttertoast.dart';

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
//   List<Content> ticketListPaged = [];
//   List<Body> ticketList = [];

//   bool isWebSocketConnected = false;
//   StompClient? stompClient;
//   String webSocketMessage = '';
//   PageResponse? pageResponse;

//   int currentPage = 1;
//   int offset = 10;
//   ScrollController _scrollController = ScrollController();

//   List<bool> isLoadingPages = [false]; 

//   Future<PageResponse> getTicketsPage(int page, int offset) async {
//     var url = Uri.parse("http://localhost:8080/tickets/page?page=$page&offset=$offset");
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
//       var pageResponse = PageResponse.fromJson(json.decode(response.body));
//       return pageResponse;
//     } else {
//       throw Exception('mukuth naaaaaaaaaaaaaaaaaaaa');
//     }
//   }

//   Future<void> fetchTicketsPage(int page, int offset) async {
//     try {
     
//       setState(() {
//         if (isLoadingPages.length < page) {
//           isLoadingPages.add(true);
//         } else {
//           isLoadingPages[page - 1] = true;
//         }
//       });

//       var pageResponse = await getTicketsPage(page, offset);
//       setState(() {
//         ticketListPaged = pageResponse.content!;
//       });

      
//       setState(() {
//         isLoadingPages[page - 1] = false;
//       });

//       print("ticketlist:" + pageResponse.toString());
//     } catch (e) {
//       print("Error fetching tickets: $e");
    
//       setState(() {
//         isLoadingPages[page - 1] = false;
//       });
//     }
//   }

//   void _fetchNextPage() {
//     currentPage++;
//     fetchTicketsPage(currentPage, offset);
//   }

//   void _fetchPreviousPage() async {
//     if (currentPage > 1) {
//       currentPage--;
//       await fetchTicketsPage(currentPage, offset);
//     }
//   }

 

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
//       throw Exception('ticket naaaaaaa');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAllTickets();
//     _connectToWebSocket();
//     int page = 1;
//     int offset = 10;
//     fetchTicketsPage(page, offset);

//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//       _fetchNextPage();
//     } else if (_scrollController.position.pixels == 0) {
//       _fetchPreviousPage();
//     }
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
//           controller: _scrollController,
//           itemCount: ticketListPaged.length + 1,
//           itemBuilder: (context, index) {
//             if (index == 0) {
//               return ListTile(
//                 title: Text('Notification Message'),
//                 subtitle: Text(webSocketMessage),
//               );
//             }

//             final ticketIndex = index - 1;
//             return ListTile(
//               title: Text(ticketListPaged[ticketIndex].title ?? ''),
//               subtitle: Text(ticketListPaged[ticketIndex].description ?? ''),
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
import 'package:ticketapp/module/pageResponse.dart';
import 'package:ticketapp/module/ticketResponse.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
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
  ScrollController _scrollController = ScrollController();

  List<bool> isLoadingPages = [false];
  bool isLoadingPage = false;

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

  Future<void> fetchTicketsPage(int page, int offset) async {
    try {
      setState(() {
        isLoadingPage = true;
        if (isLoadingPages.length < page) {
          isLoadingPages.add(true);
        } else {
          isLoadingPages[page - 1] = true;
        }
      });

      var pageResponse = await getTicketsPage(page, offset);
      setState(() {
        ticketListPaged = pageResponse.content!;
      });

      setState(() {
        isLoadingPage = false;
        isLoadingPages[page - 1] = false;
      });

      print("ticketlist:" + pageResponse.toString());
    } catch (e) {
      print("Error fetching tickets: $e");

      setState(() {
        isLoadingPage = false;
        isLoadingPages[page - 1] = false;
      });
    }
  }

  void _fetchNextPage() {
    currentPage++;
    fetchTicketsPage(currentPage, offset);
  }

  void _fetchPreviousPage() async {
    if (currentPage > 1) {
      currentPage--;
      await fetchTicketsPage(currentPage, offset);
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

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchNextPage();
    } else if (_scrollController.position.pixels == 0) {
      _fetchPreviousPage();
    }
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
          controller: _scrollController,
          itemCount: ticketListPaged.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Text('Notification Message'),
                subtitle: Text(webSocketMessage),
              );
            }

            final ticketIndex = index - 1;
            return ListTile(
              title: Text(ticketListPaged[ticketIndex].title ?? ''),
              subtitle: Text(ticketListPaged[ticketIndex].description ?? ''),
            );
          },
        ),
      ),
      bottomNavigationBar: isLoadingPage
          ? BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(), // Or any other loading widget
                ),
              ),
            )
          : null,
    );
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
