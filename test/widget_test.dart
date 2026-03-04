import 'package:flutter_test/flutter_test.dart';
import 'package:ecoscan_app/app.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const EcoScanApp());
  });
}