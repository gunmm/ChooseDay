//
//  MaxLeap.h
//  MaxLeap
//


#import <MaxLeap/MLConstants.h>
#import <MaxLeap/MLRelation.h>
#import <MaxLeap/MLGeoPoint.h>
#import <MaxLeap/MLObject.h>
#import <MaxLeap/MLSubclassing.h>
#import <MaxLeap/MLObject+Subclass.h>
#import <MaxLeap/MLQuery.h>
#import <MaxLeap/MLInstallation.h>
#import <MaxLeap/MLUser.h>
#import <MaxLeap/MLAnonymousUtils.h>
#import <MaxLeap/MLSmsCodeUtils.h>
#import <MaxLeap/MLCloudCode.h>
#import <MaxLeap/MLFile.h>
#import <MaxLeap/MLPrivateFile.h>
#import <MaxLeap/MLConfig.h>
#import <MaxLeap/MLEmail.h>
#import <MaxLeap/MLReceiptManager.h>
#import <MaxLeap/MLMarketingManager.h>
#import <MaxLeap/MLLogger.h>
#import <MaxLeap/MLAnalytics.h>
#import <MaxLeap/MLGameAnalytics.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 The main SDK class to config MaxLeap framework.
 */
@interface MaxLeap : NSObject

/**
 *  Sets the applicationId, clientKey and site of your application.
 *
 *  @param applicationId The application id for your MaxLeap application.
 *  @param clientKey     The client key for your MaxLeap application.
 *  @param site          One of the enumerator constants MLSiteUS (United States), MLSiteCN (Japan) based on your desired location.
 */
+ (void)setApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey site:(MLSite)site;

/*!
 The current application id that was used to configure MaxLeap framework.
 */
+ (NSString *)applicationId;

/*!
 The current client key that was used to configure MaxLeap framework.
 */
+ (NSString *)clientKey;

/**
 *  get the timeout interval for MaxLeap request
 *
 *  @return timeout interval
 */
+ (NSTimeInterval)networkTimeoutInterval;

/**
 *  set the timeout interval for MaxLeap request
 *
 *  @param timeoutInterval timeout interval
 */
+ (void)setNetworkTimeoutInterval:(NSTimeInterval)timeoutInterval;

@end

NS_ASSUME_NONNULL_END
