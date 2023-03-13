import 'package:cache/src/initiator/cache_initiator.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as developer;

///ONLY IF YOU'RE GOING TO USE DI PACKAGE
///DELETE IF NOT
mixin CacheInitiatorMixin<T extends StatefulWidget> on State<T> {

  @override
  void initState() {
    super.initState();
    _initiateCache();
  }

  void _initiateCache() {
    CacheInitiator initiator = CacheInitiator();
    initiator.initiateSharedPreference();
    developer.log('Shared Preferences');
  }

}