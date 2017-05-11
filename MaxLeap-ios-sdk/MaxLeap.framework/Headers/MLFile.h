//
//  MLFile.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLConstants.h>
#else
    #import <MaxLeap/MLConstants.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/*!
 A file of binary data stored on the MaxLeap servers. This can be a image, video, or anything else
 that an application needs to reference in a non-relational way.
 */
@interface MLFile : NSObject

/** @name Creating a MLFile */

/*!
 Creates a file with given data. A name will be assigned to it by the server.
 @param data The contents of the new MLFile.
 @result A MLFile.
 */
+ (instancetype)fileWithData:(NSData *)data;

/*!
 Creates a file with given data and name.
 @param name The name of the new MLFile.
 @param data The contents of hte new MLFile.
 @result A MLFile.
 */
+ (instancetype)fileWithName:(nullable NSString *)name data:(NSData *)data;

/*!
 Creates a file with the contents of another file.
 @param name The name of the new MLFile
 @param path The path to the file that will be uploaded to MaxLeap
 */
+ (instancetype)fileWithName:(nullable NSString *)name contentsAtPath:(NSString *)path;

/*!
 The name of the file.
 */
@property (readonly, copy, nullable) NSString *name;

/*!
 The url of the file.
 */
@property (readonly, copy, nullable) NSString *url;

@property (readonly) long long size;

/*!
 Whether the file has been uploaded for the first time.
 */
@property (readonly) BOOL isDirty;

/*!
 Whether the data is available in memory or needs to be downloaded.
 */
@property (readonly) BOOL isDataAvailable;

#pragma mark -
///--------------------------------------
/// @name Storing Data with MaxLeap
///--------------------------------------

/*!
 Saves the file asynchronously and executes the given block.
 
 @param block   The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)saveInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/*!
 Saves the file asynchronously and executes the given resultBlock. Executes the progressBlock periodically with the percent
 progress. progressBlock will get called with 100 before resultBlock is called.
 
 @param block   The block should have the following argument signature: (BOOL succeeded, NSError *error)
 @param progressBlock The block should have the following argument signature: (int percentDone)
 */
- (void)saveInBackgroundWithBlock:(nullable MLBooleanResultBlock)block progressBlock:(nullable MLProgressBlock)progressBlock;

#pragma mark -
///--------------------------------------
/// @name Getting Data from MaxLeap
///--------------------------------------

/*!
 Synchronously gets the data from cache if available or fetches its contents from the MaxLeap servers. Sets an error if it occurs.
 
 @param error   Pointer to an NSError that will be set if necessary.
 @result The data of file. Returns nil if there was an error in fetching.
 */
- (nullable NSData *)getData:(NSError  * __nullable * __nullable)error;

/*!
 Asynchronously gets the data from cache if available or fetches its contents
 from the MaxLeap servers. Executes the given block.
 
 @param block   The block should have the following argument signature: (NSData *result, NSError *error)
 */
- (void)getDataInBackgroundWithBlock:(nullable MLDataResultBlock)block;

/*!
 This method is like getDataInBackgroundWithBlock: but avoids ever holding the
 entire MLFile's contents in memory at once. This can help applications with
 many large MLFiles avoid memory warnings.
 
 @param block   The block should have the following argument signature: (NSInputStream *result, NSError *error)
 */
- (void)getDataStreamInBackgroundWithBlock:(nullable MLDataStreamResultBlock)block;

/*!
 Asynchronously gets the data from cache if available or fetches its contents
 from the MaxLeap servers. Executes the resultBlock upon
 completion or error. Executes the progressBlock periodically with the percent progress. progressBlock will get called with 100 before resultBlock is called.
 
 @param resultBlock     The block should have the following argument signature: (NSData *result, NSError *error)
 @param progressBlock   The block should have the following argument signature: (int percentDone)
 */
- (void)getDataInBackgroundWithBlock:(nullable MLDataResultBlock)resultBlock progressBlock:(nullable MLProgressBlock)progressBlock;

/*!
 This method is like getDataInBackgroundWithBlock:progressBlock: but avoids ever
 holding the entire MLFile's contents in memory at once. This can help
 applications with many large MLFiles avoid memory warnings.
 
 @param resultBlock     The block should have the following argument signature: (NSInputStream *result, NSError *error)
 @param progressBlock   The block should have the following argument signature: (int percentDone)
 */
- (void)getDataStreamInBackgroundWithBlock:(nullable MLDataStreamResultBlock)resultBlock progressBlock:(nullable MLProgressBlock)progressBlock;

#pragma mark -
///--------------------------------------
/// @name Interrupting a Transfer
///--------------------------------------

/*!
 Cancels the current request (whether upload or download of file data).
 */
- (void)cancel;

#pragma mark -
///--------------------------------------
/// @name Other Methods
///--------------------------------------

/*!
 Get file with specified name.
 
 @param name    The name of a file.
 @param block   The block will execute on main thread.
 */
+ (void)getFileInBackgroundWithName:(NSString *)name block:(nullable MLFileResultBlock)block;

/*!
 Get all files uploaded by current user.
 
 @param block The callback, will be executed on main thread. The block should have the following argument signature: (NSArray<MLFile *> *files, NSError *error).
 */
+ (void)getAllInBackgroundWithBlock:(nullable MLArrayResultBlock)block;

@end

NS_ASSUME_NONNULL_END
