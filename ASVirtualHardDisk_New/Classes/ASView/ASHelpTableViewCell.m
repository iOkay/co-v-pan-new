//
//  ASHelpTableViewCell.m
//  ASVirtualHardDisk
//
//  Created by dhc on 11-12-22.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASHelpTableViewCell.h"


@implementation ASHelpTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor grayColor];
    [super touchesBegan: touches withEvent: event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor whiteColor];
    [super touchesCancelled: touches withEvent: event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.backgroundColor = [UIColor whiteColor];
    [super touchesEnded: touches withEvent: event];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
