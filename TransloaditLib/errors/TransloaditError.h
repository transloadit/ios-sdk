//
//  TransloaditError.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.18..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Transloadit errors domain name*/
#define ERROR_DOMAIN @"hu.szabot.transloadit"

/**Invalid field key. The key is restricted by the api.*/
#define ERROR_CODE_INVALID_FIELD_KEY 4121

/**The key is already defined*/
#define ERROR_CODE_ALREADY_DEFINED_KEY 4122

/**The parameters not parseable with the given parser*/
#define ERROR_CODE_NOT_PARSEABLE 4123

/**Thrown when the server response not valid*/
#define ERROR_CODE_RESPONSE_NOT_VALID 4124

@interface TransloaditError : NSObject

/**
 
 Creates an NSError object with the passed code.
 
 @param errorCode The error code. Must be one of the defined ERROR_CODE_ integers.
 */
+(NSError*)createError:(int)errorCode;

@end
