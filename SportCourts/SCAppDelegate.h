//
//  AppDelegate.h
//  SportCourts
//
//  Created by Vitaliy Harchenko on 06.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

@class MSDynamicsDrawerViewController;

#import "SCMenuViewController.h"

@interface SCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
@property (strong, nonatomic) SCMenuViewController *menuViewController;

- (void)initWindowWithDynamicsDrawer;
- (void)initWindowWithLoginAndAuth:(BOOL)auth;

@end

