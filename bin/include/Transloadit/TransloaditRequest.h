//
//  TransloaditRequest.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IApiRequest.h"
#import "ApiData.h"

/**Default absolute URI path of assembly requests*/
#define ASSEMBLY_ROOT @"/assemblies"

/**Default absolute URI path to request bored instance*/
#define BORED_INSTANCE_PATH @"/instances/bored"

/**Default host of Transloadit services*/
#define DEFAULT_HOST @"api2.transloadit.com"

/**Default protocol of Transloadit services*/
#define DEFAULT_SCHEME @"http"

@interface TransloaditRequest : NSObject<IApiRequest>
{
    /**The request URI*/
    NSURL* url;
    
    /**The request ApiData*/
    ApiData* data;
    
    /**The request method*/
    RequestMethod method;

}

/**Creates a new TransloaditRequest object. sets the Host to the default one, also sets the path to AssemblyRoot*/
-(id)init;

@end
