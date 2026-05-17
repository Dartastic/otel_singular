// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:otel_singular/otel_singular.dart';
import 'package:test/test.dart';

void main() {
  group('otel_singular', () {
    test('suppression toggles in zone', () async {
      expect(singularInstrumentationSuppressed(), isFalse);
      await runWithoutSingularInstrumentationAsync(() async {
        expect(singularInstrumentationSuppressed(), isTrue);
      });
      expect(singularInstrumentationSuppressed(), isFalse);
    });

    test('SingularResult fields default null', () {
      const r = SingularResult();
      expect(r.installId, isNull);
      expect(r.network, isNull);
      expect(r.revenueAmount, isNull);
    });
  });
}
