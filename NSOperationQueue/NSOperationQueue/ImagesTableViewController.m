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
    
    self.queue = [[NSOperationQueue alloc]init];
    self.queue.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *imageQueue = [[NSOperationQueue alloc] init];
    imageQueue.maxConcurrentOperationCount = 10;
    
    self.images = [[NSMutableDictionary alloc] init];
    
    NSURL *randomPugURL = [NSURL URLWithString:@"http://pugme.herokuapp.com/random"];
    
    for (NSInteger i = 0; i < [self numberOfPugsInTableView]; i++)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:randomPugURL];
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *responseDictionary = (NSDictionary *)responseObject;
            
            [imageQueue addOperationWithBlock:^{
                NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
                NSData *pugData = [NSData dataWithContentsOfURL:[NSURL URLWithString:responseDictionary[@"pug"]]];
                
                UIImage *pugImage = [UIImage imageWithData:pugData];
                
                if (!pugImage)
                {
                    self.images[ip]= [UIImage imageNamed:@"placeholder"];
                }
                else
                {
                    self.images[ip]=pugImage;
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [self.tableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                    }
                
                
            }];
            
        } failure:nil];
        
        [self.queue addOperation:op];
       
        
    }
    
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
        pugCell.pugImageView.image = self.images[indexPath];
    }];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISPugCell *pugCell = (FISPugCell *)cell;
    pugCell.pugImageView.image = [UIImage imageNamed:@"placeholder"];
}



@end
