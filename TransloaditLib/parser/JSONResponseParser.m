//
//  JSONResponseParser.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "JSONResponseParser.h"
#import "TransloaditLogger.h"

@implementation JSONResponseParser


-(id)init:(NSString*)_response
{
    if (self = [super init])
    {
    	response = _response;
    }
    
    return self;
}

-(id)init
{
    self = [super init];
    
    return self;
}


-(NSString*)getResponse
{
    return response;
}

-(void)setResponse:(NSString*)_response
{
    response=_response;
}

-(NSDictionary*)parseWithError:(NSError *)error
{
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSASCIIStringEncoding] options:kNilOptions error:&error];
    
    if(jsonDict==nil || error!=nil)
    {
        TRANSLOADIT_LOG_ERROR(self.class, error);
    }
    
    return jsonDict;
}

@end
