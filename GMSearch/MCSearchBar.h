//
//  MCSearchBar.h
//  ESuperVisionProject
//
//  Created by quyanhui on 15/11/13.
//  Copyright © 2015年 dhyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCSearchBarDelegate;
@interface MCSearchBar : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *custom_searchBar_bg;
@property (weak, nonatomic) IBOutlet UIImageView *custom_searchBar_pic;
@property (weak, nonatomic) IBOutlet UIButton *custom_searchBar_cancelBtn;
@property (weak, nonatomic) IBOutlet UITextField *seach_textField;

@property (assign, nonatomic) id <MCSearchBarDelegate> delegate;

- (IBAction)onClickCancelBtn:(id)sender;
- (void)hideKeybord;
@end

@protocol MCSearchBarDelegate <NSObject>

@optional
- (void)searchBarBeginEditing;
- (void)searchBarTextDidChange:(NSString *)searchText;
- (void)searchBarCancelBtnClicked;
- (void)searchBarClickReturn:(NSString *)searchText;


@end
