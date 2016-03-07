//
//  MCSearchBar.m
//  ESuperVisionProject
//
//  Created by quyanhui on 15/11/13.
//  Copyright © 2015年 dhyt. All rights reserved.
//

#import "MCSearchBar.h"

@implementation MCSearchBar
{
    // 记录custom_searchBar_bg的原始位置
    CGRect custom_searchBar_bg_origin;
    CGRect custom_searchBar_pic_origin;
    
    NSString *node_searchText;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.custom_searchBar_bg.layer.masksToBounds = YES;
    self.custom_searchBar_bg.layer.cornerRadius = 3.0;
    self.seach_textField.delegate = self;
    self.seach_textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.seach_textField.tintColor = hll_color(66, 202, 0, 1);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.seach_textField];
}

- (void)drawRect:(CGRect)rect
{
    custom_searchBar_bg_origin = self.custom_searchBar_bg.frame;
    custom_searchBar_pic_origin = self.custom_searchBar_pic.frame;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.seach_textField)
    {
        if ([self.delegate respondsToSelector:@selector(searchBarBeginEditing)]) {
            [self.delegate searchBarBeginEditing];
        }
        [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
            self.custom_searchBar_bg.frame = CGRectMake(custom_searchBar_bg_origin.origin.x, custom_searchBar_bg_origin.origin.y, custom_searchBar_bg_origin.size.width-50.0, custom_searchBar_bg_origin.size.height);
            self.seach_textField.frame = CGRectMake(custom_searchBar_bg_origin.origin.x+25.0, custom_searchBar_bg_origin.origin.y, custom_searchBar_bg_origin.size.width-75.0, custom_searchBar_bg_origin.size.height);
            self.custom_searchBar_pic.frame = CGRectMake(custom_searchBar_bg_origin.origin.x+5.0, custom_searchBar_pic_origin.origin.y, custom_searchBar_pic_origin.size.width, custom_searchBar_pic_origin.size.height);
            self.custom_searchBar_cancelBtn.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidChange:)]) {
        [self.delegate searchBarTextDidChange:self.seach_textField.text];
    }
    return YES;
}

- (void)textFieldDidChange:(NSNotification*)notification
{
    if (![self.seach_textField.text isEqualToString:node_searchText]) {
        node_searchText = self.seach_textField.text;
        if ([self.delegate respondsToSelector:@selector(searchBarTextDidChange:)]) {
            [self.delegate searchBarTextDidChange:self.seach_textField.text];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(searchBarClickReturn:)]) {
        [self.delegate searchBarClickReturn:textField.text];
    }
    return YES;
}

- (IBAction)onClickCancelBtn:(id)sender {
    self.seach_textField.text = @"";
    [self.seach_textField resignFirstResponder];
    [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
        self.custom_searchBar_bg.frame = custom_searchBar_bg_origin;
        self.seach_textField.frame = custom_searchBar_bg_origin;
        self.custom_searchBar_pic.frame = custom_searchBar_pic_origin;
        self.custom_searchBar_cancelBtn.alpha = 0;
    } completion:^(BOOL finished) {
    }];
    if ([self.delegate respondsToSelector:@selector(searchBarCancelBtnClicked)]) {
        [self.delegate searchBarCancelBtnClicked];
    }
}

- (void)hideKeybord
{
    if ([self.seach_textField canResignFirstResponder]) {
        [self.seach_textField resignFirstResponder];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.seach_textField];
}
@end
