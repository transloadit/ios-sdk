//
//  OrderedDictionary.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.24..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**NSDictionary that keep the order of inserted elements*/
@interface OrderedDictionary : NSMutableDictionary
{
	NSMutableDictionary* dictionary;
    NSMutableArray* array;

}

@end
