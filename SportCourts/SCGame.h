//
//  SCUser.h
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 05.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCGame : NSObject

@property (strong,nonatomic) NSString *gameDescription;

+ (SCGame *)parseGameFromDictionary:(NSDictionary *)user;
+ (NSMutableArray *)gamesArrayFromDictionary:(NSArray *)users;

@end
