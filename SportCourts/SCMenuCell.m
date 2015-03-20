//
//  SCMenuCell.m
//  SportCourtsMenu1
//
//  Created by Vitaliy Harchenko on 05.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCMenuCell.h"

@implementation SCMenuCell

#pragma mark - UITableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:18.0];
    UIView *selectedBackgroundView = [UIView new];
    selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    self.selectedBackgroundView = selectedBackgroundView;
}

@end
