//
//  LoginViewController.m
//  Animals
//
//  Created by Hefang Li on 4/3/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged in.";
    
    [self toggleHiddenState:NO];
    
    [[UIApplication sharedApplication].keyWindow setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"root"]];
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
//    NSLog(@"%@", user);
    self.profilePicture.profileID = user.id;
    self.lblUsername.text = user.name;
    self.lblEmail.text = [user objectForKey:@"email"];
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}

@end
