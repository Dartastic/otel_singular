# otel_singular

Dartastic OpenTelemetry bridge for [Singular](https://singular.net), a mobile attribution and marketing analytics platform.

Wraps each Singular API or S2S call in a CLIENT-kind span with attributes for install/device/user, attribution (network, campaign, adset, creative), conversion value, revenue, reengagement and reinstall flags.

```dart
import 'package:otel_singular/otel_singular.dart';

await tracedSingular<void>(
  operation: 'logEvent',
  invoke: () async {
    await singularClient.logEvent(name: 'purchase', revenue: 4.99);
    return SingularCallResult(
      value: null,
      result: SingularResult(
        eventName: 'purchase',
        eventType: 'revenue',
        revenueAmount: 4.99,
        revenueCurrency: 'USD',
        statusCode: 200,
      ),
    );
  },
);
```

Suppress instrumentation within a block:

```dart
await runWithoutSingularInstrumentationAsync(() async {
  await singularClient.someInternalSync();
});
```
