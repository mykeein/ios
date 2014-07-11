//
//  MykeenNewItemVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/7/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "NewItemVC.h"

@interface NewItemVC ()

@end

@implementation NewItemVC

-(void)viewDidAppear:(BOOL)animated{
    [self.itemTitle becomeFirstResponder];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // do nothing
    }];
}

- (IBAction)saveButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.createItemDelegate createItemWithTitle:self.itemTitle.text withUsername:self.userName.text withPass:self.pass.text withNotes:self.notes.text];
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.itemTitle)
        [self.userName becomeFirstResponder];
    else if (textField==self.userName)
        [self.pass becomeFirstResponder];
    else if (textField==self.pass)
        [self.notes becomeFirstResponder];
    else if (textField==self.notes)
        [self saveButtonAction:self];
    
    return YES;
}

- (IBAction)generateButtonClick:(id)sender {
    static NSString * az = @"abcdefghijklmnopqrstuvwxyz";
    static NSString * AZ = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static NSString * numbers = @"0123456789";
    
    NSMutableString *letters = [NSMutableString stringWithCapacity: 200];
    if (self.azSwitch.isOn)
        [letters appendString:az];
    if (self.AZSwitch.isOn)
        [letters appendString:AZ];
    if (self.numbersSwitch.isOn)
        [letters appendString:numbers];
    
    if (![letters length])
        self.pass.text = NSLocalizedString(@"select at least one checkbox", nil);
    else
        self.pass.text = [self randomStringWithLetters:letters];
        
}
-(NSString*)randomStringWithLetters:(NSString*)letters{
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 12];
    
    for (int i=0; i<12; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}
    
@end
