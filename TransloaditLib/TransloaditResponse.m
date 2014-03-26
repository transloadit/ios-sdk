//
//  TransloaditResponse.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "TransloaditResponse.h"
#import "TransloaditLogger.h"
#import "JSONResponseParser.h"

@implementation TransloaditResponse


-(id)init:(NSString*)_responseString withParser:(NSObject<IResponseParser>*)parser withError:(NSError*)error;
{
    if (self = [super init])
	{
        success=false;
        
        responseString=_responseString;
        
        [parser setResponse:responseString];
        
        data=[parser parseWithError:error];
        
        if(error==nil && [data objectForKey:@"ok"]!=nil)
        {
            success = true;
        }else
        {
            TRANSLOADIT_LOG_ERROR(self.class, error);
        }
    }
    
    return self;
    
}

-(id)init:(NSString*)_responseString withError:(NSError*)error
{
    if (self = [super init])
	{
        success=false;
        
        responseString=_responseString;
        
        NSObject<IResponseParser>* parser=[[JSONResponseParser alloc] init];
        
        [parser setResponse:responseString];
        
        data=[parser parseWithError:error];
        
        if(error==nil && [data objectForKey:@"ok"]!=nil)
        {
            success = true;
        }else
        {
            TRANSLOADIT_LOG_ERROR(self.class, error);
        }
    }
    
    return self;
    
}

-(NSString*)getResponseString
{
    return responseString;
}

-(NSDictionary*)getData
{
    return data;
}

-(bool)isSuccess
{
    return success;
}

@end
