//
//  IRequestParser.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRequestParser <NSObject>

/**Sets the request objects to be parsed*/
-(void)setRequest:(NSDictionary*)request;

/**Gets the request parser*/
-(NSDictionary*)getRequest;

/**
 * Parse the request
 * @return The parsed String
 * @throws NotParseableException Thrown when the request not parseable.
 */
-(NSString*)parseWithError:(NSError*)error;

@end
