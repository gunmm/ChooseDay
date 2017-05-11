//
//  MLAnalytics.h
//  MaxLeap
//


#ifdef EXTENSION_IOS
#   import <MaxLeapExt/MLConstants.h>
#else
#   import <MaxLeap/MLConstants.h>
#endif

@class SKPaymentTransaction;

NS_ASSUME_NONNULL_BEGIN

/*!
 MLAnalytics provides methods to logging user behavior to analytics backend.<br>
 <br>
 Events for Session starting and session ending are logged automatically when app enter foreground or background.
 */
@interface MLAnalytics : NSObject

#pragma mark -

/**
 *  Set the timeout for expiring a MaxLeap session.
 *
 *  This is an optional method that sets the time the app may be in the background before
 *  starting a new session upon resume.  The default value for the session timeout is 0
 *  seconds in the background.
 *
 *  @param seconds The time in seconds to set the session timeout to.
 */
+ (void)setSessionContinueSeconds:(int)seconds;

#pragma mark -
/** @name Custom Event Analytics */

/*!
 Tracks the occurrence of a custom event and reports to MaxLeap backend.
 
 @param name The name of the custom event.
 */
+ (void)trackEvent:(NSString *)name;

/**
 *  Tracks the occurrence of a custom event and reports to MaxLeap backend.
 *
 *  @param name  The name of the custom event.
 *  @param count The number of this event occurred.
 */
+ (void)trackEvent:(NSString *)name count:(int)count;

/**
 *  Tracks the occurrence of a custom event with additional parameters.<br>
 *
 *  Event parameters can be used to provide additional information about the event. The parameters is a dictionary containing Key-Value pairs of parameters. Keys and values should be NSStrings.<br>
 *
 *  The following is a sample to track a purchase with additional parameters:<br>
 *
 *  @code
 *  NSDictionary *parameters = @{@"productName": @"iPhone 6s",
 *                               @"productCategory": @"electronics"};
 *  [MLAnalytics trackEvent:@"productPurchased" parameters:parameters];
 *  @endcode
 *
 *  @param name       The name of the custom event.
 *  @param parameters The dictionary of additional information for this event.
 */
+ (void)trackEvent:(NSString *)name parameters:(nullable NSDictionary ML_GENERIC(NSString*, NSString*) *)parameters;

/**
 *  Tracks the occurrence of a custom event with additional parameters.<br>
 *
 *  Event parameters can be used to provide additional information about the event. The parameters is a dictionary containing Key-Value pairs of parameters. Keys and values should be NSStrings.<br>
 *
 *  The following is a sample to track a purchase with additional parameters:<br>
 *
 *  @code
 *  NSDictionary *parameters = @{@"productName": @"iPhone 6s",
 *                               @"productCategory": @"electronics"};
 *  [MLAnalytics trackEvent:@"productPurchased" parameters:parameters];
 *  @endcode
 *
 *  @param name       The name of the custom event.
 *  @param parameters The dictionary of additional information for this event.
 *  @param count      The number of this event occurred.
 */
+ (void)trackEvent:(NSString *)name parameters:(nullable NSDictionary ML_GENERIC(NSString*, NSString*) *)parameters count:(int)count;

#pragma mark -
/** @name Page View Analytics */

/**
 *  Tracks the duration of view displayed.
 *
 *  Tracks the beginning of view display.
 *
 *  @param pageName The name of the page.
 */
+ (void)beginLogPageView:(NSString *)pageName;

/**
 *  Tracks the duration of view displayed.
 *
 *  Tracks the ending of view display.
 *
 *  @param pageName The name of the page.
 */
+ (void)endLogPageView:(NSString *)pageName;

#pragma mark -
/** @name IAP Purchase Analytics */

/**
 * Tracks the beginning of requesting iap purchase.
 *
 * @param transaction    The transaction
 * @param isSubscription Whether the transaction is a subscription
 */
+ (void)onPurchaseRequest:(SKPaymentTransaction *)transaction isSubscription:(BOOL)isSubscription;

/**
 * Tracks the success of iap purchase.
 *
 * @param transaction    The transaction
 * @param isSubscription Whether the transaction is a subscription
 */
+ (void)onPurchaseSuccess:(SKPaymentTransaction *)transaction isSubscription:(BOOL)isSubscription;

/**
 * Tracks the occurrence of cancelling iap purchase.
 *
 * @param transaction    The transaction
 * @param isSubscription Whether the transaction is a subscription
 */
+ (void)onPurchaseCancelled:(SKPaymentTransaction *)transaction isSubscription:(BOOL)isSubscription;

/**
 * Tracks the failure of iap purchase.
 *
 * @param transaction    The transaction
 * @param isSubscription Whether the transaction is a subscription
 */
+ (void)onPurchaseFailed:(SKPaymentTransaction *)transaction isSubscription:(BOOL)isSubscription;

@end

NS_ASSUME_NONNULL_END
