//
//  SSKeychainFix.h
//  MaxLeap
//

#import "ML_SSKeychain.h"

#ifndef ML_SSKeychainFix_h
#define ML_SSKeychainFix_h

typedef ML_SSKeychain                           SSKeychain;
typedef ML_SSKeychainQuery                      SSKeychainQuery;

typedef ML_SSKeychainErrorCode                  SSKeychainErrorCode;
#define SSKeychainErrorBadArguments             ML_SSKeychainErrorBadArguments

typedef ML_SSKeychainQuerySynchronizationMode   SSKeychainQuerySynchronizationMode;
#define SSKeychainQuerySynchronizationModeAny   ML_SSKeychainQuerySynchronizationModeAny
#define SSKeychainQuerySynchronizationModeNo    ML_SSKeychainQuerySynchronizationModeNo
#define SSKeychainQuerySynchronizationModeYes   ML_SSKeychainQuerySynchronizationModeYes

#define kSSKeychainErrorDomain                  ML_kSSKeychainErrorDomain
#define kSSKeychainAccountKey                   ML_kSSKeychainAccountKey
#define kSSKeychainCreatedAtKey                 ML_kSSKeychainCreatedAtKey
#define kSSKeychainClassKey                     ML_kSSKeychainClassKey
#define kSSKeychainDescriptionKey               ML_kSSKeychainDescriptionKey
#define kSSKeychainLabelKey                     ML_kSSKeychainLabelKey
#define kSSKeychainLastModifiedKey              ML_kSSKeychainLastModifiedKey
#define kSSKeychainWhereKey                     ML_kSSKeychainWhereKey

#endif
