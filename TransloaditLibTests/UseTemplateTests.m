//
//  UseTemplateTests.m
//  UseTemplateTests
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

@interface UseTemplateTests : XCTestCase

@end

@implementation UseTemplateTests

-(void)testExistingTemplate
{
    NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:API_KEY];
	NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
    
    NSError* error;
    
    [assembly setTemplateID:TEMPLATE_ID];
    
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


-(void)testNonExistingTemplate
{
    NSObject<ITransloadit>* transloadit = [[Transloadit alloc] init:API_KEY];
	NSObject<IAssemblyBuilder>* assembly = [[AssemblyBuilder alloc] init];
    
    NSError* error;
    
    [assembly setTemplateID:@"non_existing_template_id"];
    
    TransloaditResponse* response =[transloadit invokeAssembly:assembly withError:error];
    
    XCTAssertTrue(error==nil);
    
    if(!SIGNATURE_AUTHENTICATION)
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"TEMPLATE_NOT_FOUND"]);
    	
    }else
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"NO_SIGNATURE_FIELD"]);
    }
}

@end
