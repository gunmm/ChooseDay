//
//  MLEmail.h
//  MaxLeap
//

#ifdef EXTENSION_IOS
    #import <MaxLeapExt/MLConstants.h>
#else
    #import <MaxLeap/MLConstants.h>
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 * `MLEmail` is a representation of an email.
 */
@interface MLEmail : NSObject

/**
 * The e-mail template name
 */
@property (nonatomic, strong) NSString *templateName;

@property (nonatomic, strong, nullable) NSString *locale;

/**
 * The e-mail sender
 */
@property (nonatomic, strong) NSString *from;

/**
 * The e-mail receivers
 */
@property (nonatomic, strong) NSArray ML_GENERIC(NSString*) *to;

/**
 * The arguments in email subject, defined in the template.
 */
@property (nonatomic, strong, nullable) NSDictionary ML_GENERIC(NSString*, NSString*) *subjectArgs;

/**
 * The text arguments
 */
@property (nonatomic, strong, nullable) NSDictionary ML_GENERIC(NSString*, NSString*) *textArgs;

/**
 * The html arguments
 */
@property (nonatomic, strong, nullable) NSDictionary ML_GENERIC(NSString*, NSString*) *htmlArgs;

/**
 * Create an email with the templateName.
 *
 * @param templateName The template name
 */
- (instancetype)initWithTemplateName:(NSString *)templateName;

/**
 * Send this email.
 *
 * @param block The block to excute after email sending finish.
 */
- (void)sendInBackgroundWithBlock:(nullable MLBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
