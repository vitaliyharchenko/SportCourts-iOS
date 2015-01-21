//
//  SCUserDetailViewController.h
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 06.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCUser.h"

@interface SCUserDetailViewController : UIViewController

@property (strong,nonatomic) SCUser *user;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;

- (void)setUserData:(SCUser *)userInfo;

@end
