//
//  SCUser.m
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 05.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCUser.h"

@implementation SCUser

+ (SCUser *)parseUserFromDictionary:(NSDictionary *)userDict {
    SCUser *user = [[SCUser alloc] init];
    user.first_name = [userDict objectForKey:@"first_name"];
    user.last_name = [userDict objectForKey:@"last_name"];
    user.user_id = [userDict objectForKey:@"user_id"];

    return user;
}

+ (NSString *)parseIdFromDictionary:(NSDictionary *)userDict {
    SCUser *user = [[SCUser alloc] init];
    user.first_name = [userDict objectForKey:@"first_name"];
    user.last_name = [userDict objectForKey:@"last_name"];
    user.user_id = [userDict objectForKey:@"user_id"];
    
    return user;
}

+ (NSMutableArray *)usersArrayFromDictionary:(NSArray *)users {
    
    NSMutableArray *usersArray = [[NSMutableArray alloc] init];
    
    // не включаем собственный user_id
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [userDefaults stringForKey:@"SCSettingUserId"];
    NSInteger user_idInt = [user_id integerValue];
    
    NSInteger i;
    for (i=0; i<users.count; i++) {
        if (user_idInt) {
            if (i == user_idInt) {
                continue;
            }
        }
        NSDictionary *userDict = [users objectAtIndex:i];
        SCUser *userRow = [SCUser parseUserFromDictionary:userDict];
        [usersArray addObject:userRow];
    }
    return usersArray;
}

@end
