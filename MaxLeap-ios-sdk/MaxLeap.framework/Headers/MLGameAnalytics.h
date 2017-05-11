//
//  MLGameAnalytics.h
//  MaxLeap
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  Track game mission events.
 */
@interface MLGAMission : NSObject

/**
 * Tracks the occurrence of beginning a specified mission.
 *
 * @param missionId The customize mission id.
 * @param type      The mission type
 */
+ (void)onBegin:(NSString *)missionId type:(nullable NSString *)type;

/**
 * Suspend the mission tracking timer.
 *
 * @param missionId The mission id
 */
+ (void)onPause:(NSString *)missionId;

/**
 * Suspend all the mission tracking timers.
 */
+ (void)pauseAll;

/**
 * Resume the tracking of the mission with id `missionId`.
 *
 * @param missionId The customize mission id.
 */
+ (void)onResume:(NSString *)missionId;

/**
 * Resume all the mission trackings.
 */
+ (void)resumeAll;

/**
 * Tracks the occurrence of completion a specified mission.
 *
 * @param missionId The customize mission id.
 */
+ (void)onCompleted:(NSString *)missionId;

/**
 * Tracks the occurrence of failure a specified mission.
 *
 * @param missionId The customize mission id.
 * @param cause     Reason of the mission failure
 */
+ (void)onFailed:(NSString *)missionId failedCause:(nullable NSString *)cause;

@end


/**
 *  Track the game item events.
 */
@interface MLGAItem : NSObject

/**
 * Tracks the occurrence of purchasing item.
 *
 * @param item                  The customize item id.
 * @param count                 The purchase number of items.
 * @param type                  The customize item type.
 * @param virtualCurrencyAmount The virtual currency amount.
 */
+ (void)onPurchase:(NSString *)item itemCount:(int)count itemType:(NSString *)type virtualCurrency:(double)virtualCurrencyAmount;

/**
 * Tracks the occurrence of using item.
 *
 * @param item   The customize item id.
 * @param type   The item type
 * @param count  The used number of items.
 */
+ (void)onUse:(NSString *)item itemType:(NSString *)type itemCount:(int)count;

/**
 * Tracks the occurrence of rewarding item.
 *
 * @param item   The customize item id.
 * @param type   The customize item type.
 * @param count  The purchase number of items.
 * @param reason The reason why rewarding the item.
 */
+ (void)onReward:(NSString *)item itemType:(NSString *)type itemCount:(int)count reason:(nullable NSString *)reason;

@end


/**
 *  Track game virture currency events.
 */
@interface MLGAVirtureCurrency : NSObject

/**
 * Tracks the beginning of requesting iap purchase.
 *
 * @param transaction           The transaction
 * @param orderId               The order id, managed by yourself
 * @param currencyAmount        The cost of this transaction
 * @param currencyType          The currency code, eg. USD
 * @param virtualCurrencyAmount The virtual currency amount
 * @param paySource             The payment platform
 */
+ (void)onChargeRequest:(SKPaymentTransaction *)transaction
                orderId:(NSString *)orderId
         currencyAmount:(double)currencyAmount
           currencyType:(NSString *)currencyType
  virtualCurrencyAmount:(double)virtualCurrencyAmount
              paySource:(NSString *)paySource;

/**
 * Tracks the success of iap purchase.
 *
 * @param transaction The transaction
 * @param orderId     The order id, managed by yourself
 */
+ (void)onChargeSuccess:(SKPaymentTransaction *)transaction orderId:(NSString *)orderId;

/**
 * Tracks the cancellation of iap purchase.
 *
 * @param transaction    The transaction
 * @param orderId        The order id, managed by yourself
 */
+ (void)onChargeCancelled:(SKPaymentTransaction *)transaction orderId:(NSString *)orderId;

/**
 * Tracks the failure of iap purchase.
 *
 * @param transaction    The transaction
 * @param orderId        The order id, managed by yourself
 */
+ (void)onChargeFailed:(SKPaymentTransaction *)transaction orderId:(NSString *)orderId;

/**
 * Tracks the occurrence of rewarding virtual currency.
 *
 * @param virtualCurrencyAmount The amount of rewarding virtual currency
 * @param reason                The reason why rewarding virtual currency
 */
+ (void)onReward:(double)virtualCurrencyAmount reason:(NSString *)reason;

@end

FOUNDATION_EXPORT NSString * const MLPaySourceAli;
FOUNDATION_EXPORT NSString * const MLPaySourceAliApp;
FOUNDATION_EXPORT NSString * const MLPaySourceWeiXin;
FOUNDATION_EXPORT NSString * const MLPaySourceWeiXinApp;
FOUNDATION_EXPORT NSString * const MLPaySourcePaypal;
FOUNDATION_EXPORT NSString * const MLPaySourceAppStore;
FOUNDATION_EXPORT NSString * const MLPaySourceAmazon;
FOUNDATION_EXPORT NSString * const MLPaySourceUnion;
FOUNDATION_EXPORT NSString * const MLPaySourceUnionApp;

NS_ASSUME_NONNULL_END
