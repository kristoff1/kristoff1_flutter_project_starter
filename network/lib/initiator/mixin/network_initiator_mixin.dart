import 'package:flutter/material.dart';
import 'package:network/initiator/network_initiator.dart';

import 'dart:developer' as developer;

///ONLY IF YOU'RE GOING TO USE DI PACKAGE
///DELETE IF NOT
mixin NetworkInitiatorMixin<T extends StatefulWidget> on State<T> {

  @override
  void initState() {
    super.initState();
    _initiateDatabase();
  }

  void _initiateDatabase() {
    NetworkInitiator initiator = NetworkInitiator();
    initiator.initiateNetwork();
    developer.log('Database Initiated');
  }
}