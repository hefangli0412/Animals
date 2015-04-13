//
//  MoreTVController.m
//  Animals
//
//  Created by Hefang Li on 4/13/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "MoreTVController.h"

@implementation MoreTVController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    switch (row) {
        case 0:
            NSLog(@"Dating");
            break;
        case 1:{
            NSLog(@"Lost and Found");
            NSString *customURL = @"AnimalsLostAndFound://";
            NSString *appStoreURL = @"http://itunes.apple.com/us/app/apple-store/id375380948?mt=8";
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:customURL]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreURL]];
            }
            break;}
        case 2:
            NSLog(@"Market/Shopping");
            break;
    }
}

@end
