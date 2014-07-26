//
//  LoginFirstVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/22/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

@interface LoginFirstVC : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *secondTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstTextField;
- (IBAction)firstTextChanged:(id)sender;
- (IBAction)secondTextChanged:(id)sender;
- (IBAction)buttonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
