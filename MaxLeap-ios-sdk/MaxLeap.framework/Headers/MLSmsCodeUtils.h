//
//  MLSmsCodeUtils.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLUser.h>
#else
    #import <MaxLeap/MLUser.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface MLSmsCodeUtils : NSObject

/**
 *  Send a sms code to the mobile phone with `phoneNumber`.
 *
 *  @param phoneNumber Phone number to receive the code.
 *  @param block       The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)requestSmsCodeWithPhoneNumber:(NSString *)phoneNumber block:(nullable MLBooleanResultBlock)block;

/**
 *  Verify that the `smsCode` was sent by invoking `requestSmsCodeWithPhoneNumber:block:` and is valid(alive and not be used).
 *
 *  @param smsCode     sms code provided by the user
 *  @param phoneNumber user's phone number
 *  @param block       The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)verifySmsCode:(NSString *)smsCode phoneNumber:(NSString *)phoneNumber block:(nullable MLBooleanResultBlock)block;

@end


@interface MLUser (MLSmsCodeUtils)

///--------------------------------------
/// @name Login with SMS Code
///--------------------------------------

/**
 *  Send a sms code login request asynchronously for a specified mobile phone number. The sms code will send to that mobile phone and then the use can use the code to login without a password.
 *
 *  @param phoneNumber Phone number to receive the code.
 *  @param block       The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)requestLoginSmsCodeWithPhoneNumber:(NSString *)phoneNumber block:(nullable MLBooleanResultBlock)block;

/**
 *  Login with the login sms code. The code can be requested by invoking `requestLoginSmsCodeWithPhoneNumber:block:`.
 *
 *  @param phoneNumber Phone number as username
 *  @param smsCode     The login sms code requested by invoking `requestLoginSmsCodeWithPhoneNumber:block:`.
 *  @param block       The block to execute. The block should have the following argument signature: (MLUser *user, NSError *error)
 */
+ (void)loginWithPhoneNumber:(NSString *)phoneNumber smsCode:(NSString *)smsCode block:(nullable MLUserResultBlock)block;

///--------------------------------------
/// @name Mobile Phone Verify
///--------------------------------------

/**
 *  Send a sms code asynchronously for verifing the user's `mobilePhone`. If the `user[@"mobilePhone"]` exists, a sms code will be sent to that phone which can be used to verify the user's `mobilePhone`.
 *
 *  @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)requestMobilePhoneVerifySmsCodeWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  Verify the `mobilePhone` field of the user. After successfully verifing, the
 *
 *  @param smsCode The sms code requested by invoking `requestMobilePhoneVerifySmsCodeWithBlock:`.
 *  @param block   The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)verifyMobilePhoneWithSmsCode:(NSString *)smsCode block:(nullable MLBooleanResultBlock)block;

///--------------------------------------
/// @name Reset Password with SMS Code
///--------------------------------------

/**
 *  Send a password reset sms code asynchronously for a specified phone number. If a user account exists with that phone number, a sms code which can be used to reset password for the user account will be sent to that phone.
 *
 *  @param phoneNumber The phone number to receive the code.
 *  @param block       The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)requestPasswordResetSmsCodeWithPhoneNumber:(NSString *)phoneNumber block:(nullable MLBooleanResultBlock)block;

/**
 *  Reset password for user account with the `phoneNumber`.
 *
 *  @param phoneNumber The phone number of user account.
 *  @param smsCode     Sms code requested by invoking `requestPasswordResetSmsCodeWithPhoneNumber:block:`
 *  @param password    New password.
 *  @param block       The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
+ (void)resetPasswordWithPhoneNumber:(NSString *)phoneNumber smsCode:(NSString *)smsCode  password:(NSString *)password block:(nullable MLBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
