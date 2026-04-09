import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Application support subdirectory for DBStudio files (`…/dbstudio/`).
Future<Directory> dbStudioSupportDirectory() async {
  final Directory base = await getApplicationSupportDirectory();
  final Directory dir = Directory(p.join(base.path, 'dbstudio'));
  await dir.create(recursive: true);
  return dir;
}

/// Writes [content] to [target] atomically (temp file + rename).
Future<void> writeStringAtomic(File target, String content) async {
  await target.parent.create(recursive: true);
  final String dir = target.parent.path;
  final String name = p.basename(target.path);
  final File tmp = File(p.join(dir, '.$name.tmp'));
  await tmp.writeAsString(content, flush: true);
  if (await target.exists()) {
    await target.delete();
  }
  await tmp.rename(target.path);
}
