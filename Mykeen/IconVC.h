//
//  IconVC.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 10/3/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpdateIconDelegate <NSObject>
@required
-(void)setIconWithImageName:(NSString*)imageName;
@end

@interface IconVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

- (IBAction)cancelButtonAction:(id)sender;
@property id<UpdateIconDelegate> delegate;


@end
