import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mydb/app.dart';
import 'package:mydb/drivers/register_drivers.dart';
import 'package:mydb/models/connection_profile.dart';
import 'package:mydb/state/connection_providers.dart';

/// Avoids [ConnectionProfileRepository.open] in widget tests (Hive + async load
/// would keep the sidebar in loading with an endless [CircularProgressIndicator],
/// so [WidgetTester.pumpAndSettle] never completes).
class _EmptySavedProfiles extends SavedConnectionProfiles {
  @override
  Future<List<ConnectionProfile>> build() async => <ConnectionProfile>[];
}

void main() {
  setUpAll(registerDrivers);

  testWidgets('DBStudio shell shows title', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          savedConnectionProfilesProvider.overrideWith(_EmptySavedProfiles.new),
        ],
        child: const DBStudioApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('DBStudio'), findsWidgets);
  });
}
