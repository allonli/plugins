// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:ui' show hashValues;
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'enum_converters.dart';
import 'billing_client_wrapper.dart';
import 'sku_details_wrapper.dart';

// WARNING: Changes to `@JsonSerializable` classes need to be reflected in the
// below generated file. Run `flutter packages pub run build_runner watch` to
// rebuild and watch for further changes.
part 'purchase_wrapper.g.dart';

/// Data structure representing a successful purchase.
///
/// All purchase information should also be verified manually, with your
/// server if at all possible. See ["Verify a
/// purchase"](https://developer.android.com/google/play/billing/billing_library_overview#Verify).
///
/// This wraps [`com.android.billlingclient.api.Purchase`](https://developer.android.com/reference/com/android/billingclient/api/Purchase)
@JsonSerializable()
@PurchaseStateConverter()
class PurchaseWrapper {
  @visibleForTesting
  PurchaseWrapper(
      {@required this.orderId,
      @required this.packageName,
      @required this.purchaseTime,
      @required this.purchaseToken,
      @required this.signature,
      @required this.sku,
      @required this.isAutoRenewing,
      @required this.originalJson,
      @required this.developerPayload,
      @required this.isAcknowledged,
      @required this.purchaseState});

  factory PurchaseWrapper.fromJson(Map map) => _$PurchaseWrapperFromJson(map);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PurchaseWrapper typedOther = other;
    return typedOther.orderId == orderId &&
        typedOther.packageName == packageName &&
        typedOther.purchaseTime == purchaseTime &&
        typedOther.purchaseToken == purchaseToken &&
        typedOther.signature == signature &&
        typedOther.sku == sku &&
        typedOther.isAutoRenewing == isAutoRenewing &&
        typedOther.originalJson == originalJson &&
        typedOther.isAcknowledged == isAcknowledged &&
        typedOther.purchaseState == purchaseState;
  }

  @override
  int get hashCode => hashValues(
      orderId,
      packageName,
      purchaseTime,
      purchaseToken,
      signature,
      sku,
      isAutoRenewing,
      originalJson,
      isAcknowledged,
      purchaseState);

  /// The unique ID for this purchase. Corresponds to the Google Payments order
  /// ID.
  final String orderId;

  /// The package name the purchase was made from.
  final String packageName;

  /// When the purchase was made, as an epoch timestamp.
  final int purchaseTime;

  /// A unique ID for a given [SkuDetailsWrapper], user, and purchase.
  final String purchaseToken;

  /// Signature of purchase data, signed with the developer's private key. Uses
  /// RSASSA-PKCS1-v1_5.
  final String signature;

  /// The product ID of this purchase.
  final String sku;

  /// True for subscriptions that renew automatically. Does not apply to
  /// [SkuType.inapp] products.
  ///
  /// For [SkuType.subs] this means that the subscription is canceled when it is
  /// false.
  final bool isAutoRenewing;

  /// Details about this purchase, in JSON.
  ///
  /// This can be used verify a purchase. See ["Verify a purchase on a
  /// device"](https://developer.android.com/google/play/billing/billing_library_overview#Verify-purchase-device).
  /// Note though that verifying a purchase locally is inherently insecure (see
  /// the article for more details).
  final String originalJson;

  /// The payload specified by the developer when the purchase was acknowledged or consumed.
  final String developerPayload;

  /// Whether the purchase has been acknowledged.
  final bool isAcknowledged;

  /// The state of purchase.
  final PurchaseStateWrapper purchaseState;
}

/// Data structure representing a purchase history record.
///
/// This class includes a subset of fields in [PurchaseWrapper].
///
/// This wraps [`com.android.billlingclient.api.PurchaseHistoryRecord`](https://developer.android.com/reference/com/android/billingclient/api/PurchaseHistoryRecord)
///
/// * See also: [BillingClient.queryPurchaseHistory] for obtaining a [PurchaseHistoryRecordWrapper].
// We can optionally make [PurchaseWrapper] extend or implement [PurchaseHistoryRecordWrapper].
// For now, we keep them separated classes to be consistent with Android's BillingClient implementation.
@JsonSerializable()
class PurchaseHistoryRecordWrapper {
  @visibleForTesting
  PurchaseHistoryRecordWrapper({
    @required this.purchaseTime,
    @required this.purchaseToken,
    @required this.signature,
    @required this.sku,
    @required this.originalJson,
    @required this.developerPayload,
  });

  factory PurchaseHistoryRecordWrapper.fromJson(Map map) =>
      _$PurchaseHistoryRecordWrapperFromJson(map);

  /// When the purchase was made, as an epoch timestamp.
  final int purchaseTime;

  /// A unique ID for a given [SkuDetailsWrapper], user, and purchase.
  final String purchaseToken;

  /// Signature of purchase data, signed with the developer's private key. Uses
  /// RSASSA-PKCS1-v1_5.
  final String signature;

  /// The product ID of this purchase.
  final String sku;

  /// Details about this purchase, in JSON.
  ///
  /// This can be used verify a purchase. See ["Verify a purchase on a
  /// device"](https://developer.android.com/google/play/billing/billing_library_overview#Verify-purchase-device).
  /// Note though that verifying a purchase locally is inherently insecure (see
  /// the article for more details).
  final String originalJson;

  /// The payload specified by the developer when the purchase was acknowledged or consumed.
  final String developerPayload;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PurchaseHistoryRecordWrapper typedOther = other;
    return typedOther.purchaseTime == purchaseTime &&
        typedOther.purchaseToken == purchaseToken &&
        typedOther.signature == signature &&
        typedOther.sku == sku &&
        typedOther.originalJson == originalJson &&
        typedOther.developerPayload == developerPayload;
  }

  @override
  int get hashCode => hashValues(purchaseTime, purchaseToken, signature, sku,
      originalJson, developerPayload);
}

/// A data struct representing the result of a transaction.
///
/// Contains a potentially empty list of [PurchaseWrapper]s, a [BillingResultWrapper]
/// that contains a detailed description of the status and a
/// [BillingResponse] to signify the overall state of the transaction.
///
/// Wraps [`com.android.billingclient.api.Purchase.PurchasesResult`](https://developer.android.com/reference/com/android/billingclient/api/Purchase.PurchasesResult).
@JsonSerializable()
@BillingResponseConverter()
class PurchasesResultWrapper {
  PurchasesResultWrapper(
      {@required BillingResponse this.responseCode,
      @required BillingResultWrapper this.billingResult,
      @required List<PurchaseWrapper> this.purchasesList});

  factory PurchasesResultWrapper.fromJson(Map<String, dynamic> map) =>
      _$PurchasesResultWrapperFromJson(map);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PurchasesResultWrapper typedOther = other;
    return typedOther.responseCode == responseCode &&
        typedOther.purchasesList == purchasesList &&
        typedOther.billingResult == billingResult;
  }

  @override
  int get hashCode => hashValues(billingResult, responseCode, purchasesList);

  /// The detailed description of the status of the operation.
  final BillingResultWrapper billingResult;

  /// The status of the operation.
  ///
  /// This can represent either the status of the "query purchase history" half
  /// of the operation and the "user made purchases" transaction itself.
  final BillingResponse responseCode;

  /// The list of successful purchases made in this transaction.
  ///
  /// May be empty, especially if [responseCode] is not [BillingResponse.ok].
  final List<PurchaseWrapper> purchasesList;
}

/// A data struct representing the result of a purchase history.
///
/// Contains a potentially empty list of [PurchaseHistoryRecordWrapper]s and a [BillingResultWrapper]
/// that contains a detailed description of the status.
@JsonSerializable()
@BillingResponseConverter()
class PurchasesHistoryResult {
  PurchasesHistoryResult(
      {@required
          BillingResultWrapper this.billingResult,
      @required
          List<PurchaseHistoryRecordWrapper> this.purchaseHistoryRecordList});

  factory PurchasesHistoryResult.fromJson(Map<String, dynamic> map) =>
      _$PurchasesHistoryResultFromJson(map);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other.runtimeType != runtimeType) return false;
    final PurchasesHistoryResult typedOther = other;
    return typedOther.purchaseHistoryRecordList == purchaseHistoryRecordList &&
        typedOther.billingResult == billingResult;
  }

  @override
  int get hashCode => hashValues(billingResult, purchaseHistoryRecordList);

  /// The detailed description of the status of the [BillingClient.queryPurchaseHistory].
  final BillingResultWrapper billingResult;

  /// The list of queried purchase history records.
  ///
  /// May be empty, especially if [billingResult.responseCode] is not [BillingResponse.ok].
  final List<PurchaseHistoryRecordWrapper> purchaseHistoryRecordList;
}

/// The parameter object used when consuming a purchase.
///
/// See also [BillingClient.consumeAsync] for consuming a purchase.
class ConsumeParams {
  /// Constructs the [ConsumeParams].
  ///
  /// The `purchaseToken` must not be null.
  /// The default value of `developerPayload` is null.
  ConsumeParams({@required this.purchaseToken, this.developerPayload = null});

  /// The developer data associated with the purchase to be consumed.
  ///
  /// Defaults to null.
  final String developerPayload;

  /// The token that identifies the purchase to be consumed.
  final String purchaseToken;
}

/// The parameter object used when acknowledge a purchase.
///
/// See also [BillingClient.acknowledgePurchase] for acknowledging a purchase.
class AcknowledgeParams {
  /// Constructs the [AcknowledgeParams].
  ///
  /// The `purchaseToken` must not be null.
  /// The default value of `developerPayload` is null.
  AcknowledgeParams(
      {@required this.purchaseToken, this.developerPayload = null});

  /// The developer data associated with the purchase to be acknowledged.
  ///
  /// Defaults to null.
  final String developerPayload;

  /// The token that identifies the purchase to be acknowledged.
  final String purchaseToken;
}

/// Possible state of a [PurchaseWrapper].
///
/// Wraps
/// [`BillingClient.api.Purchase.PurchaseState`](https://developer.android.com/reference/com/android/billingclient/api/Purchase.PurchaseState.html).
/// * See also: [PurchaseWrapper].
enum PurchaseStateWrapper {
  @JsonValue(0)
  unspecified_state,

  @JsonValue(1)
  purchased,

  @JsonValue(2)
  pending,
}
