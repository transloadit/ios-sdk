//
//  IResponseParser.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IResponseParser <NSObject>

/**Sets the response String*/
-(void)setResponse:(NSString*)response;

/**Gets the response String*/
-(NSString*)getResponse;

/**
 * Parse the request
 * @return The parsed Map
 * @throws NotParseableException Thrown when the request not parseable.
 */
-(NSDictionary*) parseWithError:(NSError*)error;

@end
