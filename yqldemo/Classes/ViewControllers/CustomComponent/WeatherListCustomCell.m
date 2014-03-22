//
//  WeatherListCustomCell.m
//  YqlDemo
//
//  Created by Aniruddha  on 12/03/14.
//  Copyright (c) 2014 aniruddha. All rights reserved.
//

#import "WeatherListCustomCell.h"

@implementation WeatherListCustomCell
@synthesize cityNameLbl, tempLbl,arrowImg;
@synthesize delegate;
@synthesize btn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

- (IBAction)btnAction:(UIButton *)sender
{
    if (delegate) {
        [delegate buttonAction:sender.tag];
    }
}

@end
