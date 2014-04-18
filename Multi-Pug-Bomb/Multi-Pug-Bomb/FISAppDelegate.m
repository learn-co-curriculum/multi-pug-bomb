//
//  FISAppDelegate.m
//  Multi-Pug-Bomb
//
//  Created by Joe Burgess on 4/16/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISAppDelegate.h"
#import "pugAPI.h"

#import <OHHTTPStubs.h>
static BOOL isRunningTests(void) __attribute__((const));

@implementation FISAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    /**
     *  This is to stub out the HTTP requests when run as tests.
     */
    
    if (isRunningTests())
    {
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.absoluteString isEqualToString:@"http://pugme.herokuapp.com/random"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"output" ofType:@"json"];
            OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithFileAtPath:path statusCode:200 headers:@{@"Content-Type": @"application/json"}];
            return [response requestTime:0.5 responseTime:0.5];
        }];
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.absoluteString isEqualToString:@"http://24.media.tumblr.com/tumblr_lsvczkC8e01qzgqodo1_500.jpg"];
        } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"pug" ofType:@"jpg"];
            OHHTTPStubsResponse *response = [OHHTTPStubsResponse responseWithFileAtPath:path statusCode:200 headers:@{@"Content-Type": @"image/jpeg"}];
            
            return response;
        }];
        
        return YES;
    }

    return YES;
    
    #pragma clang diagnostic push //suppress warning for extra space due to comments
}

#pragma clang diagnostic pop
/**
 *  Checks to see if running as a Test
 *
 *  @return YES or NO
 */

static BOOL isRunningTests(void)
{
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    NSString *injectBundle = environment[@"XCInjectBundle"];
    
    return [[injectBundle pathExtension] isEqualToString:@"xctest"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
