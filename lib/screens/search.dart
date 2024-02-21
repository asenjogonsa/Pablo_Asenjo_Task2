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
                                    'REBOOT LG',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    await ssh.rebootLG();
                                  },
                                )),
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
                                      'RELAUNCH LG',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      await ssh.relaunchLG();
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
                                          'Pin Madrid',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          SSH ssh = SSH();
                                          await ssh.connectToLG();
                                          SSHSession? result = await ssh.searchplace("madrid");

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
                                              'Orbit to Madrid',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              SSH ssh = SSH();
                                              await ssh.connectToLG();
                                              SSHSession? result = await ssh.MadridLG("madrid");

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
                                              'Burbuja',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              SSH ssh = SSH();
                                              await ssh.connectToLG();
                                              SSHSession? result = await ssh.Burbuja();

                                            },
                                          )),
                                    ),
                                  ),
                                ),


                          ])))
                ]))));
  }
}
