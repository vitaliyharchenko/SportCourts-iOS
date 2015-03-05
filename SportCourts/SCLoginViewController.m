//
//  SCLoginViewController.m
//  SportCourts
//
//  Created by Vitaliy Harchenko on 07.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCLoginViewController.h"
#import "SCAppDelegate.h"
#import "AFNetworking.h"
#import "SCAppDelegate.h"
#import "SCMenuViewController.h"

@interface SCLoginViewController ()

@end

@implementation SCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.activityIndicator startAnimating];
//    
//    NSString *email = @"harchenko.grape@gmail.com";
//    NSString *password = @"123456";
//    
//    NSDictionary *parameters = @{@"email": email, @"password": password};
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager GET:@"http://sportcourts.ru/api/auth" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSNumber *authKey = [responseObject objectForKey:@"code"];
//        
//        // если есть код ошибки
//        if (authKey) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка авторизации" message:[responseObject objectForKey:@"description"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alertView show];
//            [self.activityIndicator setHidden:YES];
//        } else {
//            // записываем токен и айди пользователя
//            NSString *token = [responseObject objectForKey:@"token"];
//            NSString *user_id = [responseObject objectForKey:@"user_id"];;
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSMutableDictionary *registerDefaults = [NSMutableDictionary dictionary];
//            [registerDefaults setObject:token forKey:@"SCSettingUserToken"];
//            [registerDefaults setObject:user_id forKey:@"SCSettingUserId"];
//            [userDefaults registerDefaults:registerDefaults];
//            [userDefaults synchronize];
//            
//            NSLog(@"Success auth");
//            
//            [self.activityIndicator setHidden:YES];
//            
//            SCAppDelegate *app = [[UIApplication sharedApplication] delegate];
//            [app initWindowWithDynamicsDrawer];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"API Auth Connection Error: %@", error);
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//    }];

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
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    NSString *email = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    NSDictionary *parameters = @{@"email": email, @"password": password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://sportcourts.ru/api/auth" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *authKey = [responseObject objectForKey:@"code"];
        
        // если есть код ошибки
        if (authKey) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка авторизации" message:[responseObject objectForKey:@"description"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [self.activityIndicator setHidden:YES];
        } else {
            // записываем токен и айди пользователя
            NSMutableDictionary *response = [responseObject objectForKey:@"response"];
            NSString *token = [response objectForKey:@"token"];
            NSString *user_id = [response objectForKey:@"user_id"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSMutableDictionary *registerDefaults = [NSMutableDictionary dictionary];
            [registerDefaults setObject:token forKey:@"SCSettingUserToken"];
            [registerDefaults setObject:user_id forKey:@"SCSettingUserId"];
            [userDefaults registerDefaults:registerDefaults];
            [userDefaults synchronize];
            
            [self.activityIndicator setHidden:YES];
            
            SCAppDelegate *app = [[UIApplication sharedApplication] delegate];
            [app initWindowWithDynamicsDrawer];
            NSLog(@"BasicInit");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"API Auth Connection Error: %@", error);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }];
}
@end
