//
//  PurchaseManager.h
//  TrainingTogether
//
//  Created by Alessio Melani on 23/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
@import StoreKit;

@interface PurchaseManager : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver>

- (void)validateProductIdentifiers;
- (void)restorePurchases;

@end
