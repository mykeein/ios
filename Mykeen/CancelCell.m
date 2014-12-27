//
//  CancelCell.m
//  Mykee
//
//  Created by Ilia Kohanovski on 12/24/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "CancelCell.h"

@implementation CancelCell

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

-(void)awakeFromNib{
    [self.button setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
}

@end
