//
//  SCApi.h
//  SportCourts
//
//  Created by Vitaliy Harchenko on 08.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCUser.h"
#import "SCGame.h"

@interface SCApi : NSObject

//- (void)getUsers:(NSString *)method
//                     parameters:(id)parameters
//                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
-(void)authWithResponceObject:(NSDictionary *)responseObject;
-(void)authWithPassword:(NSString *)password andEmail:(NSString *)email completion:(void (^)(NSError *error))completionHandler;
-(NSString *)passwordFromKeychain;
-(NSString *)emailFromKeychain;

-(void)getUsersAndCompletion:(void (^)(NSMutableArray *users, NSError *error))completionHandler;
-(void)getUserForId:(NSNumber *)userid AndCompletion:(void (^)(SCUser *user, NSError *error))completionHandler;
-(void)getCurrentUserAndCompletion:(void (^)(SCUser *user, NSError *error))completionHandler;

-(void)getGamesAndCompletion:(void (^)(NSMutableArray *games, NSError *error))completionHandler;

@end
