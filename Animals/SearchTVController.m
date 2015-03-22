//
//  SearchTVController.m
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "SearchTVController.h"
#import "UnlockedTableViewCell.h"
#import "LockedTableViewCell.h"

@interface SearchTVController ()

@end

@implementation SearchTVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
    
    UINib *cellNib = [UINib nibWithNibName:@"UnlockedTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"UnlockedTVCell"];
    
    cellNib = [UINib nibWithNibName:@"LockedTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LockedTVCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *unlockedTVCellIdentifier = @"UnlockedTVCell";
    NSString *lockedTVCellIdentifier = @"LockedTVCell";
    
    if (indexPath.row == 0) {
        UnlockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unlockedTVCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.animalImage.image = [UIImage imageNamed:@"dog02.jpeg"];
        return cell;
    } else {
        LockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lockedTVCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.animalImage.image = [UIImage imageNamed:@"dog02.jpeg"];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {    
    if (indexPath.row == 0) {
        return 463;
    } else {
        return 342;
    }
    
}


@end
