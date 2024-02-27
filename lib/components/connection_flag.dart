import 'package:flutter/material.dart';

class ConnectionFlag extends StatelessWidget {
  bool connectionStatus;
  ConnectionFlag({required this.connectionStatus});

  @override
  Widget build(BuildContext context) {
    Color color = connectionStatus ? Colors.green : Colors.red;
    String label = connectionStatus ? 'CONNECTED' : 'DISCONNECTED';
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: color,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
