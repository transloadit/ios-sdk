//
//  TransloaditLogger.h
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

/**
 * Logs information during application processes
 * @param type Type of the class, where the log is proceed
 * @param message Parameterized info message
 */
#define TRANSLOADIT_LOG_INFO(type,message,...) NSLog(@"INFO: %@ -- %@",NSStringFromClass(type),[NSString stringWithFormat:message,##__VA_ARGS__])

/**
 * Logs errors during application processes
 * @param type Type of the class, where the log is proceed
 * @param exception Exception, which is the reason of the error
 * @param message Parameterized error message
 */
#define TRANSLOADIT_LOG_ERROR_WITH_ERROR_AND_MESSAGE(type,error,message,...) NSLog(@"ERROR: %@ -- %@ -- %@",NSStringFromClass(type),[error localizedDescription],[NSString stringWithFormat:message,##__VA_ARGS__])

/**
 * Logs errors during application processes
 * @param type Type of the class, where the log is proceed
 * @param message Parameterized error message
 */
#define TRANSLOADIT_LOG_ERROR_WITH_MESSAGE(type,message,...) NSLog(@"ERROR: %@ -- %@",NSStringFromClass(type),[NSString stringWithFormat:message,##__VA_ARGS__])



/**
 * Logs errors during application processes
 * @param type Type of the class, where the log is proceed
 * @param exception Exception, which is the reason of the error
 */

#define TRANSLOADIT_LOG_ERROR(type,error) NSLog(@"ERROR: %@ -- %@",NSStringFromClass(type),[error localizedDescription])

