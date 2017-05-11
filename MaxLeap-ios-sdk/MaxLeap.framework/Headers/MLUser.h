//
//  MLUser.h
//  MaxLeap
//


#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLObject.h>
    #import <MaxLeapExt/MLConstants.h>
    #import <MaxLeapExt/MLSubclassing.h>
#else
    #import <MaxLeap/MLObject.h>
    #import <MaxLeap/MLConstants.h>
    #import <MaxLeap/MLSubclassing.h>
#endif

@class MLQuery;

NS_ASSUME_NONNULL_BEGIN

/*!
 A MLUser object represent a user persisted to the MaxLeap.<br>
 */
@interface MLUser : MLObject <MLSubclassing>

/*! The name of the MLUserclass in the REST API. This is a required
 *  MLSubclassing method 
 */
+ (NSString *)leapClassName;

/// The session token for the MLUser. This is set by the server upon successful authentication.
@property (nonatomic, strong, nullable) NSString *sessionToken;

/// Whether the MLUserwas just created from a request. This is only set after a Facebook or Twitter login.
@property (readonly, nonatomic) BOOL isNew;

/** @name Accessing the Current User */

/*!
 Gets the currently logged in user from disk and returns an instance of it.
 @return Returns a MLUserthat is the currently logged in user. If there is none, returns nil.
 */
+ (nullable instancetype)currentUser;


/** @name Creating a New User */

/*!
 Creates a new MLUserobject.
 @return Returns a new MLUserobject.
 */
+ (instancetype)user;

/*!
 Whether the user is an authenticated object for the device. An authenticated MLUseris one that is obtained via a signUp or logIn method. An authenticated object is required in order to save (with altered values) or delete it.
 
 @return Returns whether the user is authenticated.
 */
- (BOOL)isAuthenticated;

/**
 *  The username for the MLUser.
 */
@property (nonatomic, strong, nullable) NSString *username;

/**
 The password for the MLUser. This will not be filled in from the server with the password. It is only meant to be set.
 */
@property (nonatomic, strong, nullable) NSString *password;

/**
 *  The email for the MLUser.
 */
@property (nonatomic, strong, nullable) NSString *email;

/**
 *  Whether the email is veriified.
 */
@property (nonatomic, readonly) BOOL emailVerified;

/*!
 Signs up the user asynchronously. Make sure that password and username are set. This will also enforce that the username isn't already taken.
 
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)signUpInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/** @name Logging in */

/*!
 Makes an asynchronous request to log in a user with specified credentials. Returns an instance of the successfully logged in MLUser. This will also cache the user locally so that calls to currentUser will use the latest logged in user.
 
 @param username The username of the user.
 @param password The password of the user.
 @param block The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                                block:(nullable MLUserResultBlock)block;

/** @name Becoming a user */
/*!
 Makes an asynchronous request to become a user with the given session token. Returns an instance of the successfully logged in MLUser. This also caches the user locally so that calls to currentUser will use the latest logged in user. The selector for the callback should look like: myCallback:(MLUser *)user error:(NSError **)error
 
 @param sessionToken The session token for the user.
 @param block The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)becomeInBackgroundWithSessionToken:(NSString *)sessionToken block:(nullable MLUserResultBlock)block;

/** @name Logging Out */

/*!
 Logs out the currently logged in user on disk.
 */
+ (void)logOut;

/** @name Requesting a Password Reset */

/*!
 Send a password reset request asynchronously for a specified email. If a user account exists with that email, an email will be sent to that address with instructions on how to reset their password.
 
 @param email Email of the account to send a reset password request.
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)requestPasswordResetForEmailInBackground:(NSString *)email block:(nullable MLBooleanResultBlock)block;

/** @name Requesting a Email Verify */

/*!
 Send a email verify request asynchronously for a specified email. If a user account exists with that email, an email will be sent to that address with instructions on how to verify their email.
 
 @param email Email of the account to verify.
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)requestEmailVerifyForEmailInBackground:(NSString *)email block:(nullable MLBooleanResultBlock)block;

/**
 *  Check whether the password matches the user.
 *
 *  @param password a password
 *  @param block    The block to execute. The block should have the following argument signature: (BOOL isMatch, NSError *error)
 */
- (void)checkIsPasswordMatchInBackground:(NSString *)password block:(nullable MLBooleanResultBlock)block;


/**
 *  Check the username is exist or not.
 *
 *  @discussion Empty username is not exist becuause it's not valid.
 *
 *  @param username The username to check
 *  @param block    The block to execute. The block should have the following argument signature: (BOOL isExist, NSError *error)
 */
+ (void)checkUsernameExists:(NSString *)username block:(nullable MLBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
