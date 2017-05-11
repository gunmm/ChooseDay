//
//  MLDeviceHelper.h
//  MaxLeap
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//SAMPLE:SYSTEM_VERSION_EQUAL_TO(@"5.0.1")
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

typedef NS_ENUM(NSInteger, MLDeviceFamily) {
    MLDeviceFamilyiPhone,
    MLDeviceFamilyiPod,
    MLDeviceFamilyiPad,
    MLDeviceFamilyAppleTV,
    MLDeviceFamilyAppleWatch,
    MLDeviceFamilyUnknown = 100,
};

typedef NS_ENUM(NSInteger, MLNetworkStatus) {
    MLNetworkNotReachable = 0,
    MLNetworkReachableViaWWAN,
    MLNetworkReachableViaWifi
};

@interface MLDevice : NSObject

@property (readonly, nonatomic, strong) NSString *identifier;

#pragma mark - hardware infomation
@property (readonly, nonatomic) BOOL isPad;
@property (readonly, nonatomic) BOOL isPhone;

@property (readonly, nonatomic, strong) NSString *modelIdentifier;
@property (readonly, nonatomic, strong) NSString *modelTypeString;
@property (readonly, nonatomic, strong) NSString *model;
@property (readonly, nonatomic) MLDeviceFamily family;

@property (readonly, nonatomic, strong) NSString *mainScreenResolution;

@property (readonly, nonatomic) long long totalDiskSpace;
@property (readonly, nonatomic) long long freeDiskSpace;

@property (readonly, nonatomic) NSUInteger userMemory;
@property (readonly, nonatomic) NSUInteger totalMemory;
@property (readonly, nonatomic) NSUInteger cpuCount;
@property (readonly, nonatomic) NSUInteger busFrequency;
@property (readonly, nonatomic) NSUInteger cpuFrequency;

#pragma mark - software infomation
@property (readonly, nonatomic, strong) NSString *systemName;
@property (readonly, nonatomic, strong) NSString *systemVersion;
@property (readonly, nonatomic) BOOL isJailbroken;

@property (readonly, nonatomic, strong) NSString *networkType;
@property (readonly, nonatomic, strong) NSString *carrierId;

@property (readonly, nonatomic, strong) NSString *preferredLanguageId;
@property (readonly, nonatomic, strong) NSString *currentLocaleId;
@property (readonly, nonatomic, strong) NSString *national;

+ (instancetype)currentDevice;

/**
 * Check if the debugger is attached
 *
 * Taken from https://github.com/plausiblelabs/plcrashreporter/blob/2dd862ce049e6f43feb355308dfc710f3af54c4d/Source/Crash%20Demo/main.m#L96
 *
 * @return `YES` if the debugger is attached to the current process, `NO` otherwise
 */
- (BOOL)isDebuggerAttached;

- (BOOL)isInternetConnectionAvailable;
- (MLNetworkStatus)currentNetworkStatus;

@end
