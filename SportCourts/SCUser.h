//
//  SCUser.h
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 05.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCUser : NSObject

@property (strong,nonatomic) NSNumber *user_id;
@property (strong,nonatomic) NSString *first_name;
@property (strong,nonatomic) NSString *last_name;
@property (strong,nonatomic) NSNumber *vkuserid;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *userlevel;
@property (strong,nonatomic) NSNumber *city_id;
@property (strong,nonatomic) NSNumber *height;
@property (strong,nonatomic) NSNumber *weight;
@property (strong,nonatomic) NSString *lasttime;
@property (strong,nonatomic) NSString *sex;
@property (strong,nonatomic) NSString *regdate;
@property (strong,nonatomic) NSString *referer;
@property (strong,nonatomic) NSDictionary *settings;
@property (strong,nonatomic) NSDictionary *city;

+ (SCUser *)parseUserFromDictionary:(NSDictionary *)user;
+ (NSMutableArray *)usersArrayFromDictionary:(NSArray *)users;

@end
