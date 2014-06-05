//
//  ViewController.m
//  PRO_Tip_Calculator
//
//  Created by Vik Denic on 6/4/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;

@property (weak, nonatomic) IBOutlet UIImageView *downArrowSelectedImage;
@property (weak, nonatomic) IBOutlet UIImageView *upArrowSelectedImage;

@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *upButton;

@property int splitCount;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.splitCount = 1;
}

// Dismisses billTextField's keyboard upon tap-away

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// Splitting the bill

- (IBAction)onUpButtonReleased:(id)sender {
    self.splitCount += 1;
    self.splitLabel.text = [NSString stringWithFormat:@"%d",self.splitCount];

    self.upArrowSelectedImage.alpha = 0;
}

- (IBAction)onDownButtonReleased:(id)sender {
    self.splitCount -= 1;
    self.splitLabel.text = [NSString stringWithFormat:@"%d",self.splitCount];
    self.downArrowSelectedImage.alpha = 0;

    if(self.splitCount < 2)
    {
        self.splitCount = 1;
        self.splitLabel.text = [NSString stringWithFormat:@"%d",self.splitCount];
    }
    self.downArrowSelectedImage.alpha = 0;
}

- (IBAction)onDownButtonTouched:(id)sender {
    self.downArrowSelectedImage.alpha = 1;
}

- (IBAction)onUpButtonTouched:(id)sender {
    self.upArrowSelectedImage.alpha = 1;
}





@end
