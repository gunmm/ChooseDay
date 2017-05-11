//
//  MLInstallation.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLObject.h>
    #import <MaxLeapExt/MLSubclassing.h>
#else
    #import <MaxLeap/MLObject.h>
    #import <MaxLeap/MLSubclassing.h>
#endif

@class MLQuery;

NS_ASSUME_NONNULL_BEGIN

/*!
 An Installation Object is a local representation of an installation persisted to the MaxLeap. This class is a subclass of a MLObject, and retains the same functionality of a MLObject, but also extends it with installation-specific fields and related immutability and validity checks.<br>
 
 A valid MLInstallation can only be instantiated via +[MLInstallation currentInstallation] because the required identifier fields are readonly. The timeZone and badge fields are also readonly properties which are automatically updated to match the device's time zone and application badge when the MLInstallation is saved, thus these fields might not reflect the latest device state if the installation has not recently been saved.<br>
 
 MLInstallation objects which have a valid deviceToken and are saved to the MaxLeap can be used to target push notifications.<br>
 
 This class is currently for iOS only. There is no MLInstallation for MaxLeap applications running on OS X, because they cannot receive push notifications.
 */
@interface MLInstallation : MLObject <MLSubclassing>

/** The name of the Installation class in the REST API. This is a required
 *  MLSubclassing method
 */
+ (NSString *)leapClassName;

/** @name Targeting Installations */

/*!
 Creates a query for MLInstallation objects. The resulting query can only be used for targeting a MLPush. Calling find methods on the resulting query will raise an exception.
 
 @return Return a query for MLInstallation objects.
 */
+ (MLQuery *)query;

/** @name Accessing the Current Installation */

/*!
 Gets the currently-running installation from disk and returns an instance of it. If this installation is not stored on disk, returns a MLInstallation with deviceType and installationId fields set to those of the current installation.
 
 @return Returns a MLInstallation that represents the currently-running installation.
 */
+ (instancetype)currentInstallation;

/** @name Properties */

/*!
 Sets the device token string property from an NSData-encoded token.
 @param deviceTokenData The deviceToken got from `application:didRegisterForRemoteNotificationsWithDeviceToken:` method.
 */
- (void)setDeviceTokenFromData:(nullable NSData *)deviceTokenData;

/// The device type for the MLInstallation.
@property (nonatomic, readonly, strong) NSString *deviceType;

/// The installationId for the MLInstallation.
@property (nonatomic, readonly, strong) NSString *installationId;

/// The device token for the MLInstallation.
@property (nonatomic, strong, nullable) NSString *deviceToken;

/// The badge for the MLInstallation.
@property (nonatomic, assign) NSInteger badge;

/// The timeZone for the MLInstallation.
@property (nonatomic, readonly, strong, nullable) NSString *timeZone;

/// The channels for the MLInstallation.
@property (nonatomic, strong, nullable) NSArray *channels;

@end

NS_ASSUME_NONNULL_END
