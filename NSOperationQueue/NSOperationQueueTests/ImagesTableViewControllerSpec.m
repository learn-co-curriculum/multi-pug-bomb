//
//  ImagesTableViewControllerSpec.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/14/14.
//  Copyright 2014 al-tyus.com. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "ImagesTableViewController.h"
#import "Expecta.h"
#import "EXPMatcher+imageMatchers.h"
#import "FISPugCell.h"
#import "KIF.h"
#import "OHHTTPStubs.h"


SpecBegin(ImagesTableViewController)

describe(@"ImagesTableViewController", ^{
    
    beforeAll(^{

    });
    
    beforeEach(^{

    });
    
    it(@"", ^{
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.absoluteString isEqualToString:@"http://pugme.herokuapp.com/random"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            OHHTTPStubsResponse *response =[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"output.json", nil) statusCode:200 headers:@{@"Content-Type": @"application/json"}];
            return response;
        }];
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.absoluteString isEqualToString:@"http://24.media.tumblr.com/tumblr_lsvczkC8e01qzgqodo1_500.jpg"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            OHHTTPStubsResponse *response =[OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"pug.jpg", nil) statusCode:200 headers:@{@"Content-Type": @"image/jpeg"}];
            return response;
        }];


        UITableView *tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"Pug List"];
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
        FISPugCell *pugCell = (FISPugCell *)[tableView cellForRowAtIndexPath:ip];
        UIImage *image = pugCell.pugImageView.image;
        UIImage *refImage = [UIImage imageWithContentsOfFile:OHPathForFileInBundle(@"pug.jpg", nil)];
        expect(image).to.equal(refImage);
    });
    
    afterEach(^{

    });
    
    afterAll(^{

    });
});

SpecEnd
