// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:in_app_purchase/billing_client_wrappers.dart';
import 'package:in_app_purchase/src/billing_client_wrappers/enum_converters.dart';
import 'package:in_app_purchase/src/in_app_purchase_connection/in_app_purchase_connection.dart';

final PurchaseWrapper dummyPurchase = PurchaseWrapper(
  orderId: 'orderId',
  packageName: 'packageName',
  purchaseTime: 0,
  signature: 'signature',
  sku: 'sku',
  purchaseToken: 'purchaseToken',
  isAutoRenewing: false,
  originalJson: '',
);

void main() {
  group('PurchaseWrapper', () {
    test('converts from map', () {
      final PurchaseWrapper expected = dummyPurchase;
      final PurchaseWrapper parsed =
          PurchaseWrapper.fromJson(buildPurchaseMap(expected));

      expect(parsed, equals(expected));
    });

    test('toPurchaseDetails() should return correct PurchaseDetail object', (){
      final PurchaseDetails details = dummyPurchase.toPurchaseDetails();
      expect(details.purchaseID, dummyPurchase.orderId);
      expect(details.productId, dummyPurchase.sku);
      expect(details.originalPurchase, null);
      expect(details.transactionDate, dummyPurchase.purchaseTime.toString());
      expect(details.verificationData.source, PurchaseSource.GooglePlay);
      expect(details.verificationData.data, dummyPurchase.originalJson);
    });
  });

  group('PurchasesResultWrapper', () {
    test('parsed from map', () {
      final BillingResponse responseCode = BillingResponse.ok;
      final List<PurchaseWrapper> purchases = <PurchaseWrapper>[
        dummyPurchase,
        dummyPurchase
      ];
      final PurchasesResultWrapper expected = PurchasesResultWrapper(
          responseCode: responseCode, purchasesList: purchases);

      final PurchasesResultWrapper parsed =
          PurchasesResultWrapper.fromJson(<String, dynamic>{
        'responseCode': BillingResponseConverter().toJson(responseCode),
        'purchasesList': <Map<String, dynamic>>[
          buildPurchaseMap(dummyPurchase),
          buildPurchaseMap(dummyPurchase)
        ]
      });

      expect(parsed.responseCode, equals(expected.responseCode));
      expect(parsed.purchasesList, containsAll(expected.purchasesList));
    });
  });
}

Map<String, dynamic> buildPurchaseMap(PurchaseWrapper original) {
  return <String, dynamic>{
    'orderId': original.orderId,
    'packageName': original.packageName,
    'purchaseTime': original.purchaseTime,
    'signature': original.signature,
    'sku': original.sku,
    'purchaseToken': original.purchaseToken,
    'isAutoRenewing': original.isAutoRenewing,
    'originalJson': original.originalJson,
  };
}
