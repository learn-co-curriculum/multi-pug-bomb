//
//  ImagesTableViewControllerSpec.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/14/14.
//  Copyright 2014 al-tyus.com. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "EXPMatcher+imageMatchers.h"
#import "FISPugCell.h"
#import "ImagesTableViewController.h"
#import "KIF.h"
#import "OHHTTPStubs.h"


SpecBegin(ImagesTableViewController)


describe(@"ImagesTableViewController", ^{
    
    __block UITableView *pugListTableView;
    
    beforeAll(^{
        pugListTableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"Pug List"];
    });

    beforeEach(^{

    });

    describe(@"Pug Cell", ^{
        __block FISPugCell *pugCell;
        beforeAll(^{
            pugCell= [pugListTableView dequeueReusableCellWithIdentifier:@"pugCell"];
        });
        it(@"Should have an Image View name pugImageView", ^{
            expect(pugCell).to.respondTo(@selector(pugImageView));
            expect(pugCell).to.respondTo(@selector(setPugImageView:));
        });

        it(@"Should be 300 pts tall", ^{
            expect(pugCell.frame.size.height).to.equal(300);
        });

    });

    describe(@"Pug List Table View", ^{

        it(@"should use FISPugCells", ^{
            expect([pugListTableView dequeueReusableCellWithIdentifier:@"pugCell"]).to.beKindOf([FISPugCell class]);
        });

        it(@"should contain 299 rows", ^{
            expect([pugListTableView numberOfRowsInSection:0]).to.equal(299);
        });

        it(@"should have rows 300 pts high", ^{
            expect([pugListTableView rowHeight]).to.equal(300);
        });

        it(@"should contain 1 section", ^{
            expect([pugListTableView numberOfSections]).to.equal(1);
        });

        it(@"should contain pug images after they load", ^{
            [tester scrollViewWithAccessibilityIdentifier:@"Pug List" byFractionOfSizeHorizontal:-1.0 vertical:0.0];
            NSIndexPath *ip = [NSIndexPath indexPathForRow:3 inSection:0];
            [tester waitForCellAtIndexPath:ip inTableViewWithAccessibilityIdentifier:@"Pug List"];
            FISPugCell *pugCell = (FISPugCell *)[pugListTableView cellForRowAtIndexPath:ip];
            UIImage *image = pugCell.pugImageView.image;
            UIImage *refImage = [UIImage imageWithContentsOfFile:OHPathForFileInBundle(@"pug.jpg", nil)];
            [Expecta setAsynchronousTestTimeout:5.0];
            expect(image).will.equal(refImage);
        });
    });

    afterEach(^{

    });
    
    afterAll(^{

    });
});

SpecEnd
