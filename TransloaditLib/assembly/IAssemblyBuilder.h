//
//  IAssemblyBuilder.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiData.h"
#import "IStep.h"

/**
 *Builds up an assembly which will be tried to be created on Transloadit
 **/
@protocol IAssemblyBuilder <NSObject>

/**Adds file to the current assembly
 *
 * @param file File to upload
 * @param error Reference to error handling. Pass a nil reference. If no error then remain nil.
 */
-(void)addFile:(NSData*) file withError:(NSError*)error;

/**
 * Adds file to the current assembly with specific key
 * @param key Key of the file to be uploaded
 * @param file NSData with the file content.
 * @param error Reference to error handling. Pass a nil reference. If no error then remain nil.
 */
-(void)addFileWithName:(NSString*)key file:(NSData*)file withError:(NSError*) error;

/**Adds step to the current assembly
 *
 * @param name Name of the step
 * @param step Step to be added
 */
-(void) addStepName:(NSString*)name step:(NSObject<IStep>*)step;

/**Checks whether the assembly has notify URL
 *
 * @return True if notify url is set.
 */
-(bool)hasNotifyUrl;

/**Checks whether the assembly has template ID
 *
 * @return Existing of set template ID
 */
-(bool)hasTemplateID;

/**Sets the expiration datetime of the assembly (as UTC date)
 *
 * @param dateTime Expiration NSDate
 */
-(void)setAuthExpires:(NSDate*)dateTime;

/**
 * Do not call directly!
 * <p>
 * Transloadit class will override the value. Use Transloadit constructor parameter.
 * <p>
 * Sets the authentication key for the assembly
 * @param key API key of the user
 */
-(void)setAuthKey:(NSString*) key;

/**
 * Do not call directly!
 * <p>
 * Transloadit class will override the value. Use Transloadit useSignature method.
 * <p>
 * Sets the signature for the assembly
 * @param key Generated signature
 */
-(void)setSignature:(NSString*) key;


/**Sets the maximum size of the assembly
 *
 * @param maxSize Maximum size (in bytes)
 */
-(void)setAuthMaxSize:(int)maxSize;

/**Sets a custom field in the current assembly
 *
 * @param key Key of the field
 * @param value Value of the field
 * @param error Reference to error handling. Pass a nil reference. If no error then remain nil.
 */
-(void)setFieldKey:(NSString*)key value:(NSString*)value withError:(NSError*)error;

/**
 * Sets the notification URL of the assembly, which will be requested after assembly is completed
 * @param notifyURL Notification URL (e.g.: 'http://my.domain.me/application')
 */
-(void)setNotifyURL:(NSString*)notifyURL;

/**Sets the used template ID of the assmebly (you can create multiple Transloadit templates under your account,please use its unique ID here)
 *
 * @param templateID Template ID of the assmebly
 */
-(void)setTemplateID:(NSString*)templateID;

/**Converts the builder to ApiData and gets the object, which will be the base of the sent Transloadit request
 *
 * @return Data to be sent to Transloadit backend
 */
-(ApiData*) toApiData;

/**Checks whether the assembly has steps
 * @return True if one or more step added.
 */
-(bool)hasSteps;

@end
