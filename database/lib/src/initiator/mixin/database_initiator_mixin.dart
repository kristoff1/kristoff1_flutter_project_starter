import 'package:database/database.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as developer;

///ONLY IF YOU'RE GOING TO USE DI PACKAGE
///DELETE IF NOT
mixin DatabaseInitiatorMixin<T extends StatefulWidget> on State<T> {

  @override
  void initState() {
    super.initState();
    _initiateDatabase();
  }

  void _initiateDatabase() {
    DatabaseInitiator initiator = DatabaseInitiator();
    initiator.initiateDatabase();
    developer.log('Database Initiated');
  }



}