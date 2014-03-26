//
//  AssemblyBuilder.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAssemblyBuilder.h"
#import "OrderedDictionary.h"

@interface AssemblyBuilder : NSObject<IAssemblyBuilder>
{
    /**Authentication information*/
    NSMutableDictionary* auth;
    
    /**Steps in the assembly*/
    OrderedDictionary* steps;
    
    int fileIncrement;
    
    /**The builded ApiData*/
    ApiData* data;
    
}
@end
