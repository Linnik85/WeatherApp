//
//  ALLocationTableViewCell.m
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALLocationTableViewCell.h"

@implementation ALLocationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        
    } else {
        
        self.accessoryType = UITableViewCellAccessoryNone;
        
    }
}

@end
