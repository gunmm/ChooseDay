//
//  MLRelation.h
//  MaxLeap
//


#import <Foundation/Foundation.h>

@class MLQuery, MLObject;

NS_ASSUME_NONNULL_BEGIN

/*!
 A class that is used to access all of the children of a many-to-many relationship. Each instance of MLRelation is associated with a particular parent object and key.
 */
@interface MLRelation : NSObject

/*!
 @abstract The name of the class of the target child objects.
 */
@property (readonly, nonatomic, strong, nullable) NSString *targetClass;


///--------------------------------------
/// @name Accessing Objects
///--------------------------------------

/*!
 @return A MLQuery that can be used to get objects in this relation.
 */
- (nullable MLQuery *)query;


///--------------------------------------
/// @name Modifying Relations
///--------------------------------------

/*!
 Adds a relation to the passed in object.
 
 @param object MLObject to add relation to.
 */
- (void)addObject:(MLObject *)object;

/*!
 Removes a relation to the passed in object.
 
 @param object MLObject to add relation to.
 */
- (void)removeObject:(MLObject *)object;

@end

NS_ASSUME_NONNULL_END
