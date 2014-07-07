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
    [self.name becomeFirstResponder];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        // do nothing
    }];
}

- (IBAction)saveButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.createItemDelegate createItemWithName:self.name.text withPass:self.pass.text withDescription:self.description.text];
    }];
}
@end
