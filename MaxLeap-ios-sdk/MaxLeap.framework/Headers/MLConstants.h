// MLConstants.h
// Copyright (c) 2014 iLegendsoft. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MLObject, MLUser, MLFile, MLPrivateFile, MLConfig;

///--------------------------------------
/// @name Version
///--------------------------------------

// MaxLeap SDK Version
#define MaxLeap_VERSION @"2.0.8"

///--------------------------------------
/// @name MaxLeap Sites
///--------------------------------------

/**
 * This enum represents MaxLeap server location.
 */
typedef NS_ENUM(int, MLSite) {
    
    /** Use servers in US. */
    MLSiteUS = 0,
    
    /** Use servers in CN. */
    MLSiteCN = 1
};

///--------------------------------------
/// @name Errors
///--------------------------------------

extern NSString * const __nonnull MLErrorDomain;

/*!
 `MLErrorCode` enum contains all custom error codes that are used as `code` for `NSError` for callbacks on all classes.
 
 These codes are used when `domain` of `NSError` that you receive is set to `MLErrorDomain`.
 */
typedef NS_ENUM(NSInteger, MLErrorCode) {
    
    /*! @abstract 1: Internal server error. No information available. */
    kMLErrorInternalServer = 1,
    
    /*! @abstract 100: The connection to the MaxLeap servers failed. */
    kMLErrorConnectionFailed = 100,
    
    /*! @abstract 101: Object doesn't exist, or has an incorrect password. */
    kMLErrorObjectNotFound = 101,
    
    /*! @abstract 102: You tried to find values matching a datatype that doesn't support exact database matching, like an array or a dictionary. */
    kMLErrorInvalidQuery = 102,
    
    /*! @abstract 103: Missing or invalid classname. Classnames are case-sensitive. They must start with a letter, and a-zA-Z0-9_ are the only valid characters. */
    kMLErrorInvalidClassName = 103,
    
    /*! @abstract 104: Missing ObjectId, usually the objectId no introduction in the query time, or objectId is illegal. ObjectId string can only letters, numbers. */
    kMLErrorMissingObjectId = 104,
    
    /*! @abstract 105: Key is reserved. objectId, createdAt, updatedAt.<br> Invalid key name. Keys are case-sensitive. They must start with a letter, and a-zA-Z0-9_ are the only valid characters. */
    kMLErrorInvalidKeyName = 105,
    
    /*! @abstract 106: Invalid format. Date, Pointer, Relation…. */
    kMLErrorInvalidType = 106,
    
    /*! @abstract 107: Malformed json object. A json dictionary is expected. */
    kMLErrorInvalidJSON = 107,
    
    /*! @abstract 108: Tried to access a feature only available internally. */
    kMLErrorCommandUnavailable = 108,
    
    /** @abstract 109: +[MaxLeap setApplicationId:clientKey:] must be called before using the library. */
    kMLErrorCommandNotInitialized = 109,
    
    /** @abstract 110: Update syntax error. */
    kMLErrorInvalidUpdate = 110,
    
    /*! @abstract 111: Field set to incorrect type. */
    kMLErrorIncorrectType = 111,
    
    /*! @abstract 112: Invalid channel name. A channel name is either an empty string (the broadcast channel) or contains only a-zA-Z0-9_ characters and starts with a letter. */
    kMLErrorInvalidChannelName = 112,
    
    /** @abstract 113: BindTo class not found. */
    kMLErrorBindToClassNotFound = 113,
    
    /*! @abstract 115: Push is misconfigured. See details to find out how. */
    kMLErrorPushMisconfigured = 115,
    
    /*! @abstract 116: The object is too large. */
    kMLErrorObjectTooLarge = 116,
    
    /** @abstract 117: The parameters is invalid. */
    kMLErrorInvalidParameter = 117,
    
    /** @abstract 118: ObjectId is invalid. */
    kMLErrorInvalidObjectId = 118,
    
    /*! @abstract 119: That operation isn't allowed for clients. */
    kMLErrorOperationForbidden = 119,
    
    /*! @abstract 120: The results were not found in the cache. */
    kMLErrorCacheMiss = 120,
    
    /*! @abstract 121: An invalid key was used in a nested JSONObject. Keys in NSDictionary values may not include '$' or '.'. */
    kMLErrorInvalidNestedKey = 121,
    
    /*! @abstract 122: Invalid file name. A file name contains only a-zA-Z0-9_. characters and is between 1 and 36 characters. */
    kMLErrorInvalidFileName = 122,
    
    /*! @abstract 124: The request timed out on the server. Typically this indicates the request is too expensive. */
    kMLErrorTimeout = 124,
    
    /*! @abstract 125: The email address was invalid. */
    kMLErrorInvalidEmailAddress = 125,
    
    /** @abstract 136: Role name cannot be changed. */
    kMLErrorRoleNotChangeName = 136,
    
    /*! @abstract 137: A unique field was given a value that is already taken. */
    kMLErrorDuplicateValue = 137,
    
    /*! @abstract 139: Role's name is invalid. */
    kMLErrorInvalidRoleName = 139,
    
    /*! @abstract 140: Exceeded an application quota. Upgrade to resolve. */
    kMLErrorExceededQuota = 140,
    
    /*! @abstract 141: Cloud Code script had an error. */
    kMLScriptError = 141,
    
    /** @abstract 142: Role is not found. */
    kMLErrorRoleNotFound = 142,
    
    /** @abstract 143: The cloud code is not deployed. */
    kMLErrorCloudCodeNotDeployed = 143,
    
    /** @abstract 160: Session token is invalid. */
    kMLErrorInvalidToken = 160,
    
    /*! @abstract 200: Username is missing or empty */
    kMLErrorUsernameMissing = 200,
    
    /*! @abstract 201: Password is missing or empty */
    kMLErrorUserPasswordMissing = 201,
    
    /*! @abstract 202: Username has already been taken */
    kMLErrorUsernameTaken = 202,
    
    /*! @abstract 203: Email has already been taken */
    kMLErrorUserEmailTaken = 203,
    
    /*! @abstract 204: The email is missing, and must be specified */
    kMLErrorUserEmailMissing = 204,
    
    /*! @abstract 205: A user with the specified email was not found */
    kMLErrorUserWithEmailNotFound = 205,
    
    /*! @abstract 206: The user cannot be altered by a client without the session. */
    kMLErrorUserCannotBeAlteredWithoutSession = 206,
    
    /*! @abstract 207: Users can only be created through sign up */
    kMLErrorUserCanOnlyBeCreatedThroughSignUp = 207,
    
    /*! @abstract 208: An existing account already linked to another user. */
    kMLErrorAccountAlreadyLinked = 208,
    
    /** @abstract 210: Password does not match. */
    kMLErrorPasswordMisMatch = 210,
    
    /** @abstract 211: User not found. */
    kMLErrorUserNotFound = 211,
    
    /** @abstract 221: Invalid sms code. */
    kMLErrorInvalidSmsCode = 221,
    
    /*! @abstract 250: User cannot be linked to an account because that account’s ID is not found. */
    kMLErrorLinkedIdMissing = 250,
    
    /*! @abstract 251: A user with a linked (e.g. Facebook) account has an invalid session. */
    kMLErrorInvalidLinkedSession = 251,
    
    /** @abstract 252: No supported account linking service found. */
    kMLErrorUnsupportedSevice = 252,
    
    /** @abstract 253: The authData must be Hash type, not null. */
    kMLErrorInvalidAuthData = 253,
    
    /** @abstract 301: CAPTCHA input is invalid. */
    kMLErrorInvalidCaptcha = 301,
    
    /** @abstract 401: Unauthorized access, no App ID, or App ID and App key verification failed. */
    kMLErrorUnauthorized = 401,
    
    /** @abstract 503: Rate limit exceeded. */
    kMLErrorRateLimit = 503,
    
    /** @abstract 600: The path has already been taken. */
    kMLErrorPathTaken = 600,
    
    /** @abstract 601: The path does not exists. */
    kMLErrorPathNotExist = 601,
    
    /** @abstract 602: Unexpected error. No infomation available. */
    kMLErrorUnexpected = 602,
    
    /** @abstract 90000: No Permission */
    kMLErrorNoPermission = 90000,
    
    /** @abstract 90000: Session token invalid */
    kMLErrorSessionTokenInvalid = 90100,
    
    /** @abstract 90000: Session token expired */
    kMLErrorSessionTokenExpired = 90101,
    
    /** @abstract 90000: AppId and key does not match */
    kMLErrorAppIdAndKeyNotMatch = 90102,
    
    /** @abstract 90000: AppId and session token does not match */
    kMLErrorAppIdAndSessionTokenNotMatch = 90103
};

///--------------------------------------
/// @name Blocks
///--------------------------------------

typedef void (^MLBooleanResultBlock)(BOOL succeeded, NSError *__nullable error);
typedef void (^MLIntegerResultBlock)(int number, NSError *__nullable error);
typedef void (^MLArrayResultBlock)(NSArray *__nullable objects, NSError *__nullable error);
typedef void (^MLDictionaryResultBlock)(NSDictionary *__nullable result, NSError *__nullable error);
typedef void (^MLObjectResultBlock)(MLObject *__nullable object, NSError *__nullable error);
typedef void (^MLUserResultBlock)(MLUser *__nullable user, NSError *__nullable error);
typedef void (^MLDataResultBlock)(NSData *__nullable data, NSError *__nullable error);
typedef void (^MLDataStreamResultBlock)(NSInputStream *__nullable stream, NSError *__nullable error);
typedef void (^MLStringResultBlock)(NSString *__nullable string, NSError *__nullable error);
typedef void (^MLIdResultBlock)(id __nullable object, NSError *__nullable error);
typedef void (^MLProgressBlock)(int percentDone);
typedef void (^MLFileResultBlock)(MLFile *__nullable file, NSError *__nullable error);
typedef void (^MLPrivateFileResultBlock)(MLPrivateFile *__nullable file, NSError *__nullable error);
typedef void (^MLConfigResultBlock)(MLConfig *__nullable config, NSError *__nullable error);
typedef void (^MLUsageResultBlock)(NSInteger fileCount, long usedCapacity, NSError *__nullable error);

#ifndef ML_DEPRECATED
#  ifdef __deprecated_msg
#    define ML_DEPRECATED(_MSG) __deprecated_msg(_MSG)
#  else
#    ifdef __deprecated
#      define ML_DEPRECATED(_MSG) __attribute__((deprecated))
#    else
#      define ML_DEPRECATED(_MSG)
#    endif
#  endif
#endif

#ifndef ML_EXTENSION_UNAVAILABLE
#  ifdef NS_EXTENSION_UNAVAILABLE_IOS
#    define ML_EXTENSION_UNAVAILABLE(_msg) NS_EXTENSION_UNAVAILABLE_IOS(_msg)
#  else
#    define ML_EXTENSION_UNAVAILABLE(_msg)
#  endif
#endif

///--------------------------------------
/// @name Obj-C Generics Macros
///--------------------------------------

#if __has_feature(objc_generics) || __has_extension(objc_generics)
#  define ML_GENERIC(...) <__VA_ARGS__>
#else
#  define ML_GENERIC(...)
#endif
