import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Logger? _logger;

Logger get appLog => _logger ?? Logger();

/// Console + daily log file under application support / dbstudio / logs.
Future<void> initAppLogging() async {
  final support = await getApplicationSupportDirectory();
  final logDir = Directory(p.join(support.path, 'dbstudio', 'logs'));
  await logDir.create(recursive: true);
  final day = DateTime.now().toUtc().toIso8601String().split('T').first;
  final file = File(p.join(logDir.path, 'dbstudio_$day.log'));

  _logger = Logger(
    filter: kReleaseMode ? ProductionFilter() : DevelopmentFilter(),
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
    output: MultiOutput(<LogOutput>[
      ConsoleOutput(),
      _FileLogOutput(file),
    ]),
  );

  _logger!.i('Logging initialized: ${file.path}');
}

final class _FileLogOutput extends LogOutput {
  _FileLogOutput(this._file);

  final File _file;

  @override
  void output(OutputEvent event) {
    _file.writeAsStringSync(
      '${event.lines.join('\n')}\n',
      mode: FileMode.append,
      flush: true,
    );
  }
}
