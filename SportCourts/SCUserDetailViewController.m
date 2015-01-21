//
//  SCUserDetailViewController.m
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 06.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCUserDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SCUserDetailViewController ()

@end

@implementation SCUserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@",_user.first_name,_user.last_name];
    
    NSString *avatarUrlString = [NSString stringWithFormat:@"http://sportcourts.ru/images/avatars/%@", _user.user_id];
    NSURL *avatarUrl = [NSURL URLWithString:avatarUrlString];
    [self.avatar setImageWithURL:avatarUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUserData:(SCUser *)userInfo {
    _user = userInfo;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
