//
//  FISPugCell.m
//  NSOperationQueue
//
//  Created by Joe Burgess on 3/24/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISPugCell.h"

@implementation FISPugCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
        UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
        self.pugImageView.image=placeholderImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
