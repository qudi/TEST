//
//  ContactCell.h
//  ESuperVisionProject
//
//  Created by quyanhui on 15/11/12.
//  Copyright © 2015年 dhyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *user_pic;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_title;
@property (weak, nonatomic) IBOutlet UILabel *badge_label;

@property (nonatomic) NSInteger badge;

@end
