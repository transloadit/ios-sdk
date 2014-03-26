//
//  IApiRequest.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiData.h"
#import "IRequestParser.h"
#import "IApiResponse.h"

@protocol IApiRequest <NSObject>

/**The type of request*/
typedef enum
{
    /**Used for GET requests*/
    GET,
    
    /** Used for POST requests*/
    POST,
    
    /**Used for PUT requests*/
    PUT,
    
    /**Used for DELETE requests*/
    DELETE,
} RequestMethod;


/**Returns the string representation of the RequestMethod enum value*/
#define REQUEST_METHOD_VALUE(enum) [@[@"GET",@"POST",@"PUT",@"DELETE"] objectAtIndex:enum]

/**Gets data to be posted*/
-(ApiData*)getData;

/**Gets the method of the current request*/
-(RequestMethod)getMethod;

/**Sets the method of the current request*/
-(void)setMethod:(RequestMethod)method;

/**Gets the URI of the current request*/
-(NSURL*)getURL;

/**
 *  Sets the absolute path of the current request
 * @param path The path string
 */
-(void)setPath:(NSString*)path;

/**
 * Sets the host of the current request
 * @param path The host string
 */
-(void)setHost:(NSString*)path;

/**Sets data to be posted*/
-(void)setData:(ApiData*)data;

/**Gets the Request parser object*/
-(NSObject<IRequestParser>*)getParser;


/**
 * Executes the current requests and gets the result
 * @param error Reference to error handling. Pass a nil reference. If no error then remain nil.
 * @return The response object
 */
-(NSObject<IApiResponse>*)executeWithError:(NSError*)error;

@end
