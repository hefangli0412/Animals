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
#import "DetailViewController.h"

static NSString * const unlockedTVCellIdentifier = @"UnlockedTVCell";
static NSString * const lockedTVCellIdentifier = @"LockedTVCell";

@interface BrowseViewController () <PopCategoryDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) PopCategory *popView;
@property (nonatomic, strong) UnlockedTableViewCell *unlockedPrototypeCell;
@property (nonatomic) CGPoint lastOffset;
@property (nonatomic) NSTimeInterval lastOffsetCapture;
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
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    self.popView.frame = CGRectMake(screenWidth-self.popView.frame.size.width-20, 60, self.popView.frame.size.width, self.popView.frame.size.height);
    [self.navigationController.view addSubview:self.popView];
    self.popView.hidden = YES;
    
    NSMutableDictionary *newAttributes = [[NSMutableDictionary alloc] init];
    [newAttributes setObject:[UIFont fontWithName:@"Chalkboard SE" size:22] forKey:UITextAttributeFont];
    [newAttributes setObject:[UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0] forKey:UITextAttributeTextColor];
    [self.navigationController.navigationBar setTitleTextAttributes:newAttributes];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 400;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.popView.hidden = YES;
}

#pragma mark - Dropdown menu

- (IBAction)dropdownMenuPressed:(UIButton *)sender {
    self.popView.hidden = NO;
}

- (void)popCategory:(PopCategory *)PopCategory categoryDidChange:(NSString *)category {
    self.navigationController.navigationBar.topItem.title = category;
    self.popView.hidden = YES;
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
    
    if (indexPath.row == 0) {
        UnlockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unlockedTVCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.animalImage.image = [UIImage imageNamed:@"dog02.jpeg"];
        return cell;
    } else {
        LockedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:lockedTVCellIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.animalImage.image = [UIImage imageNamed:@"dog04.jpg"];
        return cell;
    }

}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    if (indexPath.row == 0) {
////        return 463;
//        return 400;
//    } else {
//        return 400;
//    }
//    
//}

- (UnlockedTableViewCell *)unlockedPrototypeCell
{
    if (!_unlockedPrototypeCell)
    {
        _unlockedPrototypeCell = [self.tableView dequeueReusableCellWithIdentifier:unlockedTVCellIdentifier];
    }
    return _unlockedPrototypeCell;
}

//- (BOOL)isLockedAtIndexPath:(NSIndexPath *)indexPath {
//    RSSItem *item = self.feedItems[indexPath.row];
//    RSSMediaThumbnail *mediaThumbnail = [item.mediaThumbnails firstObject];
//    return mediaThumbnail.url != nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[UnlockedTableViewCell class]] ) {
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
    }
//    self.someProperty = [self.someArray objectAtIndex:indexPath.row];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint currentOffset = scrollView.contentOffset;
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeDiff = currentTime - self.lastOffsetCapture;
    if(timeDiff > 0.1) {
        CGFloat distance = currentOffset.y - self.lastOffset.y;
        //The multiply by 10, / 1000 isn't really necessary.......
        CGFloat scrollSpeedNotAbs = (distance * 10) / 1000; //in pixels per millisecond
        
        CGFloat scrollSpeed = fabsf(scrollSpeedNotAbs);
        if (scrollSpeed > 0.6) {
            self.popView.hidden = YES;
        }
        
        self.lastOffset = currentOffset;
        self.lastOffsetCapture = currentTime;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        DetailViewController *detailViewController =
        segue.destinationViewController;
        BrowseViewController* tvc = (BrowseViewController*)sender;
        UITableView *tv = tvc.tableView;
        UnlockedTableViewCell *unlockedCell = (UnlockedTableViewCell*)[tv cellForRowAtIndexPath:tv.indexPathForSelectedRow];
        detailViewController.bgImage = unlockedCell.animalImage.image;
    }
}


@end
