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

@property (nonatomic, strong)NSMutableDictionary *images;
@property (nonatomic, strong) NSMutableDictionary *imageOperations;
@property (nonatomic, strong)NSOperationQueue *queue;

- (void)configureCell:(FISPugCell *)cell forIndexPath:(NSIndexPath *)indexPath;

@end

@implementation ImagesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setAccessibilityIdentifier:@"Pug List"];
    [self.tableView setAccessibilityLabel:@"Pug List"];
    [self setAccessibilityLabel:@"Pug List Controller"];

    self.images = [[NSMutableDictionary alloc] init];
    pugAPI *pugapi = [[pugAPI alloc] init];

    [pugapi getPugsCount:@100 pugBlock:^(UIImage *pugImage, NSIndexPath *ip) {
        [self.images setObject:pugImage forKey:ip];
        [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationAutomatic];
    } completionBlock:nil];

}

- (NSInteger)numberOfPugsInTableView
{
    return 299;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfPugsInTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell" forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(FISPugCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        FISPugCell *pugCell = cell;
        if (self.images[indexPath])
        {
            pugCell.pugImageView.image = self.images[indexPath];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *pugCell = (FISPugCell *)cell;
    pugCell.pugImageView.image = [UIImage imageNamed:@"placeholder"];
}



@end
