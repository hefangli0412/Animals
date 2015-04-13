//
//  LoginViewController.m
//  Animals
//
//  Created by Hefang Li on 4/3/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController () <FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet FBSDKProfilePictureView *profilePicture;

-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        self.lblLoginStatus.text = @"You are logged in.";
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 self.profilePicture.profileID = result[@"id"];
                 self.lblUsername.text = result[@"name"];
                 self.lblEmail.text = result[@"email"];
             }
         }];
        [self resetRootController];
        
    } else {
        [self toggleHiddenState:YES];
        self.lblLoginStatus.text = @"";
    }
}

-(void)resetRootController {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"root"];// Or any VC with Id
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = vc; // PLEASE READ NOTE ABOUT THIS LINE
    [UIView transitionWithView:appDelegate.window
                      duration:0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ appDelegate.window.rootViewController = vc; }
                    completion:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
//    [[UIApplication sharedApplication].keyWindow setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"root"]];
}

#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    } else if (result.isCancelled) {
        NSLog(@"Login cancelled");
        return;
    } else {
        self.lblLoginStatus.text = @"You are logged in.";
        [self toggleHiddenState:NO];
        [[UIApplication sharedApplication].keyWindow setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"root"]];
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    self.lblLoginStatus.text = @"You are logged out";
    [self toggleHiddenState:YES];
}

@end
