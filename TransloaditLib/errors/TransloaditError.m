//
//  TransloaditError.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.18..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "TransloaditError.h"

@implementation TransloaditError


+(NSError*)createError:(int)errorCode
{
    NSString *fname = [[NSBundle mainBundle] pathForResource:@"ErrorMessage" ofType:@"strings"];
    NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:fname];
    
    NSMutableDictionary* details = [NSMutableDictionary dictionary];
    
    [details setValue:[d objectForKey:[@(errorCode) description]] forKey:NSLocalizedDescriptionKey];
    
    return [NSError errorWithDomain:ERROR_DOMAIN code:errorCode userInfo:details];
    
}

@end
