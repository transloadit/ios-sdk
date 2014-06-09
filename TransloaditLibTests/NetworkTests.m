//
//  NetworkTests.m
//  NetworkTests
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Transloadit Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Constants.h"
#import "Transloadit.h"
#import "AssemblyBuilder.h"
#import "Step.h"
#import "TransloaditResponse.h"

@interface NetworkTests : XCTestCase

@end

@implementation NetworkTests

-(void)testNoInternetConnection
{
    NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:API_KEY];
	NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
    
    NSError* error;
    
    TransloaditResponse* response =[transloadit invokeAssembly:assembly withError:error];
    
    XCTAssertTrue(error==nil);
    
    if(!SIGNATURE_AUTHENTICATION)
    {
        XCTAssertTrue(![response isSuccess]);
        
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"ASSEMBLY_NO_STEPS"]);
    }else
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"NO_SIGNATURE_FIELD"]);
    }
    
}

@end