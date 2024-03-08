import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class ConnectivityExample extends StatefulWidget {
  const ConnectivityExample({Key? key}) : super(key: key);

  @override
  State<ConnectivityExample> createState() => _ConnectivityExampleState();
}

class _ConnectivityExampleState extends State<ConnectivityExample> {
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((connectivityResult) {});


    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() {
        this.hasInternet = hasInternet;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {

            final result = await Connectivity().checkConnectivity();
            checkConnectivity(result);
          },
          child: Text("Check Connectivity"),
        ),
      ),
    );
  }

  void checkConnectivity(ConnectivityResult result) {

    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? result == ConnectivityResult.mobile
        ? "You Are Connected To Mobile Network"
        : "You Are Connected To WiFi Network"
        : "You Have No Internet";
    final color = hasInternet ? Colors.green : Colors.red;
    showSnackbar(context, message, color);
  }

  void showSnackbar(BuildContext context, String? message, Color color) {
    final snackbar = SnackBar(content: Text(message!), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {

    subscription.cancel();
    internetSubscription.cancel();
    super.dispose();
  }
}
