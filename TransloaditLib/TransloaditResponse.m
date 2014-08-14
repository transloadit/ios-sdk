//
//  TransloaditResponse.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Transloadit Ltd. All rights reserved.
//

#import "TransloaditResponse.h"
#import "TransloaditLogger.h"
#import "JSONResponseParser.h"

@implementation TransloaditResponse

//- (id)initWithString:(NSString *)someString andParser:(NSObject<IResponseParser> *)parser
//{
//    if (self = [super init]) {
//        success = false;
//        responseString = someString;
//        [parser setResponse:responseString];
//
//        NSError *error = nil;
//        data = [parser parseWithError:&error];
//
//        if (error == nil && [data objectForKey:@"ok"] != nil) {
//            success = true;
//        } else {
//            TRANSLOADIT_LOG_ERROR(self.class, error);
//        }
//    }
//
//    return self;
//}

- (id)initWithString:(NSString *)someString;
{
    if (self = [super init]) {
        success = false;
        responseString = someString;

        NSObject<IResponseParser> *parser = [[JSONResponseParser alloc] initWithString:responseString];
        data = [parser parse];

        if (data && [data objectForKey:@"ok"] != nil) {
            success = true;
        }
    }
    return self;
}

- (NSString *)getResponseString { return responseString; }

- (NSDictionary *)getData { return data; }

- (bool)isSuccess { return success; }

@end
