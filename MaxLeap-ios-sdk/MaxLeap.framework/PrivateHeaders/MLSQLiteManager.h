//
//  MLSQLiteManager.h
//  MaxLeap
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MLSQLiteErrorCodes) {
	kDBNotExists,
	kDBFailAtOpen,
	kDBFailAtCreate,
	kDBErrorQuery,
	kDBFailAtClose
};

@interface MLSQLiteManager : NSObject

- (id)initWithDatabaseNamed:(NSString *)name;

// SQLite Operations
- (NSError *)openDatabase;
- (NSError *)closeDatabase;

- (NSError *)doUpdateQuery:(NSString *)sql withParams:(NSArray *)params;
- (NSArray *)getRowsForQuery:(NSString *)sql withParams:(NSArray *)params;

- (NSInteger)getLastInsertRowID;
- (NSString *)getDatabaseDump;

@end
