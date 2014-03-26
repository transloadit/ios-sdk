//
//  IApiResponse.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**Interface for API response*/
@protocol IApiResponse <NSObject>

/**Gets the response string*/
-(NSString*)getResponseString;

/**Gets data tree parsed from the sent response string*/
-(NSDictionary*)getData;

/**Gets success information about the sent request*/
-(bool)isSuccess;

@end
