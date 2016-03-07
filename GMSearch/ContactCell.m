//
//  ContactCell.m
//  ESuperVisionProject
//
//  Created by quyanhui on 15/11/12.
//  Copyright © 2015年 dhyt. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    // Initialization code
    self.badge_label.layer.cornerRadius = 10.0;
    self.badge_label.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBadge:(NSInteger)badge
{
    _badge = badge;
    if (badge > 0) {
        self.badge_label.hidden = NO;
    }
    else{
        self.badge_label.hidden = YES;
    }
    
    if (badge > 99) {
        self.badge_label.text = @"N+";
    }
    else{
        self.badge_label.text = [NSString stringWithFormat:@"%ld", (long)_badge];
    }
}

@end
