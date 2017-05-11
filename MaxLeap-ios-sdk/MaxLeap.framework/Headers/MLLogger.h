//
//  MLLogger.h
//  MaxLeap
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  `MLLogLevel` enum specifies different levels of logging that could be used to limit or display more messages in logs.
 */
typedef NS_ENUM(int, MLLogLevel) {
    /**
     *  Log level that disables all logging.
     */
    MLLogLevelNone = 0,
    /**
     *  Log level that allows error messages to the log.
     */
    MLLogLevelError = 1,
    /**
     *  Log level that allows the following messages to the log:
     *  - Errors
     *  - Warnings
     */
    MLLogLevelWarning = 2,
    /**
     *  Log level that allows the following messages to the log:
     *  - Errors
     *  - Warnings
     *  - Infomational messages
     */
    MLLogLevelInfo = 3,
    /**
     *  Log level that allows the following messages to the log:
     *  - Errors
     *  - Warnings
     *  - Infomational messages
     *  - Debug messages
     */
    MLLogLevelDebug = 4
};

/**
 *  The logger interface.
 */
@protocol MLLogger <NSObject>

@optional

/**
 *  Sets the level of logging to display.
 *
 *  @discussion By default:
 *  - If running inside an app that was downloaded from iOS App Store, it is set to `MLLogLevelNone`.
 *  - All other cases, it is set to `MLLogLevelWarning`.
 *  - When `+[MLLogger setLogLevel:]` get called, it will attempt to call this method on current logger.
 *
 *  @param level Log level to set
 */
- (void)setLogLevel:(MLLogLevel)level;

@required

/**
 *  Display a log message at a specific level for a tag.
 *  If current logging level doesn't include this level, this method will not be called.
 *
 *  @discussion This method must be implemented to provide your own logging logic.
 *
 *  @param tag    Logging tag
 *  @param level  Longging Level
 *  @param format Format to use for the log message
 *  @param args   Log message arguments.
 */
- (void)logMsg_va:(nullable NSString *)tag level:(MLLogLevel)level format:(NSString *)format args:(va_list)args;

@end

/**
 *  `MLLogger` used to display logs.
 */
@interface MLLogger : NSObject <MLLogger>

/**
 *  Current logger that will be used to display log messages.
 *
 *  @return the current logger
 */
+ (id<MLLogger>)currentLogger;

/**
 *  Set the custom logger.
 *
 *  By default, an instance of `MLLogger` is used.
 *
 *  @param logger Logger to set
 */
+ (void)setCurrentLogger:(id<MLLogger>)logger;

/**
 *  Log level that will be displayed.
 *
 *  @discussion By default:
 *  - If running inside an app that was downloaded from iOS App Store, it is set to `MLLogLevelNone`.
 *  - All other cases, it is set to `MLLogLevelWarning`.
 *
 *  @return The current log level.
 */
+ (MLLogLevel)logLevel;

/**
 *  Sets the level of logging to display.
 *
 *  @discussion By default:
 *  - If running inside an app that was downloaded from iOS App Store, it is set to `MLLogLevelNone`.
 *  - All other cases, it is set to `MLLogLevelWarning`.
 *
 *  @param level Log level to set
 */
+ (void)setLogLevel:(MLLogLevel)level;

@end

/**
 *  Display a log message at a specific level for a tag using current logger.
 *
 *  @param tag    Logging tag
 *  @param level  Logging level
 *  @param format Format to use for the log message
 *  @param ...    Log message arguments
 */
FOUNDATION_EXPORT void MLLogMessageTo(NSString *__nullable tag, MLLogLevel level, NSString *format, ...) NS_FORMAT_FUNCTION(3, 4);

/**
 *  Display a log message at a specific level for a tag using current logger.
 *
 *  @param tag          Logging tag
 *  @param level        Logging level
 *  @param functionName The function name that logging this message
 *  @param format       Format to use for the log message
 *  @param ...          Log message arguments
 */
FOUNDATION_EXPORT void MLLogMessageToF(NSString *__nullable tag, MLLogLevel level, const char *functionName, NSString *format, ...) NS_FORMAT_FUNCTION(4, 5);

NS_ASSUME_NONNULL_END

