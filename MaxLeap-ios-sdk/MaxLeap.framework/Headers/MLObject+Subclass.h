//
//  MLObject+Subclass.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLObject.h>
#else
    #import <MaxLeap/MLObject.h>
#endif

@class MLQuery;

NS_ASSUME_NONNULL_BEGIN

/*!
 <h3>Subclassing Notes</h3>
 
 Developers can subclass MLObject for a more native object-oriented class structure. Strongly-typed subclasses of MLObject must conform to the MLSubclassing protocol and must call registerSubclass to be returned by MLQuery and other MLObject factories. All methods in MLSubclassing except for +[MLSubclassing leapClassName] are already implemented in the MLObject(Subclass) category. Inculding MLObject+Subclass.h in your implementation file provides these implementations automatically.<br>
 
 Subclasses support simpler initializers, query syntax, and dynamic synthesizers. The following shows an example subclass:<br>
 
    @interface MYGame : MLObject <MLSubclassing>
 
    // Accessing this property is the same as objectForKey:@"title"
    @property (retain) NSString *title;
 
    + (NSString *)leapClassName;
 
    @end
 
    @implementation MYGame
 
    @dynamic title;
 
    + (NSString *)leapClassName {
        return @"Game";
    }
 
    @end
 
    MYGame *game = [[MYGame alloc] init];
    game.title = @"Bughouse";
    [game saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
 
        } else {
 
        }
    }];
 */
@interface MLObject (Subclass)

/*! @name Methods for Subclasses */

/*!
 Designated initializer for subclasses.<br>
 This method can only be called on subclasses which conform to MLSubclassing.<br>
 This method should not be overridden.
 */
- (id)init;

/*!
 Creates an instance of the registered subclass with this class's leapClassName.<br>
 
 This helps a subclass ensure that it can be subclassed itself. For example, [MLUserobject] will return a MyUser object if MyUser is a registered subclass of MLUser. For this reason, [MyClass object] is preferred to [[MyClass alloc] init].<br>
 
 This method can only be called on subclasses which conform to MLSubclassing.<br>
 
 A default implementation is provided by MLObject which should always be sufficient.
 */
+ (instancetype)object;

/*! The name of the class as seen in the REST API. */
+ (NSString *)leapClassName;

/*!
 Creates a reference to an existing MLObject for use in creating associations between MLObjects.  Calling isDataAvailable on this object will return NO until fetchIfNeeded has been called.  No network request will be made.<br>
 
 This method can only be called on subclasses which conform to MLSubclassing.<br>
 
 A default implementation is provided by MLObject which should always be sufficient.
 
 @param objectId The object id for the referenced object.
 @return A MLObject without data.
 */
+ (instancetype)objectWithoutDataWithObjectId:(nullable NSString *)objectId;

/*!
 Registers an Objective-C class for MaxLeap to use for representing a given MaxLeap class.<br>
 
 Once this is called on a MLObject subclass, any MLObject MaxLeap creates with a class name matching [self leapClassName] will be an instance of subclass.<br>
 
 This method can only be called on subclasses which conform to MLSubclassing.<br>
 
 A default implementation is provided by MLObject which should always be sufficient.
 */
+ (void)registerSubclass;

/*!
 Returns a query for objects of type +leapClassName.<br>
 
 This method can only be called on subclasses which conform to MLSubclassing.<br>
 
 A default implementation is provided by MLObject which should always be sufficient.
 */
+ (nullable MLQuery *)query;

@end

NS_ASSUME_NONNULL_END
