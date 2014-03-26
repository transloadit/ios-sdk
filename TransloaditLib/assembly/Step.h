//
//  Step.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IStep.h"

@interface Step : NSObject<IStep>

@property(strong,nonatomic)NSMutableDictionary *dictionary;

@end
