//
//  JSONRequestParser.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRequestParser.h"

@interface JSONRequestParser : NSObject<IRequestParser>
{
    /**The request parameters*/
    NSDictionary* request;
}

/**
 * Creates new JSONRequestParser and sets the request properties
 * @param request The params key-value pairs
 */
-(id)init:(NSDictionary*)_request;

/**
 * Creates new JSONRequestParser
 */
-(id)init;


@end
