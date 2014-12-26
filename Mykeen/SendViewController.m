//
//  SendViewController.m
//  Mykee
//
//  Created by Ilia Kohanovski on 11/29/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "SendViewController.h"
#import "Item.h"
#import "ItemCell.h"


@interface SendViewController ()<UIActionSheetDelegate>
- (IBAction)cancelButtonAction:(id)sender;

@property Item * selectedItem;

@end
@implementation SendViewController

-(NSArray*)filterItemsBySearch{
    NSString * filterString = [NSString stringWithFormat:@"title like '%@*'",self.searchBar.text]; //another option @"title beginswith[c] James" or contains[cd]
    NSPredicate * predicate = [NSPredicate predicateWithFormat:filterString];
    NSArray * result = [self.items filteredArrayUsingPredicate:predicate];
    return result;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView!=self.tableView){
        if (![self.searchBar.text isEqualToString:@""])
            return [[self filterItemsBySearch]count];
        else
            return 0;
    }
    
    return [self.items count] + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.items.count ) {
        UITableViewCell * cancellCell = [self.tableView dequeueReusableCellWithIdentifier:@"CancelCell"];
        return cancellCell;
    }
    static NSString* itemCellIdentifier = @"ItemCell";
    ItemCell * cell = [self.tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    Item * item = self.items[indexPath.row];
    cell.nameLabel.text = item.title;
    cell.iconImage.image = [UIImage imageNamed:item.iconImageName];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * userName = NSLocalizedString(@"Username", nil);
    NSString * password = NSLocalizedString(@"Password", nil);
    NSString * notes = NSLocalizedString(@"Notes", nil);
    NSString * cancel = NSLocalizedString(@"Cancel", nil);
    Item * item = self.items[indexPath.row];
    self.selectedItem = item;
   
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:item.title delegate:self cancelButtonTitle:cancel destructiveButtonTitle:nil otherButtonTitles:userName,password, notes, nil];
    [actionSheet showInView:self.view];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.cancelButtonIndex == buttonIndex)
        return;
    int index = actionSheet.firstOtherButtonIndex;
    NSString * toastText;
    NSString * copy;
    if (buttonIndex == index){
        copy = self.selectedItem.username;
        toastText = NSLocalizedString(@"username copied", nil);
    }else if (buttonIndex == ++index){
        copy = self.selectedItem.password;
        toastText = NSLocalizedString(@"password copied", nil);
    }else if (buttonIndex == ++index){
        copy = self.selectedItem.notes;
        toastText = NSLocalizedString(@"notes copied", nil);
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)cancelButtonAction:(id)sender {

}
@end
