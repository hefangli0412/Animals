//
//  CameraViewController.m
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "CameraSelectionViewController.h"
#import "SearchTVController.h"
#import "PostViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "YCameraViewController.h"

@interface CameraSelectionViewController () <UITabBarControllerDelegate>
@property (nonatomic) UIViewController *currentChildVC;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
//@property (strong, nonatomic) UIBarButtonItem *cameraIdentifier;
@property (strong, nonatomic) UIBarButtonItem *postIdentifier;
@end

@implementation CameraSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchTVController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
//    first.image = self.image;
    [self presentChildController:first];
    
    // NavigationBar right button settings
//    self.cameraIdentifier = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto)];
    self.postIdentifier = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
//    self.navigationItem.rightBarButtonItem = self.cameraIdentifier;
    self.navigationItem.rightBarButtonItem = nil;
    
//    UITabBarController *tbc = (UITabBarController*) self.parentViewController.parentViewController;
//    tbc.delegate = self;
}

- (void)done {
    NSLog(@"Done");
}

- (void)presentChildController:(UIViewController*)childVC {
    if (self.currentChildVC) {
        [self removeCurrentChildViewController];
    }
    
    [self addChildViewController:childVC];
    
    childVC.view.frame = [self frameForContainerController];
    
    [self.containerView addSubview:childVC.view];
    self.currentChildVC = childVC;
    
    [childVC didMoveToParentViewController:self];
    
}

- (void)removeCurrentChildViewController {
    [self.currentChildVC willMoveToParentViewController:nil];
    [self.currentChildVC.view removeFromSuperview];
    [self.currentChildVC removeFromParentViewController];
}

- (CGRect)frameForContainerController {
    CGRect containerFrame = self.containerView.bounds;
    return containerFrame;
}

- (IBAction)changeSegControl:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0) {
        SearchTVController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
//        first.image = self.image;
        [self presentChildController:first];
//        self.navigationItem.rightBarButtonItem = self.cameraIdentifier;
        self.navigationItem.rightBarButtonItem = nil;
    }
    
     if(sender.selectedSegmentIndex == 1) {
         PostViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"PostViewController"];
         second.muzzleImage = self.muzzleImage;
         second.eyesImage = self.eyesImage;
         [self presentChildController:second];
         self.navigationItem.rightBarButtonItem = self.postIdentifier;
     }
}

@end
