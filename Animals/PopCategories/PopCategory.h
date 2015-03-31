//
//  PopCategory.h
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopCategory;

@protocol PopCategoryDelegate
- (void)popCategory:(PopCategory *)popCategory categoryDidChange:(NSString*)category;
@end

@interface PopCategory : UIView
@property (assign) id <PopCategoryDelegate> delegate;
+ (id)newPopCategory;
@end
