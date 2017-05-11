//
//  MLReceiptManager.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLConstants.h>
#else
    #import <MaxLeap/MLConstants.h>
#endif

/**
 * MLReceiptManager
 */
@interface MLReceiptManager : NSObject

/*!
 @discussion MaxLeap validates the receipt with Apple and gives the result.
 
 @code
 NSData *receipt = transaction.transactionReceipt;
 
 [MLReceiptManager verifyPaymentReceipt:receipt completion:^(BOOL isValid, NSError *error) {
    if (isValid) {
        // the receipt is valid
    } else {
        // The receipt validating failed.
        if ([error.domain isEqualToString:MLErrorDomain] && error.code == kMLErrorInvalidAuthData) {
            // the receipt is invalid
        } else {
            // an error occured
        }
    }
 }];
 @endcode
 
 @param receiptData The receipt data contained in a transaction.
 @param block the completion block will excute on main thread.
 */
+ (void)verifyPaymentReceipt:(nullable NSData *)receiptData completion:(nullable MLBooleanResultBlock)block;

@end
