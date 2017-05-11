//
//  MLQuery.h
//  MaxLeap
//


#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLConstants.h>
#else
    #import <MaxLeap/MLConstants.h>
#endif

@class MLGeoPoint;

NS_ASSUME_NONNULL_BEGIN

/*!
 A class that defines a query that is used to query for MLObjects.
 */
@interface MLQuery : NSObject

#pragma mark Query options

/** @name Creating a Query for a Class */

/*!
 Returns a MLQuery for a given class.
 
 @param className The class to query on.
 @return A MLQuery object.
 */
+ (MLQuery *)queryWithClassName:(NSString *)className;

/*!
 Creates a MLQuery with the constraints given by predicate.
 
 @param className The class to query on.
 @param predicate The predicate used to construct a query.
 @return A MLQuery object.
 
 @discussion The following types of predicates are supported:<br>
 * Simple comparisons such as =, !=, <, >, <=, >=, and BETWEEN with a key and a constant.<br>
 * Regular expressions, such as LIKE, MATCHES, CONTAINS, or ENDSWITH.<br>
 * Containment predicates, such as "x IN {1, 2, 3}".<br>
 * Key-existence predicates, such as "x IN SELF".<br>
 * BEGINSWITH expressions.<br>
 * Compound predicates with AND, OR, and NOT.<br>
 * SubQueries with "key IN %@", subquery.<br>
 
 The following types of predicates are NOT supported:<br>
 * Aggregate operations, such as ANY, SOME, ALL, or NONE.<br>
 * Predicates comparing one key to another.<br>
 * Complex predicates with many ORed clauses.<br>
 */
+ (MLQuery *)queryWithClassName:(NSString *)className predicate:(nullable NSPredicate *)predicate;

/*!
 Initializes the query with a class name.
 
 @param newClassName The class name.
 */
- (instancetype)initWithClassName:(NSString *)newClassName;

/*!
 The class name to query for
 */
@property (nonatomic, strong) NSString *leapClassName;

/** @name Adding Basic Constraints */

/*!
 Make the query include MLObjects that have a reference stored at the provided key. This has an effect similar to a join.  You can use dot notation to specify which fields in the included object are also fetch.
 
 @param key The key to load child MLObjects for.
 */
- (void)includeKey:(NSString *)key;

/*!
 Make the query restrict the fields of the returned MLObjects to include only the provided keys. If this is called multiple times, then all of the keys specified in each of the calls will be included.
 
 @param keys The keys to include in the result.
 */
- (void)selectKeys:(NSArray ML_GENERIC(NSString*) *)keys;

/*!
 Add a constraint that requires a particular key exists.
 
 @param key The key that should exist.
 */
- (void)whereKeyExists:(NSString *)key;

/*!
 Add a constraint that requires a key not exist.
 
 @param key The key that should not exist.
 */
- (void)whereKeyDoesNotExist:(NSString *)key;

/*!
 Add a constraint to the query that requires a particular key's object to be equal to the provided object.
 
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key equalTo:(id)object;

/*!
 Add a constraint to the query that requires a particular key's object to be less than the provided object.
 
 @param key The key to be constrained.
 @param object The object that provides an upper bound.
 */
- (void)whereKey:(NSString *)key lessThan:(id)object;

/*!
 Add a constraint to the query that requires a particular key's object to be less than or equal to the provided object.
 
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key lessThanOrEqualTo:(id)object;

/*!
 Add a constraint to the query that requires a particular key's object to be greater than the provided object.
 
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key greaterThan:(id)object;

/*!
 Add a constraint to the query that requires a particular key's object to be greater than or equal to the provided object.
 
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key greaterThanOrEqualTo:(id)object;

/*!
 Add a constraint to the query that requires a particular key's object to be not equal to the provided object.
 
 @param key The key to be constrained.
 @param object The object that must not be equalled.
 */
- (void)whereKey:(NSString *)key notEqualTo:(id)object;

/*!
 Add a constraint to the query that requires a particular key's object to be contained in the provided array.
 
 @param key The key to be constrained.
 @param array The possible values for the key's object.
 */
- (void)whereKey:(NSString *)key containedIn:(NSArray *)array;

/*!
 Add a constraint to the query that requires a particular key's object not be contained in the provided array.
 
 @param key The key to be constrained.
 @param array The list of values the key's object should not be.
 */
- (void)whereKey:(NSString *)key notContainedIn:(NSArray *)array;

/*!
 Add a constraint to the query that requires a particular key's array contains every element of the provided array.
 
 @param key The key to be constrained.
 @param array The array of values to search for.
 */
- (void)whereKey:(NSString *)key containsAllObjectsInArray:(NSArray *)array;

/** @name Adding Location Constraints */

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via MLGeoPoint) be near a reference point.  Distance is calculated based on angular distance on a sphere.  Results will be sorted by distance from reference point.
 
 @param key The key to be constrained.
 @param geopoint The reference point.  A MLGeoPoint.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(MLGeoPoint *)geopoint;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via MLGeoPoint) be near a reference point and within the maximum distance specified (in miles).  Distance is calculated based on a spherical coordinate system.  Results will be sorted by distance (nearest to farthest) from the reference point.
 
 @param key The key to be constrained.
 @param geopoint The reference point.  A MLGeoPoint.
 @param maxDistance Maximum distance in miles.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(MLGeoPoint *)geopoint withinMiles:(double)maxDistance;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via MLGeoPoint) be near a reference point and within the maximum distance specified (in kilometers).  Distance is calculated based on a spherical coordinate system.  Results will be sorted by distance (nearest to farthest) from the reference point.
 
 @param key The key to be constrained.
 @param geopoint The reference point.  A MLGeoPoint.
 @param maxDistance Maximum distance in kilometers.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(MLGeoPoint *)geopoint withinKilometers:(double)maxDistance;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via MLGeoPoint) be near a reference point and within the maximum distance specified (in radians).  Distance is calculated based on angular distance on a sphere.  Results will be sorted by distance (nearest to farthest) from the reference point.
 
 @param key The key to be constrained.
 @param geopoint The reference point.  A MLGeoPoint.
 @param maxDistance Maximum distance in radians.
 */
- (void)whereKey:(NSString *)key nearGeoPoint:(MLGeoPoint *)geopoint withinRadians:(double)maxDistance;

/*!
 Add a constraint to the query that requires a particular key's coordinates (specified via MLGeoPoint) be contained within a given rectangular geographic bounding box.
 
 @param key The key to be constrained.
 @param southwest The lower-left inclusive corner of the box.
 @param northeast The upper-right inclusive corner of the box.
 */
- (void)whereKey:(NSString *)key withinGeoBoxFromSouthwest:(MLGeoPoint *)southwest toNortheast:(MLGeoPoint *)northeast;

/** @name Adding String Constraints */

/*!
 Add a regular expression constraint for finding string values that match the provided regular expression. This may be slow for large datasets.
 
 @param key The key that the string to match is stored in.
 @param regex The regular expression pattern to match.
 */
- (void)whereKey:(NSString *)key matchesRegex:(NSString *)regex;

/*!
 Add a regular expression constraint for finding string values that match the provided regular expression. This may be slow for large datasets.
 
 @param key The key that the string to match is stored in.
 @param regex The regular expression pattern to match.
 @param modifiers Any of the following supported PCRE modifiers:<br><code>i</code> - Case insensitive search<br><code>m</code> - Search across multiple lines of input
 */
- (void)whereKey:(NSString *)key matchesRegex:(NSString *)regex modifiers:(nullable NSString *)modifiers;

/*!
 Add a constraint for finding string values that contain a provided substring. This will be slow for large datasets.
 @param key The key that the string to match is stored in.
 
 @param substring The substring that the value must contain.
 */
- (void)whereKey:(NSString *)key containsString:(nullable NSString *)substring;

/*!
 Add a constraint for finding string values that start with a provided prefix. This will use smart indexing, so it will be fast for large datasets.
 
 @param key The key that the string to match is stored in.
 @param prefix The substring that the value must start with.
 */
- (void)whereKey:(NSString *)key hasPrefix:(nullable NSString *)prefix;

/*!
 Add a constraint for finding string values that end with a provided suffix. This will be slow for large datasets.
 
 @param key The key that the string to match is stored in.
 @param suffix The substring that the value must end with.
 */
- (void)whereKey:(NSString *)key hasSuffix:(nullable NSString *)suffix;

/** @name Adding Subqueries */

/*!
 Returns a MLQuery that is the `OR` of the passed in MLQuerys.
 
 @param queries The list of queries to or together.
 @return a MLQuery that is the `OR` of the passed in MLQuerys.
 */
+ (nullable MLQuery *)orQueryWithSubqueries:(nullable NSArray ML_GENERIC(MLQuery*) *)queries;

/*!
 Returns a MLQuery that is the `AND` of the passed in MLQuerys.
 
 @param queries The list of queries to or together.
 @return a MLQuery that is the `AND` of the passed in MLQuerys.
 */
+ (nullable MLQuery *)andQueryWithSubqueries:(nullable NSArray ML_GENERIC(MLQuery*) *)queries;

/*!
 Return a query with negated conditions of the receiver.
 */
- (MLQuery *)notQuery;

/*!
 Adds a constraint that requires that a key's value matches a value in another key in objects returned by a sub query.
 
 @param key The key that the value is stored
 @param otherKey The key in objects in the returned by the sub query whose value should match
 @param query The query to run.
 */
- (void)whereKey:(NSString *)key matchesKey:(NSString *)otherKey inQuery:(MLQuery *)query;

/*!
 Adds a constraint that requires that a key's value NOT match a value in another key in objects returned by a sub query.
 
 @param key The key that the value is stored
 @param otherKey The key in objects in the returned by the sub query whose value should match
 @param query The query to run.
 */
- (void)whereKey:(NSString *)key doesNotMatchKey:(NSString *)otherKey inQuery:(MLQuery *)query;

/*!
 Add a constraint that requires that a key's value matches a MLQuery constraint. This only works where the key's values are MLObjects or arrays of MLObjects.
 
 @param key The key that the value is stored in
 @param query The query the value should match
 */
- (void)whereKey:(NSString *)key matchesQuery:(MLQuery *)query;

/*!
 Add a constraint that requires that a key's value to not match a MLQuery constraint. This only works where the key's values are MLObjects or arrays of MLObjects.
 
 @param key The key that the value is stored in
 @param query The query the value should not match
 */
- (void)whereKey:(NSString *)key doesNotMatchQuery:(MLQuery *)query;

#pragma mark -
#pragma mark Sorting

/** @name Sorting */

/*!
 Sort the results in ascending order with the given key.
 
 @param key The key to order by.
 */
- (void)orderByAscending:(NSString *)key;

/*!
 Also sort in ascending order by the given key.  The previous keys provided will precedence over this key.
 
 @param key The key to order bye
 */
- (void)addAscendingOrder:(NSString *)key;

/*!
 Sort the results in descending order with the given key.
 
 @param key The key to order by.
 */
- (void)orderByDescending:(NSString *)key;

/*!
 Also sort in descending order by the given key.  The previous keys provided will precedence over this key.
 
 @param key The key to order by.
 */
- (void)addDescendingOrder:(NSString *)key;

/*!
 Sort the results in descending order with the given descriptor.
 
 @param sortDescriptor The NSSortDescriptor to order by.
 */
- (void)orderBySortDescriptor:(NSSortDescriptor *)sortDescriptor;

/*!
 Sort the results in descending order with the given descriptors.
 
 @param sortDescriptors An NSArray of NSSortDescriptor instances to order by.
 */
- (void)orderBySortDescriptors:(nullable NSArray ML_GENERIC(NSSortDescriptor*) *)sortDescriptors;

#pragma mark -
#pragma mark Pagination properties

/** @name Paginating Results */
/*!
 A limit on the number of objects to return. The default limit is 100, with a maximum of 1000 results being returned at a time.
 
 Note: If you are calling findObject with limit=1, you may find it easier to use `getFirstObjectInBackgroundWithBlock:` instead.
 */
@property (nonatomic) NSInteger limit;

/*!
 The number of objects to skip before returning any.
 */
@property (nonatomic) NSInteger skip;


#pragma mark -
#pragma mark Query

/** @name Getting Objects by ID */

/**
 *  Gets a <MLObject> asynchronously and calls the given block with the result.
 *
 *  @warning This method mutates the query.
 *
 *  @param objectId The id of the object that is being requested.
 *  @param block    The block to execute. The block should have the following argument signature: `^(NSArray *object, NSError *error)`
 */
- (void)getObjectInBackgroundWithId:(NSString *)objectId block:(nullable MLObjectResultBlock)block;

#pragma mark Find methods

/** @name Getting all Matches for a Query */

/**
 *  Finds objects with the provided query asynchronously and calls the given block with the results.
 *
 *  @param block The block to execute. The block should have the following argument signature:(NSArray *objects, NSError *error)
 */
- (void)findObjectsInBackgroundWithBlock:(nullable MLArrayResultBlock)block;

/** @name Getting the First Match in a Query */

/**
 *  Gets an object asynchronously and calls the given block with the result.<br>
 *
 *  @warning This method mutates the query.
 *
 *  @param block The block to execute. The block should have the following argument signature:(MLObject *object, NSError *error) result will be nil if error is set OR no object was found matching the query. error will be nil if result is set OR if the query succeeded, but found no results.
 */
- (void)getFirstObjectInBackgroundWithBlock:(nullable MLObjectResultBlock)block;

#pragma mark Count methods

/** @name Counting the Matches in a Query */

/*!
 Counts objects asynchronously and calls the given block with the counts.
 
 @warning This method mutates the query.
 
 @param block The block to execute. The block should have the following argument signature: (int count, NSError *error)
 */
- (void)countObjectsInBackgroundWithBlock:(nullable MLIntegerResultBlock)block;

#pragma mark Cancel methods

/** @name Cancelling a Query */

/**
 *  Cancels the current network request (if any). Ensures that callbacks won't be called.
 */
- (void)cancel;

@end

NS_ASSUME_NONNULL_END

