//
//  SCApi.m
//  SportCourts
//
//  Created by Vitaliy Harchenko on 08.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCApi.h"
#import "AFNetworking.h"
#import "FDKeychain.h"


#pragma mark Constants

static NSString * const KeychainItem_Service = @"Sportcourts";
static NSString * const KeychainItem_Key_LocalPassword = @"LocalPassword";
static NSString * const KeychainItem_Key_LocalEmail = @"LocalEmail";


@implementation SCApi

-(void)authWithResponceObject:(NSDictionary *)responseObject {
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
}

-(void)authWithPassword:(NSString *)password andEmail:(NSString *)email completion:(void (^)(NSError *error))completionHandler{
    
    NSDictionary *parameters = @{@"email": email, @"password": password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://sportcourts.ru/api/auth" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *authKey = [responseObject objectForKey:@"code"];
        
        // если есть код ошибки
        if (authKey) {
            NSError *error = [[NSError alloc] initWithDomain:@"Api error" code:[authKey integerValue] userInfo:nil];
            completionHandler(error);
        } else {
            [self authWithResponceObject:responseObject];
            
            NSError *error2;
            [FDKeychain saveItem: password
                          forKey: KeychainItem_Key_LocalPassword
                      forService: KeychainItem_Service
                           error: &error2];
            
            NSError *error3;
            [FDKeychain saveItem: email
                          forKey: KeychainItem_Key_LocalEmail
                      forService: KeychainItem_Service
                           error: &error3];
            
            completionHandler(nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(error);
    }];
}

-(NSString *)passwordFromKeychain {
    NSString *password = [FDKeychain itemForKey: KeychainItem_Key_LocalPassword
                                     forService: KeychainItem_Service
                                          error: nil];
    return password;
}

-(NSString *)emailFromKeychain {
    NSString *email = [FDKeychain itemForKey: KeychainItem_Key_LocalEmail
                                  forService: KeychainItem_Service
                                       error: nil];
    return email;
}

-(void)getUsersAndCompletion:(void (^)(NSMutableArray *users, NSError *error))completionHandler{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"SCSettingUserToken"];
    
    NSDictionary *parameters = @{@"token":token, @"fields":@"*"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://sportcourts.ru/api/users/get" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *response = [responseObject objectForKey:@"response"];
        NSMutableArray *users = [SCUser usersArrayFromDictionary:[response objectForKey:@"users"]];
        if (users) {
            completionHandler(users, nil);
        } else {
            completionHandler(nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil,error);
    }];
}

-(void)getUserForId:(NSNumber *)userid AndCompletion:(void (^)(SCUser *user, NSError *error))completionHandler{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"SCSettingUserToken"];
    
    NSDictionary *parameters = @{@"token":token, @"fields":@"*"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:@"http://sportcourts.ru/api/users/get/%@", userid] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *response = [responseObject objectForKey:@"response"];
        NSArray *users = [response objectForKey:@"users"];
        SCUser *user = [SCUser parseUserFromDictionary:[users objectAtIndex:0]];
        if (user) {
            completionHandler(user, nil);
        } else {
            completionHandler(nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil,error);
    }];
}

-(void)getCurrentUserAndCompletion:(void (^)(SCUser *user, NSError *error))completionHandler{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userid = [NSNumber numberWithInteger:[[userDefaults stringForKey:@"SCSettingUserId"] integerValue]];
    
    [self getUserForId:userid AndCompletion:^(SCUser *user, NSError *error) {
        if (user) {
            completionHandler(user, nil);
        } else {
            completionHandler(nil, error);
        }
    }];
}

-(void)getGamesAndCompletion:(void (^)(NSMutableArray *games, NSError *error))completionHandler{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults stringForKey:@"SCSettingUserToken"];
    
    NSDictionary *parameters = @{@"token":token, @"fields":@"*"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:@"http://sportcourts.ru/api/games/get" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableDictionary *response = [responseObject objectForKey:@"response"];
        NSLog(@"Games: %@",[response objectForKey:@"games"]);
        NSMutableArray *games = [SCGame gamesArrayFromDictionary:[response objectForKey:@"games"]];
        if (games) {
            completionHandler(games, nil);
        } else {
            completionHandler(nil,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionHandler(nil,error);
    }];
}

@end
