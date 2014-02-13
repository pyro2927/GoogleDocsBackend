//
//  GDBExampleCell.m
//  Example
//
//  Created by Joseph Pintozzi on 2/13/14.
//  Copyright (c) 2014 Pintozzi. All rights reserved.
//

#import "GDBExampleCell.h"

@implementation GDBExampleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
