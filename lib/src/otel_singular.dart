// Licensed under the Apache License, Version 2.0
// Copyright 2025-2026 Mindful Software LLC d/b/a Dartastic.io, All rights reserved.

import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_singular_suppression.dart';

class SingularResult {
  /// Creates a result.
  const SingularResult({
    this.account,
    this.app,
    this.platform,
    this.sdkVersion,
    this.eventName,
    this.eventType,
    this.installId,
    this.deviceId,
    this.userId,
    this.network,
    this.campaign,
    this.campaignId,
    this.adset,
    this.creative,
    this.subPublisher,
    this.country,
    this.conversionType,
    this.conversionValue,
    this.revenueAmount,
    this.revenueCurrency,
    this.isReengagement,
    this.isReinstall,
    this.statusCode,
    this.errorCode,
    this.errorMessage,
  });

  final String? account;
  final String? app;
  final String? platform;
  final String? sdkVersion;
  final String? eventName;
  final String? eventType;
  final String? installId;
  final String? deviceId;
  final String? userId;
  final String? network;
  final String? campaign;
  final String? campaignId;
  final String? adset;
  final String? creative;
  final String? subPublisher;
  final String? country;
  final String? conversionType;
  final double? conversionValue;
  final double? revenueAmount;
  final String? revenueCurrency;
  final bool? isReengagement;
  final bool? isReinstall;
  final int? statusCode;
  final String? errorCode;
  final String? errorMessage;
}

/// What a traced call returned: the value for the caller plus fields
/// recorded on the span.
class SingularCallResult<T> {
  /// Creates a call result.
  const SingularCallResult({required this.value, this.result});

  /// The value returned to the caller.
  final T value;
  final SingularResult? result;
}

Future<T> tracedSingular<T>({
  required String operation,
  required Future<SingularCallResult<T>> Function() invoke,
  APITracer? tracer,
}) async {
  if (singularInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTelAPI.tracerProvider().getTracer('otel_singular');
  final span = t.startSpan('singular $operation', kind: SpanKind.client);
  try {
    span.addAttributes(OTelAPI.attributes(
        [OTelAPI.attributeString('rpc.system', 'singular')]));
    span.addAttributes(
        OTelAPI.attributes([OTelAPI.attributeString('rpc.method', operation)]));
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.account != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.account', res.account!)]));
      }
      if (res.app != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.app', res.app!)]));
      }
      if (res.platform != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.platform', res.platform!)]));
      }
      if (res.sdkVersion != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('singular.sdk_version', res.sdkVersion!)
        ]));
      }
      if (res.eventName != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.event.name', res.eventName!)]));
      }
      if (res.eventType != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.event.type', res.eventType!)]));
      }
      if (res.installId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.install.id', res.installId!)]));
      }
      if (res.deviceId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.device.id', res.deviceId!)]));
      }
      if (res.userId != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.user.id', res.userId!)]));
      }
      if (res.network != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('singular.attribution.network', res.network!)
        ]));
      }
      if (res.campaign != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'singular.attribution.campaign', res.campaign!)
        ]));
      }
      if (res.campaignId != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'singular.attribution.campaign_id', res.campaignId!)
        ]));
      }
      if (res.adset != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString('singular.attribution.adset', res.adset!)
        ]));
      }
      if (res.creative != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'singular.attribution.creative', res.creative!)
        ]));
      }
      if (res.subPublisher != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'singular.attribution.sub_publisher', res.subPublisher!)
        ]));
      }
      if (res.country != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.country', res.country!)]));
      }
      if (res.conversionType != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'singular.conversion.type', res.conversionType!)
        ]));
      }
      if (res.conversionValue != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeDouble(
              'singular.conversion.value', res.conversionValue!)
        ]));
      }
      if (res.revenueAmount != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeDouble('singular.revenue.amount', res.revenueAmount!)
        ]));
      }
      if (res.revenueCurrency != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              'singular.revenue.currency', res.revenueCurrency!)
        ]));
      }
      if (res.isReengagement != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeBool('singular.is_reengagement', res.isReengagement!)
        ]));
      }
      if (res.isReinstall != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeBool('singular.is_reinstall', res.isReinstall!)
        ]));
      }
      if (res.statusCode != null) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeInt('http.response.status_code', res.statusCode!)
        ]));
      }
      if (res.errorCode != null) {
        span.addAttributes(OTelAPI.attributes(
            [OTelAPI.attributeString('singular.error.code', res.errorCode!)]));
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.addAttributes(OTelAPI.attributes([
          OTelAPI.attributeString(
              ErrorAttributes.errorType.key, res.errorCode ?? 'singular.error')
        ]));
        span.setStatus(SpanStatusCode.Error, res.errorMessage);
      }
    }
    return r.value;
  } catch (e, st) {
    span.recordException(e, stackTrace: st);
    span.setStatus(SpanStatusCode.Error, e.toString());
    rethrow;
  } finally {
    span.end();
  }
}
