//
//  DefaultHttpExecutor.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Transloadit Ltd. All rights reserved.
//
//  Updated by Mike Llewellyn (mike@calvir.com) on 9 June 2014
//  - Added defaultRequestTimeout and managed nil response correctly.

#import <Foundation/Foundation.h>
#import "IRequestExecutor.h"

@interface DefaultHttpExecutor : NSObject <IRequestExecutor> {
    /**Destination URI*/
    NSURL *url;

    /**Request method*/
    RequestMethod method;
}

@property (nonatomic, assign) NSTimeInterval defaultRequestTimeout;

@end
