//
//  TransloaditLibTests.m
//  TransloaditLibTests
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

@interface AuthenticationTests : XCTestCase

@end

@implementation AuthenticationTests

-(void)testAuthenticateWithExistingAccount
{
    
    NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:API_KEY];
	NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
    
    NSObject<IStep>* step=[[Step alloc] init];
    
    [step setOptionKey:@"robot" object:@"/http/import"];
    [step setOptionKey:@"url" object:@"http://static4.wikia.nocookie.net/__cb20120716045812/deadliestfiction/images/2/24/Cthulhu-rlyeh-rising.jpg"];

    [assembly addStepName:@"test" step:step];

    NSError* error;
    
    TransloaditResponse* response =[transloadit invokeAssembly:assembly withError:error];
    
    XCTAssertTrue(error==nil);
    
    if(!SIGNATURE_AUTHENTICATION)
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_COMPLETED"] || [(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_EXECUTING"]);
    
    }else
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"NO_SIGNATURE_FIELD"]);
    }
    
    
}

-(void)testAuthenticateWithNonExistingAccount
{
    NSObject<ITransloadit>* transloadit =[[Transloadit alloc] init:@"non-existing-account"];
    NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
    
    NSObject<IStep>* step=[[Step alloc] init];
    
    [step setOptionKey:@"robot" object:@"/http/import"];
    [step setOptionKey:@"url" object:@"http://static4.wikia.nocookie.net/__cb20120716045812/deadliestfiction/images/2/24/Cthulhu-rlyeh-rising.jpg"];
    
    [assembly addStepName:@"test" step:step];
    
    NSError* error;
    
    TransloaditResponse* response =[transloadit invokeAssembly:assembly withError:error];
    
    XCTAssertTrue(error==nil);

    XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"GET_ACCOUNT_UNKNOWN_AUTH_KEY"]);

}

@end
