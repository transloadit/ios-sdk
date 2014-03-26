//
//  DefaultHttpExecutor.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRequestExecutor.h"

@interface DefaultHttpExecutor : NSObject<IRequestExecutor>
{
    /**Destination URI*/
    NSURL* url;
    
    /**Request method*/
    RequestMethod method;

}

@end
