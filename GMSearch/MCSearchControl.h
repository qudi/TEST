//
//  MCSearchControl.h
//  ESuperVisionProject
//
//  Created by quyanhui on 15/11/13.
//  Copyright © 2015年 dhyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSearchBar.h"

@protocol MCSearchControlDelegate;
@interface MCSearchControl : UIControl<MCSearchBarDelegate>

@property (strong, nonatomic,readonly) UIViewController *viewController;

@property (assign, nonatomic) id <MCSearchControlDelegate> delegate;
- (id)initWithFrame:(CGRect)frame contensViewController:(UIViewController*)viewController;
- (void)show;
- (void)hidden;

@end

@protocol MCSearchControlDelegate <NSObject>

@optional
- (void)didHidden;

@end
