//
//  CameraViewController.m
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "CameraViewController.h"
#import "SearchTVController.h"
#import "PostViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "YCameraViewController.h"

@interface CameraViewController () <
UITabBarControllerDelegate,
YCameraViewControllerDelegate
>
@property (nonatomic) UIViewController *currentChildVC;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIBarButtonItem *cameraIdentifier;
@property (strong, nonatomic) UIBarButtonItem *postIdentifier;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchTVController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    first.image = self.image;
    [self presentChildController:first];
    
    // NavigationBar right button settings
    self.cameraIdentifier = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto)];
    self.postIdentifier = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = self.cameraIdentifier;
    
    UITabBarController *tbc = (UITabBarController*) self.parentViewController.parentViewController;
    tbc.delegate = self;
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

- (void)backToHome {
    UITabBarController *tabBarController = (UITabBarController *)self.parentViewController.parentViewController;
    dispatch_async(dispatch_get_main_queue(), ^{
        [tabBarController setSelectedIndex:0];
    });

}

- (IBAction)changeSegControl:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0) {
        SearchTVController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
        first.image = self.image;
        [self presentChildController:first];
        self.navigationItem.rightBarButtonItem = self.cameraIdentifier;
    }
     
     if(sender.selectedSegmentIndex == 1) {
         PostViewController *second = [self.storyboard instantiateViewControllerWithIdentifier:@"PostViewController"];
         second.firstImage = self.image;
         [self presentChildController:second];
         self.navigationItem.rightBarButtonItem = self.postIdentifier;
     }
}

#pragma mark - YCameraViewController Delegate

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.image == nil) {
        [self takePhoto];
    }
}

//-(void)viewWillDisappear:(BOOL)animated { // change to tab delegate whenever change
//    self.image = nil;
//}

- (void)setImageNil {
    self.image = nil;
    NSLog(@"setImageNil");
}

- (void)takePhoto {
    YCameraViewController *camController = [[YCameraViewController alloc] initWithNibName:@"YCameraViewController" bundle:nil];
    camController.delegate=self;
    [self presentViewController:camController animated:YES completion:^{
        // completion code
    }];
}


- (void)didFinishPickingImage:(UIImage *)image {
    self.image = image;
}

- (void)yCameraControllerdidSkipped {
    self.image = nil;
    
    [[UIApplication sharedApplication].keyWindow setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"root"]];
}

- (void)yCameraControllerDidCancel {
}

@end
