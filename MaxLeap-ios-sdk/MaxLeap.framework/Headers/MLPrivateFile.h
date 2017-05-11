//
//  MLPrivateFile.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLConstants.h>
#else
    #import <MaxLeap/MLConstants.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 *  A MaxLeap Framework object that represents metadata of private file.
 */
@interface MLPrivateFile : NSObject

#pragma mark -
///--------------------------------------
/// @name Creating a Private File
///--------------------------------------

/**
 *  Initialize a privateFile with localPath and remotePath.
 *
 *  @param localPath  The path of the file on local disk.
 *  @param remotePath The path of the file on remote server, shouldn't be nil.
 *
 *  @return A private file instance.
 */
- (instancetype)initWithLocalFileAtPath:(nullable NSString *)localPath remotePath:(NSString *)remotePath NS_DESIGNATED_INITIALIZER;

/**
 *  Create a privateFile with remotePath.
 *
 *  @param remotePath The path of the file on remote server, shouldn't be nil.
 *
 *  @return A private file instance
 */
+ (instancetype)fileWithRemotePath:(NSString *)remotePath;

#pragma mark -
///--------------------------------------
/// @name Properties - File Metadata
///--------------------------------------

/**
 *  A formated string representing the item size, eg: "1.1 MB", "832.5 KB".
 */
@property (nonatomic, readonly, nullable) NSString *size;

/**
 *  A number indicates the size of item in bytes.
 */
@property (nonatomic, readonly) NSUInteger bytes;

/**
 *  The file's MIMEType.
 */
@property (nonatomic, readonly, nullable) NSString *MIMEType;

/**
 *  Hash of the source file.
 */
@property (nonatomic, copy, nullable) NSString *fileHash;

/**
 *  When the file or directory was created.
 */
@property (nonatomic, readonly, nullable) NSDate *createdAt;

/**
 *  When the file or directory was last updated.
 */
@property (nonatomic, readonly, nullable) NSDate *updatedAt;

/**
 *  The item's path on remote server.
 */
@property (nonatomic, readonly) NSString *remotePath;

/**
 *  The local path of the item.
 */
@property (nonatomic, copy, nullable) NSString *localPath;

/**
 *  Whether this item is a directory.
 */
@property (nonatomic, readonly) BOOL isDirectory;

/**
 *  The contents of the dir. If this item is not a directory, contents is nil.
 */
@property (nonatomic, readonly, nullable) NSArray *contents;

/**
 *  Whether the item is deleted from remote server.
 */
@property (nonatomic, readonly) BOOL isDeleted;

/**
 *  Whether the item is shared from another user.
 */
@property (nonatomic, readonly) BOOL isShared;

/**
 *  The id of user who shared this item.
 */
@property (nonatomic, readonly, nullable) NSString *shareFrom;

/**
 *  The share url.
 */
@property (nonatomic, readonly, nullable) NSURL *url;

#pragma mark -
/*! @name Upload Private Files */

/**
 *  *Asynchronously* upload file at file.localPath to MaxLeap file servers.
 *
 *  @disscussion If the file's fileHash is not set, the md5 of file will be calculated and used.
 *  If file exists on remote path, the uploading will fail with a kMLErrorPathTaken error.
 *
 *  @param block Block to excute on main thread after uploading file, it should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)saveInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  *Asynchronously* upload file at file.localPath and save at the file.remotePath on MaxLeap file servers.
 *
 *  @disscussion If the file's fileHash is not set, the md5 of file will be calculated and used.
 *  If file exists on remote path, it will be overwrite.
 *
 *  @param block Block to excute on main thread after uploading file, it should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)saveAndOverwriteInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  *Asynchronously* upload file at file.localPath and save at the file.remotePath on MaxLeap file servers.
 *
 *  @disscussion If the file's fileHash is not set, the md5 of file will be calculated and used.
 *  If file exists on remote path, the uploading will fail with a kMLErrorPathTaken error.
 *
 *  @param block            Block to excute on main thread after uploading file, it should have the following argument signature: (BOOL success, NSError *error)
 *  @param progressBlock    Block to notify the upload progress, it should have the following argument signature: (int percentDone)
 */
- (void)saveInBackgroundWithBlock:(nullable MLBooleanResultBlock)block progressBlock:(nullable MLProgressBlock)progressBlock;

/**
 *  *Asynchronously* upload file at file.localPath and save at the file.remotePath on MaxLeap file servers.
 *
 *  @disscussion If the file's fileHash is not set, the md5 of file will be calculated and used.
 *  If file exists on remote path, it will be overwrite.
 *
 *  @param block            Block to excute on main thread after uploading file, it should have the following argument signature: (BOOL success, NSError *error)
 *  @param progressBlock    Block to notify the upload progress, it should have the following argument signature: (int percentDone)
 */
- (void)saveAndOverwriteInBackgroundWithBlock:(nullable MLBooleanResultBlock)block progressBlock:(nullable MLProgressBlock)progressBlock;

#pragma mark -
/*! @name Download Private Files */

/**
 *  Download and save the data at file.localPath. If the local path is nil, default path will be used.
 *
 *  @param block Block to excute after file downloading. It should have the following argument signature: (NSString *filePath, NSError *error)
 */
- (void)downloadInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  Download and save the data at file.localPath. If the local path is nil, default path will be used.
 *
 *  @param block         Block to excute after file downloading. It should have the following argument signature: (NSString *filePath, NSError *error)
 *  @param progressBlock Block to notify the upload progress, it should have the following argument signature: (int percentDone)
 */
- (void)downloadInBackgroundWithBlock:(nullable MLBooleanResultBlock)block progressBlock:(nullable MLProgressBlock)progressBlock;

/*!
 Cancels the current request (whether upload or download of file data).
 */
- (void)cancel;

#pragma mark -
/*! @name Delete Private Files */

/**
 *  Delete the file at file.remotePath from remote server.
 *
 *  @param block Block to excute after deleting, it should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)deleteInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  Delete the file at the path from remote server.
 *
 *  @param path  the remote path to delete
 *  @param block Block to excute after deleting, it should have the following argument signature: (BOOL success, NSError *error)
 */
+ (void)deletePathInBackground:(NSString *)path block:(nullable MLBooleanResultBlock)block;

/**
 *  Deletes a collection of files all at once asynchronously and excutes the block when done.
 *
 *  @param filePaths The remote paths of files to delete.
 *  @param block     The block should have the following argument signature: (BOOL success, NSError *error)
 */
+ (void)deleteAllInBackground:(nullable NSArray ML_GENERIC(NSString*) *)filePaths
                        block:(void (^)(BOOL isAllDeleted, NSArray ML_GENERIC(NSString*) *deleted, NSError *__nullable error))block;

#pragma mark -
/*! @name Get Metadata of a Private File */

/**
 *  Gets the metadata of a file and then excutes the block.
 *
 *  @param block             The block should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)getMetadataInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  Gets the metadata of a file including its children if it's a directory and then excutes the block.
 *
 *  @param block             The block should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)getMetadataIncludeChildrenInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

/**
 *  Gets the metadata of a file and excutes the block when done.
 *
 *  @param skip     The number of file metadata to skip before returning any.
 *  @param limit    A limit on the number of file metadata to return. The default limit is 200, with a maximum of 2000 results being returned at a time.
 *  @param block    The block should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)getMetadataInBackgroundWithSkip:(int)skip andLimit:(int)limit block:(nullable MLBooleanResultBlock)block;

#pragma mark -
/*! @name Get usage */

/**
 *  Get the usage of current user.
 *
 *  @param block The block parameter represents usage of current user. It has 3 parameters. 1. fileCount: How many private files the current user save on MaxLeap file servers. 2. usedCapacity: The capacity current user used in bytes. 3. error: If there is an error, both fileCount and usedCapacity are -1.
 */
+ (void)getUsage:(MLUsageResultBlock)block;

#pragma mark -
/*! @name Copy Private Files */

/**
 *  Copys a file to another remote path.
 *
 *  @param dstPath The destination remote path.
 *  @param block   Block should have the following argument signature: (MLPrivateFile *newFile, NSError *error)
 */
- (void)copyToPathInBackground:(NSString *)dstPath block:(nullable MLPrivateFileResultBlock)block;

/**
 *  Copys a collection of private files at `scrPaths` to remote paths `dstPaths`. The result will pass in the `block`.
 *  The block has three parameters: `isAllCompleted` indicates whether all files was copied; `completed` contains an array of path pairs which was copied successfully, its structure: [{"from":scrPath, "to":dstPath}]; `error` is nil unless the network request failed or `scrPaths` does not match with `dstPaths`.
 *
 *  @param scrPaths        An array of private file remote path.
 *  @param dstPaths        An orderedSet of destination remote path. These paths must match with scrPaths.
 *  @param block           Block should have the following argument signature: (BOOL isAllCompleted, NSArray *completed, NSError *error)
 */
+ (void)copyAllInBackground:(nullable NSArray ML_GENERIC(NSString*) *)scrPaths
                    toPaths:(nullable NSOrderedSet ML_GENERIC(NSString*) *)dstPaths
                      block:(void(^)(BOOL isAllCompleted, NSArray ML_GENERIC(NSString*) *completed, NSError *__nullable error))block;

#pragma mark -
/*! @name Move Private Files */

/**
 *  Moves a file to another remote path.
 *
 *  @param dstPath The destination remote path.
 *  @param block   Block should have the following argument signature: (MLPrivateFile *newFile, NSError *error)
 */
- (void)moveToPathInBackground:(NSString *)dstPath block:(nullable MLBooleanResultBlock)block;

/**
 *  Moves a collection of private files at `scrPaths` to remote paths `dstPaths`. The result will pass in the `block`.
 *  The block has three parameters: `isAllCompleted` indicates whether all files was moved; `completed` contains an array of path pairs which was copied successfully, its structure: [{"from":scrPath, "to":dstPath}]; `error` is nil unless the network request failed or `scrPaths` does not match with `dstPaths`.
 *
 *  @param scrPaths        An array of private file remote path.
 *  @param dstPaths        An orderedSet of destination remote path. These paths must match with `scrPaths`.
 *  @param block           Block should have the following argument signature: (BOOL isAllCompleted, NSArray *completed, NSError *error)
 */
+ (void)moveAllInBackground:(nullable NSOrderedSet ML_GENERIC(NSString*) *)scrPaths
                    toPaths:(nullable NSOrderedSet ML_GENERIC(NSString*) *)dstPaths
                      block:(void(^)(BOOL isAllCompleted, NSArray ML_GENERIC(NSString*) *completed, NSError *__nullable error))block;

#pragma mark -
/*! @name Create Folder */

/**
 *  Create a folder at remote path file.remotePath.
 *
 *  @param path  The remote path of a directory.
 *  @param block Block should have the following argument signature: (BOOL success, NSError *error)
 */
+ (void)createFolderAtPathInBackground:(NSString *)path block:(nullable MLPrivateFileResultBlock)block;

#pragma mark -
/*! @name Share (Mock) */

/**
 *  Share a file or directory. (Mock)
 *
 *  @param block Block should have the following argument signature: (BOOL success, NSError *error)
 */
- (void)shareInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END

