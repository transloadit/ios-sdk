//
//  ApiData.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**Stores information which can be sent. This object not parsed.*/
@interface ApiData : NSObject

/**Data fields of a request (key - value pairs)*/
@property(strong,nonatomic)NSMutableDictionary *fields;

/**Params field of a request (key - value pairs)*/
@property(strong,nonatomic)NSMutableDictionary *params;
    
/**File objects of the files which will be sent*/
@property(strong,nonatomic)NSMutableDictionary *files;

@end
