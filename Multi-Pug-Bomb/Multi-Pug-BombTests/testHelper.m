//
//  testHelper.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/15/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "testHelper.h"
#import "OHHTTPStubs.h"

@implementation testHelper
+ (void)stubRandomPugHTTPRequest
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"http://pugme.herokuapp.com/random"];
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        OHHTTPStubsResponse *response =[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"output.json", nil) statusCode:200 headers:@{@"Content-Type": @"application/json"}];
        return response;
    }];

}
@end
