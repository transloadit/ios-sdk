//
//  OrderedDictionary.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.24..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "OrderedDictionary.h"

@implementation OrderedDictionary

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        dictionary = [[NSMutableDictionary alloc] init];
        array = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)setObject:(id)anObject forKey:(id)aKey
{
    if (![dictionary objectForKey:aKey])
    {
        [array addObject:aKey];
    }
    [dictionary setObject:anObject forKey:aKey];
}

- (void)removeObjectForKey:(id)aKey
{
    [dictionary removeObjectForKey:aKey];
    [array removeObject:aKey];
}

- (NSUInteger)count
{
    return [dictionary count];
}

- (id)objectForKey:(id)aKey
{
    return [dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
    return [array objectEnumerator];
}

@end
