//
//  MLCloudCode.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLConstants.h>
#else
    #import <MaxLeap/MLConstants.h>
#endif

/*!
 The `MLCloudCode` class provides methods for interacting with MaxLeap Cloud Functions.
 */
@interface MLCloudCode : NSObject

/*!
 Calls the given cloud function with the parameters provided asynchronously and calls the given block when it is done.
 @param function The function name to call.
 @param parameters The parameters to send to the function.
 @param block The block to execute. The block should have the following argument signature:(id object, NSError *error).
 */
+ (void)callFunctionInBackground:(nonnull NSString *)function withParameters:(nullable NSDictionary *)parameters block:(nullable MLIdResultBlock)block;

@end
