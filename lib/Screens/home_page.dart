import 'package:socket_io_client/socket_io_client.dart' as Io;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FocusNode focusNode = FocusNode();
  bool show = false;
  late Io.Socket socket;

  @override
  void initState() {
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    super.initState();
  }

  void connect() {
    try {
      socket = Io.io("ws://192.168.43.120:5000", <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });
      socket.connect();
      socket.emit('/test', 'hello wold');
      socket.onConnect((data) => print("Connected"));
      print(socket.connected);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onChanged: (value){
                  print('dddddd$value');

                },
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                print('helllo wold');
              },
              child: const Text('Send Msg'))
        ],
      ),
    );
  }
}
