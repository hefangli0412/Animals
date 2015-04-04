//
//  PostViewController.m
//  Animals
//
//  Created by Hefang Li on 3/21/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "PostViewController.h"
#import "PopCategoryWide.h"

@interface PostViewController () <PopCategoryWideDelegate>
@property (weak, nonatomic) IBOutlet UIButton *speciesButton;
@property (weak, nonatomic) IBOutlet UIImageView *muzzleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *eyesImageView;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (strong, nonatomic) PopCategoryWide *popView;
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.muzzleImageView.image = self.muzzleImage;
    self.eyesImageView.image = self.eyesImage;
    
    self.popView = [PopCategoryWide newPopCategoryWide];
    self.popView.delegate = self;
    self.popView.frame = CGRectMake(127, 314+64, self.popView.frame.size.width, self.popView.frame.size.height);
    [self.navigationController.view addSubview:self.popView];
    self.popView.hidden = YES;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.numberTextField.inputAccessoryView = numberToolbar;
}

-(void)doneWithNumberPad{
    if (false) {
        self.numberTextField.text = @"";
    }    
    [self.numberTextField resignFirstResponder];
}

#pragma mark - Dropdown menu
- (IBAction)dropdownMenuPressed:(UIButton *)sender {
    self.popView.hidden = NO;
}

- (void)PopCategoryWide:(PopCategoryWide *)popView categoryDidChange:(NSString *)category {
    [self.speciesButton setTitle:category forState:UIControlStateNormal];
    popView.hidden = YES;
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    CGRect popRect = [self.popView.layer frame];
    if (!CGRectContainsPoint(popRect, touchLocation)) {
        self.popView.hidden = YES;
    }
}


@end