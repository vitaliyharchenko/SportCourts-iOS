//
//  SCUserDetailViewController.h
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 06.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCGame.h"

@interface SCGameDetailViewController : UIViewController

@property (strong,nonatomic) SCGame *user;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
- (IBAction)callAction:(id)sender;

@end
