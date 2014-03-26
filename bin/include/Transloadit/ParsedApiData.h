//
//  ParsedApiData.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiData.h"
#import "IRequestParser.h"

@interface ParsedApiData : NSObject

/**Data fields of a request (key - value pairs)*/
@property(strong,nonatomic)NSMutableDictionary *fields;

/**File objects of the files which will be sent*/
@property(strong,nonatomic)NSMutableDictionary *files;

/**
 * Creates a new ParsedApiData object with the given parser.
 * @param apiData The raw api data.
 * @param parser The parser to create from the data object
 */
-(id)initWithApiData:(ApiData*)apiData parser:(NSObject<IRequestParser>*)parser;

@end
