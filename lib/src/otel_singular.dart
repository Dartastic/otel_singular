// Licensed under the Apache License, Version 2.0
// Copyright 2025, Mindful Software LLC, All rights reserved.

import 'package:dartastic_opentelemetry/dartastic_opentelemetry.dart';
import 'package:dartastic_opentelemetry_api/dartastic_opentelemetry_api.dart';

import 'otel_singular_suppression.dart';

class SingularResult {
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

class SingularCallResult<T> {
  const SingularCallResult({required this.value, this.result});
  final T value;
  final SingularResult? result;
}

Future<T> tracedSingular<T>({
  required String operation,
  required Future<SingularCallResult<T>> Function() invoke,
  Tracer? tracer,
}) async {
  if (singularInstrumentationSuppressed()) {
    final r = await invoke();
    return r.value;
  }
  final t = tracer ?? OTel.tracerProvider().getTracer('otel_singular');
  final span = t.startSpan('singular $operation', kind: SpanKind.client);
  try {
    span.setStringAttribute('rpc.system', 'singular');
    span.setStringAttribute('rpc.method', operation);
    final r = await invoke();
    final res = r.result;
    if (res != null) {
      if (res.account != null) {
        span.setStringAttribute('singular.account', res.account!);
      }
      if (res.app != null) {
        span.setStringAttribute('singular.app', res.app!);
      }
      if (res.platform != null) {
        span.setStringAttribute('singular.platform', res.platform!);
      }
      if (res.sdkVersion != null) {
        span.setStringAttribute('singular.sdk_version', res.sdkVersion!);
      }
      if (res.eventName != null) {
        span.setStringAttribute('singular.event.name', res.eventName!);
      }
      if (res.eventType != null) {
        span.setStringAttribute('singular.event.type', res.eventType!);
      }
      if (res.installId != null) {
        span.setStringAttribute('singular.install.id', res.installId!);
      }
      if (res.deviceId != null) {
        span.setStringAttribute('singular.device.id', res.deviceId!);
      }
      if (res.userId != null) {
        span.setStringAttribute('singular.user.id', res.userId!);
      }
      if (res.network != null) {
        span.setStringAttribute('singular.attribution.network', res.network!);
      }
      if (res.campaign != null) {
        span.setStringAttribute('singular.attribution.campaign', res.campaign!);
      }
      if (res.campaignId != null) {
        span.setStringAttribute(
            'singular.attribution.campaign_id', res.campaignId!);
      }
      if (res.adset != null) {
        span.setStringAttribute('singular.attribution.adset', res.adset!);
      }
      if (res.creative != null) {
        span.setStringAttribute('singular.attribution.creative', res.creative!);
      }
      if (res.subPublisher != null) {
        span.setStringAttribute(
            'singular.attribution.sub_publisher', res.subPublisher!);
      }
      if (res.country != null) {
        span.setStringAttribute('singular.country', res.country!);
      }
      if (res.conversionType != null) {
        span.setStringAttribute(
            'singular.conversion.type', res.conversionType!);
      }
      if (res.conversionValue != null) {
        span.setDoubleAttribute(
            'singular.conversion.value', res.conversionValue!);
      }
      if (res.revenueAmount != null) {
        span.setDoubleAttribute('singular.revenue.amount', res.revenueAmount!);
      }
      if (res.revenueCurrency != null) {
        span.setStringAttribute(
            'singular.revenue.currency', res.revenueCurrency!);
      }
      if (res.isReengagement != null) {
        span.setBoolAttribute('singular.is_reengagement', res.isReengagement!);
      }
      if (res.isReinstall != null) {
        span.setBoolAttribute('singular.is_reinstall', res.isReinstall!);
      }
      if (res.statusCode != null) {
        span.setIntAttribute('http.response.status_code', res.statusCode!);
      }
      if (res.errorCode != null) {
        span.setStringAttribute('singular.error.code', res.errorCode!);
      }
      final fail = res.errorCode != null ||
          (res.statusCode != null && res.statusCode! >= 400);
      if (fail) {
        span.setStringAttribute(
            ErrorResource.errorType.key, res.errorCode ?? 'singular.error');
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
