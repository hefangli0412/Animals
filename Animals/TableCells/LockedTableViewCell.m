//
//  LockedTableViewCell.m
//  Animals
//
//  Created by Hefang Li on 3/20/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "LockedTableViewCell.h"

@interface LockedTableViewCell()
@end

@implementation LockedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.userIcon.layer.cornerRadius = self.userIcon.frame.size.height/2;
    self.userIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
