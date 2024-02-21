import 'dart:async';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSH {
  late String _host;
  late String _port;
  late String _username;
  late String _passwordOrKey;
  late String _numberOfRigs;
  SSHClient? _client;

  final String _url = 'http://lg1:81';


  Future<void> initConnection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('ipAddress') ?? '192.168.201.3';
    _port = prefs.getString('sshPort') ?? '22';
    _username = prefs.getString('username') ?? 'lg';
    _passwordOrKey = prefs.getString('password') ?? '1234';
    _numberOfRigs = prefs.getString('numberOfRigs') ?? '3';
  }

  Future<bool?> connectToLG() async {
    await initConnection();

    try {
      final socket = await SSHSocket.connect(_host, int.parse(_port));
      _client = SSHClient(
        socket,
        username: _username,
        onPasswordRequest: () => _passwordOrKey,
      );
      if (kDebugMode) {
        print(
            'IP: $_host, port: $_port, username: $_username, noOfRigs: $_numberOfRigs');
      }
      return true;
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Failed to connect: $e');
      }
      return false;
    }
  }

  Future<SSHSession?> searchplace(String place) async {
    try {
      if (_client == null) {
        if (kDebugMode) {
          print('SSH client is not initialized.');
        }
        return null;
      }

      final execResult =
          await _client!.execute('echo "search=$place" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while executing the command: $e');
      }
      return null;
    }
  }
/*
  Future<void> sendTour(String tourKml, String tourName) async {
    final fileName = '$tourName.kml';

    final kmlFile = await _fileService.createFile(fileName, tourKml);
    await _sshService.upload(kmlFile.path);

    await _sshService
        .execute('echo "\n$_url/$fileName" >> /var/www/html/kmls.txt');
  }


 */


  Future<SSHSession?> MadridLG(String place) async {
    try {
      if (_client == null) {
        if (kDebugMode) {
          print('SSH client is not initialized.');
        }
        return null;
      }
      // Define coordinates for Spain
      final longitude = -3.7;
      final latitude = 40.4;

      // Define other parameters (optional)
      final altitude = 1000; // meters
      final range = 10000; // meters
      final tilt = 0; // degrees
      final heading = 0; // degrees
      final altitudeMode = 'relativeToGround';

      final execResult =
      await _client!.execute('echo "flytoview=<LookAt><longitude>$longitude</longitude><latitude>$latitude</latitude><altitude>$altitude</altitude><range>$range</range><tilt>$tilt</tilt><heading>$heading</heading><gx:altitudeMode>$altitudeMode</gx:altitudeMode></LookAt>" >/tmp/query.txt');
      return execResult;
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while executing the command: $e');
      }
      return null;
    }
  }

  Future<SSHSession?> Burbuja() async {
    try {
      if (_client == null) {
        if (kDebugMode) {
          print('SSH client is not initialized.');
        }
        return null;
      }

      final execResult =
      //await SSHClient.upload("hola.txt");
      await _client!.execute('''cat > /var/www/html/prueba30.kml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
     xmlns:gx="http://www.google.com/kml/ext/2.2">

  <Document>
    <Placemark id="pablo_asenjo">
      <name>Pablo Asenjo</name>
      <description>Spain</description>
      <gx:balloonVisibility>1</gx:balloonVisibility>
      <ScreenOverlay>
        <name>Overlay</name>
        <description>Overlay to position the view</description>
        <Icon>
          <href>https://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png</href>
        </Icon>
        <overlayXY x="1.0" y="0.0" xunits="fraction" yunits="fraction"/>
        <screenXY x="0.95" y="0.95" xunits="fraction" yunits="fraction"/>
        <rotation>0</rotation>
      </ScreenOverlay>
    </Placemark>
  </Document>
</kml>
''');




      await _client!.execute('echo "\n$_url/prueba30.kml" >> /var/www/html/kmls.txt');
          return execResult;
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred while executing the command: $e');
      }
      return null;
    }
  }

  Future<void> shutdownLG() async {
    try {
      await connectToLG();
      for (var i = int.parse(_numberOfRigs); i >= 0; i--) {
        await _client?.run(
            'sshpass -p ${_passwordOrKey} ssh -t lg$i "echo ${_passwordOrKey} | sudo -S poweroff"');
        print(i);
      }
    } catch (e) {
      print('Error in shut down: $e');
    }
  }

  Future<void> rebootLG() async {
    try {
      await connectToLG();

      for (var i = int.parse(_numberOfRigs); i >= 0; i--) {
        await _client?.run(
            'sshpass -p $_passwordOrKey ssh -t lg$i "echo $_passwordOrKey | sudo -S reboot"');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> relaunchLG() async {
    try {
      await connectToLG();
      for (var i = 1; i <= int.parse(_numberOfRigs); i++) {
        await connectToLG();
        String cmd = """RELAUNCH_CMD="\\
          if [ -f /etc/init/lxdm.conf ]; then
            export SERVICE=lxdm
          elif [ -f /etc/init/lightdm.conf ]; then
            export SERVICE=lightdm
          else
            exit 1
          fi
          if  [[ \\\$(service \\\$SERVICE status) =~ 'stop' ]]; then
            echo ${_passwordOrKey} | sudo -S service \\\${SERVICE} start
          else
            echo ${_passwordOrKey} | sudo -S service \\\${SERVICE} restart
          fi
          " && sshpass -p ${_passwordOrKey} ssh -x -t lg@lg$i "\$RELAUNCH_CMD\"""";
        await _client?.run(
            '"/home/${_username}/bin/lg-relaunch" > /home/${_username}/log.txt');
        await _client?.run(cmd);
      }
    } catch (e) {
      print(e);
    }
  }







  Future<void> refresh() async {
    await connectToLG();
    try {
      const search = '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href>';
      const replace =
          '<href>##LG_PHPIFACE##kml\\/slave_{{slave}}.kml<\\/href><refreshMode>onInterval<\\/refreshMode><refreshInterval>2<\\/refreshInterval>';
      final command =
          'echo ${_passwordOrKey} | sudo -S sed -i "s/$search/$replace/" ~/earth/kml/slave/myplaces.kml';

      final clear =
          'echo ${_passwordOrKey} | sudo -S sed -i "s/$replace/$search/" ~/earth/kml/slave/myplaces.kml';
      await connectToLG();
      for (var i = 2; i <= int.parse(_numberOfRigs); i++) {
        final clearCmd = clear.replaceAll('{{slave}}', i.toString());
        final cmd = command.replaceAll('{{slave}}', i.toString());
        String query = 'sshpass -p $_passwordOrKey} ssh -t lg$i \'{{cmd}}\'';

        await _client?.execute(query.replaceAll('{{cmd}}', clearCmd));
        await _client?.execute(query.replaceAll('{{cmd}}', cmd));
      }
    } catch (e) {
      print(e);
    }
  }
}
