//
//  IconVC.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 10/3/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "IconVC.h"
#import "IconCell.h"

@interface IconVC ()

@end

@implementation IconVC

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IconCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IconCell" forIndexPath:indexPath];
    NSString * imageName = [NSString stringWithFormat:@"icon_%@", @(indexPath.row+1).description];
    [cell.iconButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    cell.iconButton.tag = indexPath.row;
    [cell.iconButton addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 58;
}
-(IBAction)action:(UIButton*)sender{
    NSLog(@"%d", sender.tag);
    NSString * imageName = [NSString stringWithFormat:@"icon_%@", @(sender.tag+1).description];
    [self.delegate setIconWithImageName:imageName];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}
@end
