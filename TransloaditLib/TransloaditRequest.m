//
//  TransloaditRequest.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "TransloaditRequest.h"
#import "DefaultHttpExecutor.h"
#import "JSONRequestParser.h"
#import "TransloaditResponse.h"
#import "TransloaditLogger.h"

@implementation TransloaditRequest

-(id)init
{
	if (self = [super init])
	{
        url=[[NSURL alloc] initWithScheme:DEFAULT_SCHEME host:DEFAULT_HOST path:ASSEMBLY_ROOT];
	}

	return self;
}

-(NSObject<IApiResponse>*)executeWithError:(NSError *)error
{
    DefaultHttpExecutor* executor=[[DefaultHttpExecutor alloc] init];
    
    [executor setUrl:[self getURL]];
    
    [executor setMethod:[self getMethod]];
    
    NSString* response=[executor execute:[[ParsedApiData alloc] initWithApiData:[self getData] parser:[self getParser]] withError:error];
    
    if(error!=nil)
    {
        TRANSLOADIT_LOG_ERROR(self.class, error);
        
        return nil;
    }
    
    return [[TransloaditResponse alloc] init:response withError:error];
    
}

-(ApiData*)getData
{
    return data;
}

-(RequestMethod)getMethod
{
    return method;
}

-(NSURL*)getURL
{
    return url;
}

-(void)setPath:(NSString *)path
{
    url=[[NSURL alloc] initWithScheme:url.scheme host:url.host path:path];
}

-(void)setHost:(NSString*)host
{
    url=[[NSURL alloc] initWithScheme:url.scheme host:host path:url.path];
}

-(void)setMethod:(RequestMethod)_method
{
    method=_method;
}

-(NSObject<IRequestParser>*)getParser
{
    return [[JSONRequestParser alloc] init];
}

-(void)setData:(ApiData*)_data
{
    data=_data;
}
@end
