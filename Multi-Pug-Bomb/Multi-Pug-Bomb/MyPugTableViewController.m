//
//  MyPugTableViewController.m
//  Multi-Pug-Bomb
//
//  Created by Al Tyus on 4/17/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "MyPugTableViewController.h"
#import "FISPugCell.h"
#import "pugAPI.h"
#import "FISPugCell.h"

@interface MyPugTableViewController ()

@end

@implementation MyPugTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 299;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pugCell"  forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
