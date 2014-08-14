//
//  Transloadit.m
//  TransloaditLib
//
//  Created by Szabó Tamás on 2014.01.21..
//  Copyright (c) 2014 Transloadit Ltd. All rights reserved.
//

#import "Transloadit.h"
#import "TransloaditLogger.h"
#import "TransloaditError.h"
#import "ShaUtils.h"

@implementation Transloadit

- (void)useSignature:(NSString *)_secret { secret = _secret; }

- (id)init:(NSString *)_key
{
    if (self = [super init]) {
        key = _key;
    }

    return self;
}

- (TransloaditResponse *)deleteAssembly:(NSString *)assemblyID
{
    TransloaditRequest *request = [self request];

    [request setPath:[NSString stringWithFormat:@"/%@", assemblyID]];

    TransloaditResponse *response;

    NSError *error = nil;

    response = (TransloaditResponse *)[request executeWithError:&error];

    if (error == nil && [response isSuccess]) {
        NSURL *url = [[NSURL alloc] initFileURLWithPath:[[response getData] objectForKey:@"assembly_url"]];

        TransloaditRequest *deleteRequest = [self request];
        [deleteRequest setMethod:DELETE];
        [deleteRequest setHost:url.host];
        [deleteRequest setPath:url.path];
        TransloaditResponse *deleteResponse = (TransloaditResponse *)[request executeWithError:&error];

        if (error != nil) {
            TRANSLOADIT_LOG_ERROR(self.class, error);
        }

        return deleteResponse;
    }

    if (error == nil) {
        error = [TransloaditError createError:ERROR_CODE_RESPONSE_NOT_VALID];
    }

    return nil;
}

- (NSString *)getBoredInstanceServer
{
    TransloaditRequest *request = [self request];
    [request setMethod:GET];
    [request setPath:BORED_INSTANCE_PATH];

    NSError *error = nil;
    TransloaditResponse *boredInstance = (TransloaditResponse *)[self requestAndExecute:request withError:&error];

    if (error == nil && [boredInstance isSuccess]) {
        return [[boredInstance getData] objectForKey:@"api2_host"];

    } else {
        TRANSLOADIT_LOG_ERROR_WITH_ERROR_AND_MESSAGE(self.class, error, @"Bored instance host is invalid using default path %@",
                                                     [[boredInstance getData] objectForKey:@"api2_host"]);

        return DEFAULT_HOST;
    }
}

- (TransloaditResponse *)invokeAssembly:(NSObject<IAssemblyBuilder> *)assembly withError:(NSError **)error
{

    TransloaditRequest *request = [self request];
    [request setHost:[self getBoredInstanceServer]];
    [request setMethod:POST];
    [request setPath:ASSEMBLY_ROOT];

    [assembly setAuthKey:key];

    NSError *localError = nil;
    if (secret != nil) {
        NSObject<IRequestParser> *parser = [request getParser];

        [parser setRequest:[assembly toApiData].params];

        NSString *signatureValue = [self getSignature:[parser parseWithError:&localError]];

        if (localError == nil) {
            [assembly setSignature:signatureValue];
        } else {
            TRANSLOADIT_LOG_ERROR(self.class, localError);
        }
    }

    if (localError == nil) {
        [request setData:[assembly toApiData]];

        TransloaditResponse *response = (TransloaditResponse *)[request executeWithError:&localError];
        if (!localError && response) {
            return response;
        }
    }
    if (localError)
        TRANSLOADIT_LOG_ERROR(self.class, localError);
    if (error)
        *error = localError;
    return nil;
}

- (TransloaditRequest *)request { return [[TransloaditRequest alloc] init]; }

- (TransloaditResponse *)requestAndExecute:(TransloaditRequest *)request withError:(NSError **)error
{
    if (request == nil) {
        request = [self request];
    }
    TransloaditResponse *response = (TransloaditResponse *)[request executeWithError:error];
    return response;
}

/**
 * Generates and gets the signature of the current request (based on the API Secret code and "params" field)
 * @param str Specified "params" field of the current Transloadit request
 * @return SHA1 signature for the current request
 */
- (NSString *)getSignature:(NSString *)str
{
    if (secret == nil || [secret length] < 1) {
        return nil;
    }

    return [ShaUtils getSha1:str withKey:secret];
}

@end
