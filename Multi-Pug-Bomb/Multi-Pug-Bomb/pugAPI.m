//
//  pugAPI.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 4/11/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "pugAPI.h"
#import <AFNetworking/AFNetworking.h>

@implementation pugAPI

- (void)getPugsCount:(NSNumber *)count
            pugBlock:(void (^)(UIImage *, NSIndexPath *))pugBlock
     completionBlock:(void (^)())completionBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pugme.herokuapp.com/random"]];
    
    __block NSInteger operationCount = [count integerValue];
    
    for (int x = 0; x < [count integerValue]; x++)
    {
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             
             const char *queue = "image_load_queue";
             dispatch_async(dispatch_queue_create(queue, 0), ^{
                 
                 /*             I prefer GCD for most async tasks so i'm using it but leaving the equivialent operation queue commands in comments
                  
                  [manager.operationQueue addOperationWithBlock:^{  */
                 
                 UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:responseDict[@"pug"]]]];
                 
                 if (!image)
                 {
                     image = [UIImage imageNamed:@"placeholder"];
                 }
                 
                 NSIndexPath *ip = [NSIndexPath indexPathForRow:x inSection:0];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     pugBlock(image, ip);
                 });
                 
                 operationCount --;
                 NSLog(@"%d", operationCount);
                 
                 if (operationCount == 0)
                 {
                     completionBlock();
                 }
             });
             /*   }];   */
             
             
         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"%@", error);
         }];
        
        [manager.operationQueue addOperation:operation];
    }
    
    [manager.operationQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
}

@end
