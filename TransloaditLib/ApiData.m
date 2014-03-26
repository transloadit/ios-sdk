//
//  ApiData.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "ApiData.h"

@implementation ApiData

@synthesize fields,files,params;

-(id)init
{
	if (self = [super init])
	{
        fields=[[NSMutableDictionary alloc] init];
        files=[[NSMutableDictionary alloc] init];
        params=[[NSMutableDictionary alloc] init];
	}
    
	return self;
}

@end
