import 'package:flutter/material.dart';
import 'package:task2/components/connection_flag.dart';

import 'package:task2/connection/ssh.dart';
import 'package:task2/screens/connect.dart';
import 'package:task2/screens/help_screen.dart';
import 'package:task2/screens/search.dart';
import 'package:task2/utils/constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late SSH ssh;

  @override
  void initState() {
    super.initState();
    ssh = SSH();
    _connectToLG();
  }

  Future<void> _connectToLG() async {
    bool? result = await ssh.connectToLG();
    setState(() {
      connection = result!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Liquid Galaxy task 2 Controller',
              style: TextStyle(color: Colors.white60)),
          backgroundColor: Colors.black,
          actions: <Widget>[
            ConnectionFlag(connectionStatus: connection),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Connect'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConnectScreen(),
                      ),
                    );
                    setState(() {
                      _connectToLG();
                    });
                  },
                ),
              ],
            ),
          ]),
      body: SearchScreen(),
    );
  }
}
