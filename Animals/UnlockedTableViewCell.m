//
//  UnlockedTableViewCell.m
//  Animals
//
//  Created by Hefang Li on 3/20/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "UnlockedTableViewCell.h"

@interface UnlockedTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@end

@implementation UnlockedTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.userIcon.layer.cornerRadius = self.userIcon.frame.size.height/2;
    self.userIcon.layer.masksToBounds = YES;
    
    self.optionView.layer.cornerRadius = 4;
    self.optionView.layer.masksToBounds = YES;

}

- (void)hideLikeLabel {
    self.commentView.translatesAutoresizingMaskIntoConstraints = YES;
    CGRect newCommentFrame = CGRectMake(self.commentView.frame.origin.x, self.commentView.frame.origin.y - 21, self.commentView.frame.size.width, self.commentView.frame.size.height);
    self.commentView.frame = newCommentFrame;
}
- (IBAction)commentPressed {
    self.optionView.hidden = YES;
}

- (IBAction)likePressed {
    self.optionView.hidden = YES;
}

- (IBAction)morePressed {
    self.optionView.hidden = NO;

}

@end
