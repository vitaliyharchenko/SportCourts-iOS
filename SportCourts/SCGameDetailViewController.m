//
//  SCUserDetailViewController.m
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 06.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCGameDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SCGameDetailViewController ()

@end

@implementation SCGameDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@",_user.first_name,_user.last_name];
    _cityLabel.text = [_user.city objectForKey:@"title"];
    [_phoneButton setTitle:_user.phone forState:UIControlStateNormal];
    
    NSString *avatarUrlString = [NSString stringWithFormat:@"http://sportcourts.ru/images/avatars/%@", _user.user_id];
    NSURL *avatarUrl = [NSURL URLWithString:avatarUrlString];
    [self.avatar setImageWithURL:avatarUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callAction:(id)sender {
    NSString *cleanedString = [[_user.phone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *phoneString = [NSString stringWithFormat:@"telprompt://%@", cleanedString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneString]];
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
