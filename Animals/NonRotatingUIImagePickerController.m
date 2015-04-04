//
//  myImagePickerController.m
//  Animals
//
//  Created by Hefang Li on 4/4/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "NonRotatingUIImagePickerController.h"

@interface NonRotatingUIImagePickerController ()

@end

@implementation NonRotatingUIImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end

