//
//  TransloaditResponse.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IApiResponse.h"
#import "IResponseParser.h"

@interface TransloaditResponse : NSObject<IApiResponse>
{
    /**Request success flag*/
    bool success;
    
    /**The response string*/
    NSString* responseString;
    
    /**The parsed data*/
    NSDictionary* data;

}

/**Creates a new TransloaditResponse object with response string string
 * @param responseString The response string
 */
-(id)init:(NSString*)responseString withError:(NSError*)error;


/**
 * Creates a new TransloaditResponse object with response string string and parser
 * @param responseString The response string
 * @param parser The response parser
 */
-(id)init:(NSString*)responseString withParser:(NSObject<IResponseParser>*)parser withError:(NSError*)error;

@end
