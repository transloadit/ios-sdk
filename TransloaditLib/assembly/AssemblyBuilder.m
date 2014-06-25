//
//  AssemblyBuilder.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Transloadit Ltd. All rights reserved.
//

#import "AssemblyBuilder.h"
#import "TransloaditLogger.h"
#import "TransloaditError.h"

@implementation AssemblyBuilder

/**Prefix for autogenerated file keys*/
#define FILENAME_KEY_POSTFIX @""

/**Postfix for autogenerated file keys*/
#define FILENAME_KEY_PREFIX @"file_"

#define DEFAULT_EXPIRATION_MINUTES 120

- (id)init
{
    if (self = [super init]) {
        fileIncrement = 0;

        auth = [[NSMutableDictionary alloc] init];
        steps = [[OrderedDictionary alloc] init];
        data = [[ApiData alloc] init];

        [data.params setObject:auth forKey:@"auth"];
        [data.params setObject:@"true" forKey:@"blocking"];

        NSDate *time = [[NSDate alloc] init];

        [self setAuthExpires:[time dateByAddingTimeInterval:DEFAULT_EXPIRATION_MINUTES * 60]];
    }

    return self;
}

- (void)addFile:(NSData *)file withError:(NSError *)error
{
    NSString *key = [NSString stringWithFormat:@"%@%d%@", FILENAME_KEY_PREFIX, (fileIncrement++), FILENAME_KEY_POSTFIX];

    [self addFileWithName:key file:file withError:error];

    if (error != nil) {
        TRANSLOADIT_LOG_ERROR(self.class, error);
    }
}

- (void)addFileWithName:(NSString *)key file:(NSData *)file withError:(NSError *)error
{

    if ([self validKey:key]) {
        if ([data.fields objectForKey:key] != nil || [data.files objectForKey:key] != nil) {
            TRANSLOADIT_LOG_INFO(self.class, @"Autogenerated key will be used for %@ file with key %@, because the specified key is already defined.", file,
                                 key);

            [self addFile:file withError:error];
        } else {
            [data.files setObject:file forKey:key];
        }

    } else {
        error = [TransloaditError createError:ERROR_CODE_INVALID_FIELD_KEY];

        TRANSLOADIT_LOG_ERROR(self.class, error);
    }
}

- (void)addStepName:(NSString *)name step:(NSObject<IStep> *)step { [steps setObject:[step getDictionary] forKey:name]; }

- (bool)hasNotifyUrl { return [data.params objectForKey:@"notify_url"] != nil; }

- (bool)hasTemplateID { return [data.params objectForKey:@"template_id"] != nil; }

- (void)setAuthExpires:(NSDate *)dateTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss+00:00"];

    [auth setObject:[dateFormatter stringFromDate:dateTime] forKey:@"expires"];
}

- (void)setAuthKey:(NSString *)key { [auth setObject:key forKey:@"key"]; }

- (void)setSignature:(NSString *)signature { [data.fields setObject:signature forKey:@"signature"]; }

- (void)setAuthMaxSize:(int)maxSize { [auth setObject:[@(maxSize) description] forKey:@"max_size"]; }

- (void)setFieldKey:(NSString *)key value:(NSString *)value withError:(NSError *)error
{
    if ([self validKey:key]) {
        if ([data.files objectForKey:key] == nil) {
            [data.fields setObject:value forKey:key];

        } else {
            error = [TransloaditError createError:ERROR_CODE_ALREADY_DEFINED_KEY];

            TRANSLOADIT_LOG_ERROR(self.class, error);
        }

    } else {
        error = [TransloaditError createError:ERROR_CODE_INVALID_FIELD_KEY];

        TRANSLOADIT_LOG_ERROR(self.class, error);
    }
}

- (void)setNotifyURL:(NSString *)notifyURL
{
    if (notifyURL != nil) {
        [data.params setObject:notifyURL forKey:@"notify_url"];
    } else {
        [data.params removeObjectForKey:@"notify_url"];
    }
}

- (void)setTemplateID:(NSString *)templateID
{
    if (templateID != nil) {
        [data.params setObject:templateID forKey:@"template_id"];
    } else {
        [data.params removeObjectForKey:@"template_id"];
    }
}

- (ApiData *)toApiData
{
    if ([self hasSteps]) {
        [data.params setObject:steps forKey:@"steps"];
    }

    return data;
}

- (bool)hasSteps { return [steps count] > 0; }

/**Validates the passed key
 *
 * @param key Key to be validated
 * @throws InvalidFieldKeyException Thrown when an invalid (reserved) field key is tried to be used
 */
- (bool)validKey:(NSString *)key
{
    NSArray *invalidKeys = [NSArray arrayWithObjects:@"params", @"template_id", @"notify_url", @"signature", nil];

    return [invalidKeys indexOfObjectIdenticalTo:key] == NSNotFound;
}

@end
