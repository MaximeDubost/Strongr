import 'package:flutter/material.dart';
import 'package:strongr/services/connection_service.dart';

class WaitingForConnection extends StatefulWidget {
  final String connectId;
  final String password;

  WaitingForConnection({
    @required this.connectId,
    @required this.password,
  });

  @override
  _WaitingForConnectionState createState() => _WaitingForConnectionState();
}

class _WaitingForConnectionState extends State<WaitingForConnection> {
  Future<int> futureLogIn;

  @override
  void initState() {
    futureLogIn = ConnectionService.postLogIn(
        connectId: widget.connectId, password: widget.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
