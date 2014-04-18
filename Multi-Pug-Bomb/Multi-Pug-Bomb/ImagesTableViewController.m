//
//  ImagesTableViewController.m
//  NSOperationQueue
//
//  Created by Al Tyus on 3/26/14.
//  Copyright (c) 2014 al-tyus.com. All rights reserved.
//

#import "ImagesTableViewController.h"
#import "FISPugCell.h"
#import <AFNetworking/AFNetworking.h>
#import "pugAPI.h"

@interface ImagesTableViewController ()

@property (nonatomic) __block NSMutableDictionary *pugDictionary;

@end

@implementation ImagesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView setAccessibilityIdentifier:@"Pug List"];
    [self.tableView setAccessibilityLabel:@"Pug List"];
    [self setAccessibilityLabel:@"Pug List Controller"];
    
    
    self.tableView.rowHeight = 300.0f;
    
    self.pugDictionary = [NSMutableDictionary new];
    
    [[pugAPI new] getPugsCount:@299 pugBlock:^(UIImage *pugImage, NSIndexPath *ip)
     {
         NSString *indexString = [NSString stringWithFormat:@"%d", ip.row];
         [self.pugDictionary setObject:pugImage forKey:indexString];
         [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationAutomatic];
     }
               completionBlock:
     ^{
         
         NSLog(@"Complete!");
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 299;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *cell = (FISPugCell *)[tableView dequeueReusableCellWithIdentifier:@"pugCell"];
    
    NSString *indexString = [NSString stringWithFormat:@"%d", indexPath.row];
    
    if ([[self.pugDictionary allKeys] containsObject:indexString])
    {
        cell.pugImageView.image = self.pugDictionary[indexString];
    }
    
    return cell;
}

@end
