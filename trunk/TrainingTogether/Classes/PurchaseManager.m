//
//  PurchaseManager.m
//  TrainingTogether
//
//  Created by Alessio Melani on 23/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "PurchaseManager.h"

@interface PurchaseManager ()
{
}

- (void)restoreTransaction:(SKPaymentTransaction*) transaction;

@end

@implementation PurchaseManager

#pragma mark - Private Methods

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    
}

#pragma mark - Public Methods

- (void)validateProductIdentifiers
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"TrainingPrograms" withExtension:@"plist"];
    NSArray* embeddedProductIds = [NSArray arrayWithContentsOfURL:url];
    
    SKProductsRequest* productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:embeddedProductIds]];
    productRequest.delegate = self;
    [productRequest start];
}

- (void)restorePurchases
{
    SKPaymentQueue* paymentQueue = [SKPaymentQueue defaultQueue];
    [paymentQueue addTransactionObserver:self];
    [paymentQueue restoreCompletedTransactions];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction* transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStateDeferred:
                break;
            case SKPaymentTransactionStateFailed:
                break;
            case SKPaymentTransactionStatePurchased:
                break;
            case SKPaymentTransactionStateRestored:
                break;
            default:
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
        }
    }
}


@end
