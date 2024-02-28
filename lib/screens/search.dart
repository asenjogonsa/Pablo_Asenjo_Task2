import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';
import 'package:task2/connection/ssh.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  SSH ssh = SSH();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/space.png"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Center(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.black),
                          height: 50,
                          width: 180,
                          child: Row(
                            children: [

                              const SizedBox(
                                width: 8,

                              ),
                              Text(
                                  'Pablo Asenjo - Spain',
                                  style: TextStyle(color: Colors.white )
                              )
                            ],
                          ))),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      width: double.infinity,
                      height: 200,
                      // color: Colors.grey,

                      child: Expanded(
                          child: Row(
                            // This next line does the trick.
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
//**************************************************************************************************************** Begin row reboot button
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Color.fromARGB(50, 255, 3255, 255),
                                    ),
                                    child: Center(
                                        child: TextButton(
                                          child: Text(
                                            'Reboot LG',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => showAlertDialog(context, 1,"Are you sure you want to Reboot LG?" ),
                                          /* async {
                                    await ssh.rebootLG();*/
                                          //},
                                        )),
                                  ),
                                ),
//****************************************************************************************************************       relaunch button
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                      const Color.fromARGB(50, 255, 3255, 255),

                                    ),
                                    child: Center(
                                      child: Expanded(
                                          child: TextButton(
                                            child: const Text(
                                              'Relaunch LG',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () => showAlertDialog(context, 2, "Are you sure you want to relaunch LG?"),
                                            /*async {
                                      await ssh.relaunchLG();
                                    },*/
                                          )),
                                    ),
                                  ),
                                ),
//****************************************************************************************************************  Clear KMLS
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                      const Color.fromARGB(50, 255, 3255, 255),
                                    ),
                                    child: Center(
                                      child: Expanded(
                                          child: TextButton(
                                            child: const Text(
                                              'Clear All KML',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              SSH ssh = SSH();
                                              await ssh.connectToLG();
                                              SSHSession? result = await ssh.ClearKML();

                                            },
                                          )),
                                    ),
                                  ),
                                ),
//****************************************************************************************************************    pin madridbutton
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                      const Color.fromARGB(50, 255, 3255, 255),

                                    ),
                                    child: Center(
                                      child: Expanded(
                                          child: TextButton(
                                            child: const Text(
                                              'Shutdown',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () => showAlertDialog(context, 3, "Are you sure you want to Shutdown LG?"),
                                            /*async {
                                      await ssh.relaunchLG();
                                    },*/
                                          )),
                                    ),
                                  ),
                                ),




                              ]))),

                  Container(
                      width: double.infinity,
                      height: 200,
                      // color: Colors.grey,

                      child: Expanded(
                          child: Row(
                            // This next line does the trick.
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                      const Color.fromARGB(50, 255, 3255, 255),
                                    ),
                                    child: Center(
                                      child: Expanded(
                                          child: TextButton(
                                            child: const Text(
                                              'Orbit to Madrid',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              SSH ssh = SSH();
                                              await ssh.connectToLG();
                                              SSHSession? result = await ssh.MadridLG();

                                            },
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                      const Color.fromARGB(50, 255, 3255, 255),
                                    ),
                                    child: Center(
                                      child: Expanded(
                                          child: TextButton(
                                            child: const Text(
                                              'Bubble Render',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              SSH ssh = SSH();
                                              await ssh.connectToLG();
                                              SSHSession? result = await ssh.BurbujaRender();

                                            },
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color:
                                      const Color.fromARGB(50, 255, 3255, 255),
                                    ),
                                    child: Center(
                                      child: Expanded(
                                          child: TextButton(
                                            child: const Text(
                                              'Bubble HTML',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              SSH ssh = SSH();
                                              await ssh.connectToLG();
                                              SSHSession? result = await ssh.BurbujaHTML();

                                            },
                                          )),
                                    ),
                                  ),
                                ),




                              ])))


                ]))));
  }
}

showAlertDialog(BuildContext context, int ind, String text) {
  SSH ssh = SSH();
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      Navigator.of(context).pop();
      String text;
      if (ind == 1) {
        ssh.rebootLG();

      }
      if (ind == 2) {
        ssh.relaunchLG();

      }
      if (ind == 3) {

        ssh.shutdownLG();

      }
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Confirmation"),

    content: Text(("$text")),

    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}