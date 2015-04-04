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
@property (weak, nonatomic) IBOutlet UILabel *birthdayDateLabel;
@property (weak, nonatomic) IBOutlet UIView *datePickerSuperView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) PopCategoryWide *popView;
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.muzzleImageView.image = self.muzzleImage;
    self.eyesImageView.image = self.eyesImage;
    
    self.popView = [PopCategoryWide newPopCategoryWide];
    self.popView.delegate = self;
    
//    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
//    numberToolbar.barStyle = UIBarStyleDefault;
//    numberToolbar.items = [NSArray arrayWithObjects:
//                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
//                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
//                           nil];
//    [numberToolbar sizeToFit];
//    self.numberTextField.inputAccessoryView = numberToolbar;
}

//- (void)doneWithNumberPad{
//    if (false) {
//        self.numberTextField.text = @"";
//    }    
//    [self.numberTextField resignFirstResponder];
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    UIAlertView *alertView;
//    alertView = [[UIAlertView alloc] initWithTitle:@"Discard the changes?" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Leave",nil];
//    [alertView show];
//}

#pragma mark - Dropdown menu
- (IBAction)speciesDropdownMenuPressed:(UIButton *)sender {
    CGFloat x = sender.frame.origin.x;
    CGFloat y = sender.frame.origin.y;
    CGFloat width = sender.frame.size.width;
    CGFloat height = sender.frame.size.height;
    CGRect newFrame = CGRectMake(x, y+height, width, self.popView.frame.size.height);
    self.popView.frame = newFrame;
    [self.view addSubview:self.popView];
}

- (void)PopCategoryWide:(PopCategoryWide *)popView categoryDidChange:(NSString *)category {
    [self.speciesButton setTitle:category forState:UIControlStateNormal];
    [self.popView removeFromSuperview];
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    CGRect popRect = [self.popView.layer frame];
    CGRect birthdayRect = [self.popView.layer frame];
    if (!CGRectContainsPoint(popRect, touchLocation)) {
        [self.popView removeFromSuperview];
    }
    if (CGRectContainsPoint(birthdayRect, touchLocation)) {
//        self.datePickerSuperView.hidden = NO;
    }
}


@end