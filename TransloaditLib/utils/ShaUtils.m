//
//  ShaUtils.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import "ShaUtils.h"
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation ShaUtils

+ (NSString*) hexStringWithData:(unsigned char*)data ofLength:(NSUInteger)len
{
    NSMutableString *tmp = [NSMutableString string];
    for (NSUInteger i=0; i<len; i++)
        [tmp appendFormat:@"%02x", data[i]];
    return [NSString stringWithString:tmp];
}

+(NSString*)getSha1:(NSString*)data withKey:(NSString*)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    return [self hexStringWithData:cHMAC ofLength:CC_SHA1_DIGEST_LENGTH];
    
}

@end
