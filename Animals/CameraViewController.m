//
//  CameraViewController.m
//  Animals
//
//  Created by Hefang Li on 4/3/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "CameraViewController.h"
#import "CameraSelectionViewController.h"
#import "FDTakeController.h"

@interface CameraViewController () <
FDTakeDelegate,
UITabBarControllerDelegate
>
@property FDTakeController *takeController;

@property (weak, nonatomic) IBOutlet UIImageView *muzzleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *eyesImageView;
@property (strong, nonatomic) UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *muzzleClickLabel;
@property (weak, nonatomic) IBOutlet UILabel *eyesClickLabel;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = self;
    // You can optionally override action sheet titles
    //	self.takeController.takePhotoText = @"Take Photo";
    //	self.takeController.chooseFromPhotoRollText = @"Choose Existing";
    //	self.takeController.chooseFromLibraryText = @"Choose Existing";
    //	self.takeController.cancelText = @"Cancel";
    //	self.takeController.noSourcesText = @"No Photos Available";
    
    NSBundle* myBundle = [NSBundle bundleWithIdentifier:@"FDTakeTranslations"];
    NSLog(@"%@", myBundle);
    NSString *str = NSLocalizedStringFromTableInBundle(@"noSources",
                                                       nil,
                                                       [NSBundle bundleWithIdentifier:@"FDTakeTranslations"],
                                                       @"There are no sources available to select a photo");
    NSLog(@"%@", str);
    
    self.takeController.allowsEditingPhoto = YES;
    
    // TabBar Controller
    UITabBarController *tbc = (UITabBarController*) self.parentViewController.parentViewController;
    tbc.delegate = self;
}

- (void)takePhotoOrChooseFromLibrary
{
    [self.takeController takePhotoOrChooseFromLibrary];
}

#pragma mark - FDTakeDelegate

- (void)takeController:(FDTakeController *)controller didCancelAfterAttempting:(BOOL)madeAttempt {
}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    [self.selectedImageView setImage:photo];
    if (self.selectedImageView == self.muzzleImageView) {
        self.muzzleClickLabel.hidden = YES;
    } else {
        self.eyesClickLabel.hidden = YES;
    }
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch view] == self.muzzleImageView) {
        self.selectedImageView = self.muzzleImageView;
        [self takePhotoOrChooseFromLibrary];
    } else if ([touch view] == self.eyesImageView) {
        self.selectedImageView = self.eyesImageView;
        [self takePhotoOrChooseFromLibrary];
    }
}

#pragma mark - Segue Condition

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"CameraSegue"])
    {
        // Get reference to the destination view controller
        CameraSelectionViewController *vc = [segue destinationViewController];
        
        vc.muzzleImage = self.muzzleImageView.image;
        vc.eyesImage = self.eyesImageView.image;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"CameraSegue"]) {
        //Put your validation code here and return YES or NO as needed
//        if (self.muzzleImageView.image == nil && self.eyesImageView.image == nil) {
//            UIAlertView *alertView;
//            alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please take photos of animal muzzle and eyes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alertView show];
//            return NO;
//        }
//        if (self.muzzleImageView.image == nil) {
//            UIAlertView *alertView;
//            alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please take photo of animal muzzle" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alertView show];
//            return NO;
//        }
//        if (self.eyesImageView.image == nil) {
//            UIAlertView *alertView;
//            alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please take photo of animal eyes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alertView show];
//            return NO;
//        }
        
        return YES;
    }
    
    return YES;
}

- (void)reset {
    self.muzzleImageView.image = nil;
    self.eyesImageView.image = nil;
    self.selectedImageView = nil;
    self.muzzleClickLabel.hidden = NO;
    self.eyesClickLabel.hidden = NO;
    
    [self.navigationController popToViewController:self animated:NO];
}

@end
