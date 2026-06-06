import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  timeago.setLocaleMessages('id', timeago.IdMessages());
  runApp(
    const ProviderScope(
      child: RenbokApp(),
    ),
  );
}
