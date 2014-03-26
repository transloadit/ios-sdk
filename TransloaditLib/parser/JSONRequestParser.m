//
//  JSONRequestParser.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "JSONRequestParser.h"
#import "TransloaditLogger.h"

@implementation JSONRequestParser

-(id)init:(NSDictionary*)_request
{
    if (self = [super init])
    {
    	request = _request;
    }
    
    return self;
}

-(id)init
{
    self = [super init];

    return self;
}

-(NSDictionary*)getRequest
{
    return request;
}

-(void)setRequest:(NSDictionary*)_request
{
    request=_request;
}

-(NSString*)parseWithError:(NSError *)error
{
    NSString *jsonString=nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:request options:0  error:&error];
    
    if (!jsonData || error!=nil)
    {
        TRANSLOADIT_LOG_ERROR(self.class, error);
       
    }else
    {
       jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
