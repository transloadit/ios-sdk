//
//  Transloadit.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITransloadit.h"

@interface Transloadit : NSObject<ITransloadit>
{
    
    /** The API Key of the current Transloadit user. This key is used for each Transloadit request*/
    NSString* key;
    
    /** The API Secret code of the current Transloadit user. This code is used for each request if signature authentication is enabled */
    NSString* secret;
}


/**
 * Creates a new Transloadit object with the given key
 * @param key The API key
 */
-(id)init:(NSString*)_key;

@end
