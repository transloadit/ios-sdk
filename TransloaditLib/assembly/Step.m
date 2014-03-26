//
//  Step.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "Step.h"

@implementation Step

@synthesize dictionary;

-(id)init
{
    if (self = [super init])
    {
        dictionary=[[NSMutableDictionary alloc] init];
    }
    
    return self;
    
}

-(void)setOptionKey:(NSString*)key object:(NSObject*)value
{
	[dictionary setObject:value forKey:key];
}

-(NSDictionary*) getDictionary
{
	return dictionary;
}

@end
