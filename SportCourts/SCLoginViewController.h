//
//  SCLoginViewController.h
//  SportCourts
//
//  Created by Vitaliy Harchenko on 07.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCLoginViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic) BOOL *firstLaunch;

- (IBAction)loginButton:(id)sender;

@end
