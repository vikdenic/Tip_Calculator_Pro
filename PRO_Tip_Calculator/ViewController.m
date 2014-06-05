//
//  ViewController.m
//  PRO_Tip_Calculator
//
//  Created by Vik Denic on 6/4/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property IBOutlet UITextField *billTextField;

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

    self.billTextField.delegate = self;
    self.billTextField.borderStyle = UITextBorderStyleRoundedRect;
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

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Delegates

//UITextField Formatting

//Locks in a dollar sign at all times
- (IBAction)onBillTextFieldEdited:(id)sender {

    NSString *enteredText = self.billTextField.text;

    if ( [enteredText rangeOfString:@"$" options:NSCaseInsensitiveSearch].location != NSNotFound ) {
        // dollar sign NOT added
    }
    else{
        self.billTextField.text = [NSString stringWithFormat:@"$%@",enteredText];
    }
}

//Restricts textField to only two decimal places
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [self.billTextField.text stringByReplacingCharactersInRange:range withString:string];

    NSArray *sep = [newString componentsSeparatedByString:@"."];
    if([sep count] >= 2)
    {
        NSString *sepStr=[NSString stringWithFormat:@"%@",[sep objectAtIndex:1]];
        return !([sepStr length]>2);
    }
    return YES;
}
@end
