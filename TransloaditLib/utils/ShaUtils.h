//
//  ShaUtils.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**Util functions for Transoadit*/
@interface ShaUtils : NSObject

/**
 * Generates and gets SHA1 string based on the passed parameters
 * @param key Key of the hash
 * @param str String to be secured
 * @return The genarated hash in hex format
 */
+(NSString*)getSha1:(NSString*)str withKey:(NSString*)key;

@end
