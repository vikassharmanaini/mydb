import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/models/schema_metadata.dart';
import 'package:mydb/services/schema_meta_cache.dart';

void main() {
  test('clear removes connection data', () {
    final SchemaMetaCache c = SchemaMetaCache();
    const String id = 'c1';
    c.putSchemas(id, <SchemaInfo>[const SchemaInfo(name: 'public')]);
    expect(c.getSchemas(id), isNotNull);
    c.clear(id);
    expect(c.getSchemas(id), isNull);
  });
}
