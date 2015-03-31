//
//  PopCategoryWide.h
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopCategoryWide;

@protocol PopCategoryWideDelegate
- (void)PopCategoryWide:(PopCategoryWide *)PopCategoryWide categoryDidChange:(NSString*)category;
@end

@interface PopCategoryWide : UIView

@property (assign) id <PopCategoryWideDelegate> delegate;
+ (id)newPopCategoryWide;

@end
