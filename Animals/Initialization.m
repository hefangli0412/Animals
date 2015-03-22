//
//  Initialization.m
//  Animals
//
//  Created by Hefang Li on 3/20/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "Initialization.h"
#import "SAMCache.h"

@implementation Initialization

+ (void)initializeWithFakeData {
    SAMCache *cache = [SAMCache sharedCache];
    
    cache[@"Dog1"] = @001;
    cache[@"Dog2"] = @001;
}

@end
