//
//  pugAPISpec.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/11/14.
//  Copyright 2014 al-tyus.com. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "EXPMatcher+imageMatchers.h"
#import "OHHTTPStubs.h"
#import "testHelper.h"
#import "pugAPI.h"


SpecBegin(pugAPI)

describe(@"pugAPI", ^{

    __block pugAPI *api;
    beforeAll(^{
        [testHelper stubRandomPugHTTPRequest];
    });
    
    beforeEach(^{
        api = [[pugAPI alloc] init];
    });

    describe(@"getPugsCount", ^{
        it(@"should respond to getPugsCount:pugBlock:completionBlock", ^{
            expect(api).to.respondTo(@selector(getPugsCount:pugBlock:completionBlock:));
        });

        it(@"should return 10 pugs", ^AsyncBlock{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return [request.URL.absoluteString isEqualToString:@"http://24.media.tumblr.com/tumblr_lsvczkC8e01qzgqodo1_500.jpg"];
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                OHHTTPStubsResponse *response =[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"pug.jpg", nil) statusCode:200 headers:@{@"Content-Type": @"image/jpeg"}];
                return response;
            }];

            __block NSInteger counter=0;

            UIImage *refImage = [UIImage imageWithContentsOfFile:OHPathForFileInBundle(@"pug.jpg", nil)];
            [api getPugsCount:@10 pugBlock:^(UIImage *pugImage, NSIndexPath *ip) {
                expect(pugImage).toNot.beNil();
                expect(pugImage).to.containImageData();
                expect(pugImage).to.equal(refImage);
                counter++;
            } completionBlock:^{
                expect(counter).to.equal(10);
                done();
            }];
            
        });

        it(@"should return placeholders for bad images", ^AsyncBlock {
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                return [request.URL.absoluteString isEqualToString:@"http://24.media.tumblr.com/tumblr_lsvczkC8e01qzgqodo1_500.jpg"];
            } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                OHHTTPStubsResponse *response =[OHHTTPStubsResponse responseWithData:nil statusCode:404 headers:nil];
                return response;
            }];

            __block NSInteger counter = 0;
            UIImage *refImage = [UIImage imageNamed:@"placeholder"];
            [api getPugsCount:@10 pugBlock:^(UIImage *pugImage, NSIndexPath *ip) {
                expect(pugImage).toNot.beNil();
                expect(pugImage).to.containImageData();
                expect(pugImage).to.equal(refImage);
                counter++;
            } completionBlock:^{
                expect(counter).to.equal(10);
                done();
            }];
        });
    });

    afterEach(^{
        [OHHTTPStubs removeLastStub];
    });
    
    afterAll(^{
    });
});

SpecEnd
