//
//  BrowseViewController.m
//  Animals
//
//  Created by Hefang Li on 3/20/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "BrowseViewController.h"
#import "UnlockedTableViewCell.h"
#import "LockedTableViewCell.h"
#import "PopCategory.h"

@interface BrowseViewController () <PopCategoryDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) PopCategory *popView;
@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    UINib *cellNib = [UINib nibWithNibName:@"UnlockedTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"UnlockedTVCell"];
    
    cellNib = [UINib nibWithNibName:@"LockedTableViewCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"LockedTVCell"];
    
    self.popView = [PopCategory newPopCategory];
    self.popView.delegate = self;
    self.popView.frame = CGRectMake(215, 60, self.popView.frame.size.width, self.popView.frame.size.height);
    [self.navigationController.view addSubview:self.popView];
    self.popView.hidden = YES;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    NSMutableDictionary *newAttributes = [[NSMutableDictionary alloc] init];
    [newAttributes setObject:[UIFont fontWithName:@"Chalkboard SE" size:22] forKey:UITextAttributeFont];
    [newAttributes setObject:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:newAttributes];
}

#pragma mark - Dropdown menu

- (IBAction)dropdownMenuPressed:(UIButton *)sender {
    self.popView.hidden = NO;
}

- (void)popCategory:(PopCategory *)PopCategory categoryDidChange:(NSString *)category {
    self.navigationController.navigationBar.topItem.title = category;
    self.popView.hidden = YES;
}

#pragma mark - Touch events

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    CGPoint touchLocation = [tapGestureRecognizer locationInView: nil];
    
    CGRect popRect = [self.popView.layer frame];
    if (!CGRectContainsPoint(popRect, touchLocation)) {
        self.popView.hidden = YES;
    }
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

//- (BOOL)isLockedAtIndexPath:(NSIndexPath *)indexPath {
//    RSSItem *item = self.feedItems[indexPath.row];
//    RSSMediaThumbnail *mediaThumbnail = [item.mediaThumbnails firstObject];
//    return mediaThumbnail.url != nil;
//}

@end
