//
//  MCSearchControl.m
//  ESuperVisionProject
//
//  Created by quyanhui on 15/11/13.
//  Copyright © 2015年 dhyt. All rights reserved.
//

#import "MCSearchControl.h"
#import "ContactCell.h"
#import "UserDesVC.h"

#define Cell_idenfifier @"contactCell"
@interface MCSearchControl ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MCSearchControl
{
    MCSearchBar *searchBar;
    UITableView *content_tableView;
    
    NSMutableArray *searchResultsSource;
}

- (id)initWithFrame:(CGRect)frame contensViewController:(UIViewController*)viewController
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewController = viewController;
        searchResultsSource = [NSMutableArray array];
        [self loadNeedViews];
        [self addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchDown];

        self.hidden = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        searchResultsSource = [NSMutableArray array];
        [self loadNeedViews];
        [self addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchDown];
        self.hidden = YES;
    }
    return self;
}

- (void)loadNeedViews
{
    searchBar = [[[NSBundle mainBundle] loadNibNamed:@"MCSearchBar" owner:self options:nil]lastObject];
    searchBar.delegate = self;
    searchBar.top_ext = 20.0;
    searchBar.width_ext = self.width_ext;
    [self addSubview:searchBar];
    
    content_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, searchBar.top_ext+searchBar.height_ext, self.width_ext, self.height_ext-searchBar.top_ext-searchBar.height_ext) style:UITableViewStylePlain];
    [self addSubview:content_tableView];
    content_tableView.hidden = YES;
    content_tableView.delegate = self;
    content_tableView.dataSource = self;
    [content_tableView registerNib:[UINib nibWithNibName:@"ContactCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:Cell_idenfifier];
    content_tableView.rowHeight = 45.0;
}

#pragma mark - show or hidden operation
- (void)show
{
    [self.viewController.navigationController setNavigationBarHidden:YES animated:YES];
    self.hidden = NO;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.15*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    });
    [searchBar.seach_textField becomeFirstResponder];
}

- (void)hidden
{
    [self.viewController.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.hidden = YES;
    [searchBar.seach_textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didHidden)]) {
        [self.delegate didHidden];
    }
}


#pragma mark - Search delegate
- (void)searchBarCancelBtnClicked
{
    [self hidden];
    [searchResultsSource removeAllObjects];
    [content_tableView reloadData];
    content_tableView.hidden = YES;
}

- (void)searchBarTextDidChange:(NSString *)searchText
{
    
}

- (void)searchBarClickReturn:(NSString *)searchText
{
    [self requestFindFriendByPhone:searchText];
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchResultsSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_idenfifier];
    
    cell.user_name.text = [[searchResultsSource objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.user_title.text = [[searchResultsSource objectAtIndex:indexPath.row] objectForKey:@"title"];
    [cell.user_pic setImageWithURLString:[[searchResultsSource objectAtIndex:indexPath.row] objectForKey:@"user_pic"] placeholderImage:D_UserHeadImageDefault];
    return cell;
}

#pragma mark - request

- (void)requestFindFriendByPhone:(NSString*)phoneNumber
{
    JGProgressHUD *hud = [JGProgressHUD showMeaasge:nil WithView:self];
    __weak typeof(self) weakself = self;
    [[AFHttpClient sharedClient] Get_execute:[NSString stringWithFormat:@"%@/%@",D_findUserByPhone,phoneNumber] params:nil callback:^(QResponse *response) {
        [hud dismissAnimated:YES];
        if (response.errcode == 200) {
            NSDictionary *user = [response.QResponseMeassage objectForKey:@"user"];
            [searchResultsSource addObject:user];
            [content_tableView reloadData];
            content_tableView.hidden = NO;
            UserDesVC *userDes = [[UserDesVC alloc] initWithNibName:@"UserDesVC" bundle:nil];
            userDes.user_dic = user;
            [_viewController.navigationController pushViewController:userDes animated:YES];
            [weakself hidden];
        }else
        {
            [JGProgressHUD showErrorWithMeassage:response.QResponseMeassage withView:weakself];
        }
    }];

}

@end
