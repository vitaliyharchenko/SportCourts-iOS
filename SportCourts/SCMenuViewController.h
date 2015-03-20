//
//  SCMenuViewController.h
//  SportCourts
//
//  Created by Vitaliy Harchenko on 07.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

typedef NS_ENUM(NSUInteger, SCPaneViewControllerType) {
    SCPaneViewControllerTypeProfile,
    SCPaneViewControllerTypeUsers,
    SCPaneViewControllerTypeGames,
    SCPaneViewControllerTypeLogout,
    SCPaneViewControllerTypeLogin,
    SCPaneViewControllerTypeCount
};

@interface SCMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) SCPaneViewControllerType paneViewControllerType;
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

- (void)transitionToViewController:(SCPaneViewControllerType)paneViewControllerType;

@end
