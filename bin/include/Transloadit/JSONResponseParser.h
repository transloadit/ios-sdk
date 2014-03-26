//
//  JSONResponseParser.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IResponseParser.h"

@interface JSONResponseParser : NSObject<IResponseParser>
{
    /**The response String*/
    NSString* response;

}

/**
 * Creates a JSONResponseParser with the given string
 * @param response The response string
 */
-(id)init:(NSString*)_response;

/**
 * Creates a JSONResponseParser
 */
-(id)init;


@end
