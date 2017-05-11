//
//  MLMarketingManager.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
#   import <MaxLeapExt/MLConstants.h>
#else
#   import <MaxLeap/MLConstants.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 *  The dissmiss button on in-app message view is always on top.
 */
typedef NS_ENUM(NSUInteger, MLInAppMessageDismissButtonLocation){
    
    /** top left corner */
    MLInAppMessageDismissButtonLocationLeft,
    
    /** top right corner */
    MLInAppMessageDismissButtonLocationRight
};

/**
 *  Enter point to enable marketing to receive In-App messages and test In-App messages.
 */
@interface MLMarketingManager : NSObject

/** 
 *  Enable the marketing module to receive In-App messages.
 */
+ (void)enable;

#pragma mark - Developer Options
///--------------------------------------
/// @name Developer Options
///--------------------------------------

/** Enable MaxLeap SDK In-App message test mode. In test mode a small
 *  MaxLeap tab will appear on the left side of the screen, enabling a developer to see/test
 *  all campaigns currently available to this customer.
 *  
 *  In test mode, the impression and click on a in-app message will not be recored.
 */
+ (void)enableTestMode;

#pragma mark - Push
///--------------------------------------
/// @name Push
///--------------------------------------

/** Used to record performance data for push notifications
 @param notificationInfo The dictionary from either `didFinishLaunchingWithOptions:` or
 `didReceiveRemoteNotification:` should be passed on to this method.
 */
+ (void)handlePushNotificationOpened:(nullable NSDictionary *)notificationInfo;

#pragma mark - In-App Message
///--------------------------------------
/// @name In-App Message
///--------------------------------------

/** Set the image to be used for dimissing an In-App message
 @param image The image to be used for dismissing an In-App message. By default this is a
 circle with an 'X' in the middle of it
 */
+ (void)setInAppMessageDismissButtonImage:(UIImage *)image;

/** Set the image to be used for dimissing an In-App message by providing the name of the
 image to be loaded and used.
 
 @param imageName The name of an image to be loaded and used for dismissing an In-App
 message. By default the image is a circle with an 'X' in the middle of it
 */
+ (void)setInAppMessageDismissButtonImageWithName:(NSString *)imageName;

/** Set the location of the dismiss button on an In-App msg
 
 @param location The location of the button (left or right)
 @see inAppMessageDismissButtonLocation
 */
+ (void)setInAppMessageDismissButtonLocation:(MLInAppMessageDismissButtonLocation)location;

/** Returns the location of the dismiss button on an In-App msg
 @return InAppDismissButtonLocation
 @see inAppMessageDismissButtonLocation
 */
+ (MLInAppMessageDismissButtonLocation)inAppMessageDismissButtonLocation;

#pragma mark - In-App Message Debugging
+ (void)triggerInAppMessage:(NSString *)triggerName;
+ (void)triggerInAppMessage:(NSString *)triggerName withAttributes:(nullable NSDictionary ML_GENERIC(NSString*, NSString*) *)attributes;

+ (void)dismissCurrentInAppMessage;

@end

NS_ASSUME_NONNULL_END
