import 'package:flutter/material.dart';
import 'package:task2/components/connection_flag.dart';

import 'package:task2/connection/ssh.dart';
import 'package:task2/screens/connect.dart';
import 'package:task2/screens/search.dart';
import 'package:task2/utils/constants.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
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
    rebuildAllChildren(context); //to refresh connection status flag more often
    return Scaffold(
      appBar: AppBar(
          title: const Text('Liquid Galaxy Task 2', //Bar on top text at the left

              style: TextStyle(color: Colors.white60)),
          backgroundColor: Colors.black,

          actions: <Widget>[ConnectionFlag(connectionStatus: connection), // the Flag (green or red) for connection status


            PopupMenuButton( //menu popup to connect three dots at the bar right
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text('Connect',   //connection button
                  style: TextStyle(color: Colors.black, fontSize: 22)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ConnectScreen(), //Render the Connect screen
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
      body: const SearchScreen(),
    );
  }

  void rebuildAllChildren(BuildContext context) { //refresher for connection status flag
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }
}
