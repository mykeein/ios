//
//  EmailViewController.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 9/19/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)saveAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *notApprovedButton;

@end
