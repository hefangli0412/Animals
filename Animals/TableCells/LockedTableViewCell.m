//
//  LockedTableViewCell.m
//  Animals
//
//  Created by Hefang Li on 3/20/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "LockedTableViewCell.h"

@interface LockedTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@end

@implementation LockedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.userIcon.layer.cornerRadius = self.userIcon.frame.size.height/2;
    self.userIcon.layer.masksToBounds = YES;
    
    self.optionView.layer.cornerRadius = 4;
    self.optionView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)likePressed {
    self.optionView.hidden = YES;
}

- (IBAction)morePressed {
    self.optionView.hidden = NO;
    
}

@end
