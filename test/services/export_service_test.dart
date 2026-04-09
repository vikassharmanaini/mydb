import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/models/result_page.dart';
import 'package:mydb/services/export_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('resultPagesToCsv encodes pages without blocking API contract', () async {
    const ExportService svc = ExportService();
    final List<ResultPage> pages = <ResultPage>[
      ResultPage(
        pageIndex: 0,
        pageSize: 10,
        columns: <String>['a', 'b'],
        rows: <List<dynamic>>[
          <dynamic>[1, 'x'],
          <dynamic>[null, 'y,"z"'],
        ],
        queryDuration: Duration.zero,
      ),
    ];
    final String csv = await svc.resultPagesToCsv(pages);
    expect(csv, contains('a'));
    expect(csv, contains('b'));
    expect(csv, contains('1'));
    expect(csv, contains('x'));
  });
}
