//
//  JSONResponseParser.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Transloadit Ltd. All rights reserved.
//

#import "JSONResponseParser.h"
#import "TransloaditLogger.h"

@implementation JSONResponseParser

- (id)initWithString:(NSString *)something
{
    if (self = [super init]) {
        response = something;
    }
    return self;
}

- (NSString *)getResponse { return response; }

- (void)setResponse:(NSString *)_response { response = _response; }

- (NSDictionary *)parse
{
    if (!response)
        return nil;

    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSASCIIStringEncoding] options:kNilOptions error:&error];
    if (jsonDict == nil || error != nil) {
        TRANSLOADIT_LOG_ERROR(self.class, error);
        return nil;
    }
    return jsonDict;
}

@end
