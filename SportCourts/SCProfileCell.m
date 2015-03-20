//
//  SCProfileCell.m
//  SportCourts
//
//  Created by Vitaliy Kharchenko on 20.03.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCProfileCell.h"

@implementation SCProfileCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.textArea.textColor = [UIColor whiteColor];
    self.textArea.font = [UIFont systemFontOfSize:18.0];
    UIView *selectedBackgroundView = [UIView new];
    selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    self.selectedBackgroundView = selectedBackgroundView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
