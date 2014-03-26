//
//  ParsedApiData.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "ParsedApiData.h"
#import "TransloaditLogger.h"

@implementation ParsedApiData

@synthesize fields,files;

-(id)initWithApiData:(ApiData*)data parser:(NSObject<IRequestParser>*)parser
{
    if (self = [super init])
    {
        fields=[[NSMutableDictionary alloc] init];
        files=[[NSMutableDictionary alloc] init];
        
        if(data!=nil)
		{
			[files addEntriesFromDictionary:data.files];
            [fields addEntriesFromDictionary:data.fields];
			
			[parser setRequest:data.params];
			
            NSError* error=nil;
            
            NSString* parsed=[parser parseWithError:error];
            
            if(error==nil)
            {
            	
                [fields setObject:parsed forKey:@"params"];
                
            }else
            {
			
				TRANSLOADIT_LOG_ERROR(self.class, error);
			}
		}
    }
    
    return self;
}

@end
