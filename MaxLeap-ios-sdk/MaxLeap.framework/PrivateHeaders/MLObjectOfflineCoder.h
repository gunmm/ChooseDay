//
//  MLObjectPersistanceUtils.h
//  MaxLeap
//

#import <Foundation/Foundation.h>

@interface MLObjectOfflineCoder : NSObject

+ (id)encodeObject:(id)object;
+ (id)decodeObject:(id)object;

@end
