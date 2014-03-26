//
//  IRequestExecutor.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IApiRequest.h"
#import "ParsedApiData.h"

@protocol IRequestExecutor <NSObject>

/** Sets the request URI
 *
 * @param uri Destination URI
 */
-(void)setUrl:(NSURL*)url;

/** Sets the request method
 *
 * @param method The method
 */
-(void) setMethod:(RequestMethod)method;


/**Executes the current requests and gets the result
 *
 * @param data The parsed ApiData
 * @return The server response
 */
-(NSString*) execute:(ParsedApiData*)data withError:(NSError*)error;

@end
