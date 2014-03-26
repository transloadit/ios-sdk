//
//  ITransloadit.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransloaditRequest.h"
#import "TransloaditResponse.h"
#import "IAssemblyBuilder.h"

/**Interface for accessing Transloadit services*/
@protocol ITransloadit <NSObject>

/**
 * Tries to delete an assembly by the specified assembly ID.
 * @param assemblyID ID of the assembly which will be tried to be deleted
 * @return Represents the whole result of the request.
 */
-(TransloaditResponse*)deleteAssembly:(NSString*)assemblyID;

/**
 * Tries to create the specified assembly on Transloadit. Bored instance is requested at first. If there is one, then it will
 * be used to proceed the request, which can be completed on a bored instance.
 * @param assembly Specified assembly which will be tried to be created.
 * @return Represents the whole result of the request.
 * @param error Reference to error handling. Pass a nil reference. If no error then remain nil.
 */
-(TransloaditResponse*)invokeAssembly:(NSObject<IAssemblyBuilder>*)assembly withError:(NSError*)error;

/**
 * Creates and gets a new TransloaditRequest instance with default attributes
 * @return TransloaditRequest instance with default attributes
 */
-(TransloaditRequest*)request;


/**
 * Creates then tries to proceed the specified or a default request, then executes this and gets the response of it.
 * @param request Optional request which will be tried to be executed
 * @return Represents the whole result of the request.
 * @param error Reference to error handling. Pass a nil reference. If no error then remain nil.
 */
-(TransloaditResponse*)requestAndExecute:(TransloaditRequest*)request withError:(NSError*)error;


/**
 * Sets API Secret code of the current Transloadit user. This code is used for each request if signature authentication is enabled
 * @param secret The secret key, or NULL to not use signature.
 */
-(void) useSignature:(NSString*)secret;

@end
