//
//  IStep.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**Defines the major functionality of Transloadit step*/
@protocol IStep <NSObject>

/**
 * Sets an option for a step in the assembly
 * @param key Name of the option
 * @param value Value of the option
 */
-(void)setOptionKey:(NSString*)key object:(NSObject*)value;

/**Gets the current step as dictionary
 *
 * @return Step Dictionary
 */
-(NSDictionary*) getDictionary;

@end
