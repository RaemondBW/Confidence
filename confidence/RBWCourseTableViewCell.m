//
//  RBWCourseTableViewCell.m
//  confidence
//
//  Created by Raemond on 4/30/14.
//  Copyright (c) 2014 Raemond. All rights reserved.
//

#import "RBWCourseTableViewCell.h"

@implementation RBWCourseTableViewCell
@synthesize courseLabel;
@synthesize schoolLable;

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
