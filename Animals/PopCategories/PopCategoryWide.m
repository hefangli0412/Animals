//
//  PopCategoryWide.m
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "PopCategoryWide.h"

@implementation PopCategoryWide

+ (id)newPopCategoryWide {
    UINib *nib = [UINib nibWithNibName:@"PopCategoryWide" bundle:nil];
    NSArray *nibArray = [nib instantiateWithOwner:self options:nil];
    PopCategoryWide *me = [nibArray objectAtIndex:0];
    
    me.layer.cornerRadius = 5;
    me.layer.masksToBounds = YES;
    return me;
}

- (IBAction)buttonPressed:(UIButton *)sender {
    [self.delegate PopCategoryWide:self categoryDidChange:sender.titleLabel.text];
}

@end
