// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:otel_singular/otel_singular.dart';

/// Traces Singular calls with OpenTelemetry.
///
/// `otel_singular` depends on the OpenTelemetry API only, so the application
/// initializes an SDK once at startup. Wrap each Singular call in
/// [tracedSingular]; the `invoke` callback makes the real call and reports what
/// came back, which is recorded on the span.
Future<void> main() async {
  await OTel.initialize(serviceName: 'singular-example');

  // Traces a Singular call.
  final singularId = await tracedSingular<String>(
    operation: 'create',
    invoke: () async {
      // Make the Singular call here, then report what it returned.
      const id = 'singular_8f3a2c';
      return const SingularCallResult(
          value: id,
          result: SingularResult(
              account: 'example',
              app: 'example',
              platform: 'example',
              sdkVersion: '1',
              eventName: 'order.created',
              eventType: 'order.created',
              installId: 'install_8f3a2c',
              deviceId: 'device_8f3a2c',
              userId: 'user_8f3a2c',
              network: 'example',
              campaign: 'example',
              campaignId: 'campaign_8f3a2c',
              adset: 'example',
              creative: 'example',
              subPublisher: 'example',
              country: 'example',
              conversionType: 'standard',
              conversionValue: 0.5,
              revenueAmount: 0.5,
              revenueCurrency: 'usd',
              isReengagement: true,
              isReinstall: true,
              statusCode: 201,
              errorCode: 'example',
              errorMessage: 'example'));
    },
  );
  OTelLog.info('tracedSingular create returned $singularId');

  // Calls that should not be traced, such as health checks, run inside
  // runWithoutSingularInstrumentationAsync.
  await runWithoutSingularInstrumentationAsync(
    () => tracedSingular<String>(
      operation: 'create',
      invoke: () async {
        const id = 'singular_8f3a2c';
        return const SingularCallResult(
            value: id,
            result: SingularResult(
                account: 'example',
                app: 'example',
                platform: 'example',
                sdkVersion: '1',
                eventName: 'order.created',
                eventType: 'order.created',
                installId: 'install_8f3a2c',
                deviceId: 'device_8f3a2c',
                userId: 'user_8f3a2c',
                network: 'example',
                campaign: 'example',
                campaignId: 'campaign_8f3a2c',
                adset: 'example',
                creative: 'example',
                subPublisher: 'example',
                country: 'example',
                conversionType: 'standard',
                conversionValue: 0.5,
                revenueAmount: 0.5,
                revenueCurrency: 'usd',
                isReengagement: true,
                isReinstall: true,
                statusCode: 201,
                errorCode: 'example',
                errorMessage: 'example'));
      },
    ),
  );

  await OTel.shutdown();
}
