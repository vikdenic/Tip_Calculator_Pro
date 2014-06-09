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
@property (weak, nonatomic) IBOutlet UIImageView *tenImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fifteenImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twentyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twentyFiveImageView;

@property float billAmount;
@property float tipPercent;

@property float tipAmount;

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
    [self calculateTip];

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
    [self calculateTip];
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

-(void)calculateTip
{
    self.tipAmount = (self.billAmount * self.tipPercent) / self.splitCount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f",self.tipAmount];
}

#pragma mark - Actions

- (IBAction)onTenPressed:(id)sender
{
    [self resetButtons];
    self.tenImageView.image = [UIImage imageNamed:@"ten_selected"];

    self.tipPercent = .10;
    [self calculateTip];
}

- (IBAction)onFifteenPressed:(id)sender
{
    [self resetButtons];
    self.fifteenImageView.image = [UIImage imageNamed:@"fifteen_selected"];

    self.tipPercent = .15;
    [self calculateTip];
}

- (IBAction)onTwentyPressed:(id)sender
{
    [self resetButtons];
    self.twentyImageView.image = [UIImage imageNamed:@"twenty_selected"];
    self.tipPercent = .20;
    NSLog(@"%f",self.tipPercent);
    [self calculateTip];
}

- (IBAction)onTwentyFivePressed:(id)sender
{
    [self resetButtons];
    self.twentyFiveImageView.image = [UIImage imageNamed:@"twentyfive_selected"];

    self.tipPercent = .25;
    [self calculateTip];
}

-(void)resetButtons
{
    self.tenImageView.image = [UIImage imageNamed:@"ten"];
    self.fifteenImageView.image = [UIImage imageNamed:@"fifteen"];
    self.twentyImageView.image = [UIImage imageNamed:@"twenty"];
    self.twentyFiveImageView.image = [UIImage imageNamed:@"twentyfive"];
    [self calculateTip];
}

#pragma mark - Delegates

//UITextField Formatting

//Locks in a dollar sign at all times
- (IBAction)onBillTextFieldEdited:(id)sender {

    NSString *enteredText = self.billTextField.text;
    NSLog(@"ENTEREDTEXT IS %@",enteredText);

    if ( [enteredText rangeOfString:@"$" options:NSCaseInsensitiveSearch].location != NSNotFound ) {
        // dollar sign NOT added
    }
    else{
        self.billTextField.text = [NSString stringWithFormat:@"$%@",enteredText];
    }

    self.billAmount = [enteredText floatValue];
    NSLog(@"bill amount is %f",self.billAmount);
    [self calculateTip];
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
