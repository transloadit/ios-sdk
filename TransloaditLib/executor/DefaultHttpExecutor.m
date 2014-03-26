//
//  DefaultHttpExecutor.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "DefaultHttpExecutor.h"
#import "TransloaditLogger.h"

@implementation DefaultHttpExecutor

-(id)init
{
    if (self = [super init])
    {
		method=GET;
    }
    
    return self;
    
}


-(void)setUrl:(NSURL*)_url
{
    url=_url;
}

-(void)setMethod:(RequestMethod) _method
{
    method=_method;
}

-(NSString*)execute:(ParsedApiData*)data withError:(NSError*)error
{
    
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    
    [req setHTTPMethod:REQUEST_METHOD_VALUE(method)];
    
    NSMutableData* body = [NSMutableData data];
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    int len = 64;
    //Creates a random boundary
    NSMutableString *boundary = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [boundary appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    [req setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    
    NSData *boundaryData = [[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding];
    [body appendData:boundaryData];
    
    int i = 0;
    
    NSArray* keys=[data.fields allKeys];
    NSString *key;
    
    for (i=0;i<[keys count];i++)

    {
        key=[keys objectAtIndex:i];
        
        // Property upload
        [body appendData: [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", key,[data.fields objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];

        if (i!=[keys count]-1 || [data.files count]!=0)
        {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    
    keys=[data.files allKeys];
    
    for (i=0;i<[keys count];i++)
    {
        key=[keys objectAtIndex:i];
        
        // File upload
        [body appendData: [[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n\r\n", key,key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData: [data.files objectForKey:key]];
        
        if (i != [keys count]-1)
        {
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }else
        {
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [req setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[body length]] forHTTPHeaderField:@"Content-Length"];
    
    if([data.files count]!=0 || [data.fields count]!=0)
    {
        [req setHTTPBody:body];
    }

    NSData *returnData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error: &error];
    
    NSString* returnString=nil;
    
    if(error!=nil)
    {
    	TRANSLOADIT_LOG_ERROR(self.class, error);
    }else
    {
        returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        TRANSLOADIT_LOG_INFO(self.class,@"%@",returnString);
    }
    
    return returnString;
    
}

@end
