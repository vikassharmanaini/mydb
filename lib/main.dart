import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydb/app.dart';
import 'package:mydb/drivers/register_drivers.dart';
import 'package:mydb/utils/app_logging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppLogging();
  registerDrivers();
  runApp(
    const ProviderScope(
      child: DBStudioApp(),
    ),
  );
}
