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

@interface CameraViewController () <
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
@property (nonatomic) UIViewController *currentChildVC;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIBarButtonItem *cameraIdentifier;
@property (strong, nonatomic) UIBarButtonItem *postIdentifier;
@end

@implementation CameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SearchTVController *first = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    first.image = self.image;
    [self presentChildController:first];
    
    // NavigationBar right button settings
    self.cameraIdentifier = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture)];
    self.postIdentifier = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = self.cameraIdentifier;
    
    // ImagePicker settings
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
//    [self takePicture];
}

- (void)done {
    NSLog(@"Done");
}

- (void)presentChildController:(UIViewController*)childVC
{
    if (self.currentChildVC) {
        [self removeCurrentChildViewController];
    }
    
    [self addChildViewController:childVC];
    
    childVC.view.frame = [self frameForContainerController];
    
    [self.containerView addSubview:childVC.view];
    self.currentChildVC = childVC;
    
    [childVC didMoveToParentViewController:self];
    
}

- (void)removeCurrentChildViewController
{
    [self.currentChildVC willMoveToParentViewController:nil];
    [self.currentChildVC.view removeFromSuperview];
    [self.currentChildVC removeFromParentViewController];
}

- (CGRect)frameForContainerController
{
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

#pragma mark - Image Picker Controller delegate

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.image == nil) {
        [self takePicture];
    }
}

- (void)takePicture
{
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.image = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication].keyWindow setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"root"]];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        // A photo was taken/selected!
        self.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            // Save the image!
            UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil);
        }
    }
    else {
        NSLog(@"Wrong media type");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
