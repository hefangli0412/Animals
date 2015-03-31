//
//  PopCategory.m
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "PopCategory.h"

@implementation PopCategory

+ (id)newPopCategory {
    UINib *nib = [UINib nibWithNibName:@"PopCategory" bundle:nil];
    NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    PopCategory *me = [nibArray objectAtIndex:0];
    
    me.layer.cornerRadius = 7;
    me.layer.masksToBounds = YES;
    
    return me;
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self.delegate popCategory:self categoryDidChange:sender.titleLabel.text];
}

@end
