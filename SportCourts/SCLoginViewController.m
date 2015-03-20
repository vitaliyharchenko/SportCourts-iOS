//
//  SCLoginViewController.m
//  SportCourts
//
//  Created by Vitaliy Harchenko on 07.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCLoginViewController.h"
#import "SCAppDelegate.h"
#import "SCApi.h"


@interface SCLoginViewController ()

@end


@implementation SCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_emailField setDelegate:self];
    [_passwordField setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    SCApi *api = [[SCApi alloc] init];
    NSString *email = [api emailFromKeychain];
    NSString *password = [api passwordFromKeychain];
    if (password && email) {
        [_emailField setText:email];
        [_passwordField setText:password];
        
        if (self.firstLaunch) {
            [self loginButton:self];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButton:(id)sender {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    NSString *email = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    SCApi *api = [[SCApi alloc] init];
    [api authWithPassword:password andEmail:email completion:^(NSError *error){
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка авторизации" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [self.activityIndicator setHidden:YES];
        } else {
            [self.activityIndicator setHidden:YES];
            
            SCAppDelegate *app = [[UIApplication sharedApplication] delegate];
            [app initWindowWithDynamicsDrawer];
            NSLog(@"BasicInit");
        }
    }];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}
@end
