//
//  pugAPI.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/11/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "pugAPI.h"
#import <AFNetworking.h>

@implementation pugAPI

- (void)getPugsCount:(NSNumber*)count
     pugBlock:(void (^)(UIImage *, NSIndexPath *))pugBlock completionBlock:(void (^)())completion
{
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 10;
    __block NSInteger returnedCount=0;

    NSOperationQueue* imageQueue = [[NSOperationQueue alloc] init];
    imageQueue.maxConcurrentOperationCount = 10;
    NSURL* randomPugURL =
        [NSURL URLWithString:@"http://pugme.herokuapp.com/random"];

    for (NSInteger i = 0; i < [count integerValue]; i++) {
        NSURLRequest* request = [NSURLRequest requestWithURL:randomPugURL];
        AFHTTPRequestOperation* op =
            [[AFHTTPRequestOperation alloc] initWithRequest:request];

        op.responseSerializer = [AFJSONResponseSerializer serializer];

        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* operation,
                                            id responseObject) {
        NSDictionary* responseDictionary = (NSDictionary*)responseObject;

        [imageQueue addOperationWithBlock:^{
            NSIndexPath* indexpath =
                [NSIndexPath indexPathForRow:i inSection:0];
            NSLog(@"%@",responseDictionary[@"pug"]);
            NSData* pugData =
                [NSData dataWithContentsOfURL:
                            [NSURL URLWithString:responseDictionary[@"pug"]]];
            UIImage* pugImage = [UIImage imageWithData:pugData];
            if (!pugImage) {
              pugImage = [UIImage imageNamed:@"placeholder"];
            }
            NSOperation *pugOp = [NSBlockOperation blockOperationWithBlock:^{
                    pugBlock(pugImage, indexpath);
            }];
            NSOperation *checkCompleteOp = [NSBlockOperation blockOperationWithBlock:^{
                returnedCount++;
                if (returnedCount==10) {
                    if (completion) {
                        completion();
                    }
                }
            }];
            [checkCompleteOp addDependency:pugOp];
            [[NSOperationQueue mainQueue] addOperation:pugOp];
            [[NSOperationQueue mainQueue] addOperation:checkCompleteOp];
        }];

        }
                                  failure:nil];

        [queue addOperation:op];
    }
}
@end
