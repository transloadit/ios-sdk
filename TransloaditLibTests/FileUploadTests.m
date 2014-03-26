//
//  FileUploadTests.m
//  FileUploadTests
//
//  Created by Szabó Tamás on 2014.01.17..
//  Copyright (c) 2014 Synthesis-Net. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Constants.h"
#import "Transloadit.h"
#import "AssemblyBuilder.h"
#import "Step.h"
#import "TransloaditResponse.h"

@interface FileUploadTests : XCTestCase

@end

@implementation FileUploadTests

-(void)testResizeImageExistingFile
{
    NSObject<ITransloadit>* transloadit =[[Transloadit alloc] init:API_KEY];
    NSObject<IAssemblyBuilder>* assembly =[[AssemblyBuilder alloc] init];
    
    NSString* path=[NSString stringWithFormat:@"%@/%@",[[NSBundle bundleForClass:[self class]] resourcePath],TEST_IMAGE];
    
    NSData* img = [NSData dataWithContentsOfFile:path];
    
    XCTAssertTrue(img!=nil);
    
    NSError* error;
    
    if (img!=nil)
    {
    	[assembly addFile:img withError:error];
        
        XCTAssertTrue(error==nil);
    }
    
    
    NSObject<IStep>* step=[[Step alloc] init];
    [step setOptionKey:@"robot" object:@"/image/resize"];
    [step setOptionKey:@"width" object:@(75)];
    [step setOptionKey:@"height" object:@(75)];
    [step setOptionKey:@"resize_strategy" object:@"pad"];
    [step setOptionKey:@"background" object:@"#000000"];

    [assembly addStepName:@"thumb" step:step];

    TransloaditResponse* response = [transloadit invokeAssembly:assembly withError:error];

    XCTAssertTrue(error==nil);
    
    if(!SIGNATURE_AUTHENTICATION)
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_COMPLETED"] || [(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_EXECUTING"]);

        XCTAssertTrue([(NSArray*)[[response getData] objectForKey:@"uploads"] count] == 1);
    
    }else
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"NO_SIGNATURE_FIELD"]);
    }
}

-(void)testResizeImageNonExistingFile
{
    NSObject<ITransloadit>* transloadit =[[Transloadit alloc] init:API_KEY];
    NSObject<IAssemblyBuilder>* assembly =[[AssemblyBuilder alloc] init];
    
    NSString* path=[NSString stringWithFormat:@"%@/%@",[[NSBundle bundleForClass:[self class]] resourcePath],@"non_existing"];
    
    NSData* img = [NSData dataWithContentsOfFile:path];
    
    XCTAssertTrue(img==nil);
    
    NSError* error;
    
    if (img!=nil)
    {
    	[assembly addFile:img withError:error];
        
        XCTAssertTrue(error==nil);
    }
    
    
    NSObject<IStep>* step=[[Step alloc] init];
    [step setOptionKey:@"robot" object:@"/image/resize"];
    [step setOptionKey:@"width" object:@(75)];
    [step setOptionKey:@"height" object:@(75)];
    [step setOptionKey:@"resize_strategy" object:@"pad"];
    [step setOptionKey:@"background" object:@"#000000"];
    
    [assembly addStepName:@"thumb" step:step];
    
    TransloaditResponse* response = [transloadit invokeAssembly:assembly withError:error];
    
    XCTAssertTrue(error==nil);
    
    if(!SIGNATURE_AUTHENTICATION)
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_COMPLETED"] || [(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_EXECUTING"]);
    }else
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"NO_SIGNATURE_FIELD"]);
    }
}

-(void)testResizeMultipleImageExistingFile
{
    NSObject<ITransloadit>* transloadit =[[Transloadit alloc] init:API_KEY];
    NSObject<IAssemblyBuilder>* assembly =[[AssemblyBuilder alloc] init];
    
    NSString* path=[NSString stringWithFormat:@"%@/%@",[[NSBundle bundleForClass:[self class]] resourcePath],TEST_IMAGE];
    
    NSData* img = [NSData dataWithContentsOfFile:path];
    
    XCTAssertTrue(img!=nil);
    
    NSError* error;
    
    if (img!=nil)
    {
    	[assembly addFile:img withError:error];
        
        XCTAssertTrue(error==nil);
        
        [assembly addFile:img withError:error];
        
        XCTAssertTrue(error==nil);
    }
    
    
    NSObject<IStep>* step=[[Step alloc] init];
    [step setOptionKey:@"robot" object:@"/image/resize"];
    [step setOptionKey:@"width" object:@(75)];
    [step setOptionKey:@"height" object:@(75)];
    [step setOptionKey:@"resize_strategy" object:@"pad"];
    [step setOptionKey:@"background" object:@"#000000"];
    
    [assembly addStepName:@"thumb" step:step];
    
    TransloaditResponse* response = [transloadit invokeAssembly:assembly withError:error];
    
    XCTAssertTrue(error==nil);
    
    if(!SIGNATURE_AUTHENTICATION)
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_COMPLETED"] || [(NSString*)[[response getData] objectForKey:@"ok"] isEqualToString:@"ASSEMBLY_EXECUTING"]);
        
        XCTAssertTrue([(NSArray*)[[response getData] objectForKey:@"uploads"] count] == 2);
        
    }else
    {
        XCTAssertTrue([(NSString*)[[response getData] objectForKey:@"error"] isEqualToString:@"NO_SIGNATURE_FIELD"]);
    }
}

@end
