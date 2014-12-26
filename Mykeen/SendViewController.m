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
#import "NSString+Crypto.h"


@interface SendViewController ()<UIActionSheetDelegate>
- (IBAction)cancelButtonAction:(id)sender;

@property Item * selectedItem;

@end
@implementation SendViewController

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.tableView reloadData];
}
-(NSArray*)filterItemsBySearch{
    NSString * filterString = [NSString stringWithFormat:@"title like '%@*'",self.searchBar.text]; //another option @"title beginswith[c] James" or contains[cd]
    NSPredicate * predicate = [NSPredicate predicateWithFormat:filterString];
    NSArray * result = [self.items filteredArrayUsingPredicate:predicate];
    return result;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (![self.searchBar.text isEqualToString:@""])
        return [[self filterItemsBySearch]count] + 1;
    else
        return [self.items count] + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.tableView numberOfRowsInSection:0]-1 ) {
        UITableViewCell * cancellCell = [self.tableView dequeueReusableCellWithIdentifier:@"CancelCell"];
        cancellCell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    if (indexPath.row == self.items.count )
        return;

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
    NSString * data;
    if (buttonIndex == index){
        data = self.selectedItem.username;
    }else if (buttonIndex == ++index){
        data = self.selectedItem.password;
    }else if (buttonIndex == ++index){
        data = self.selectedItem.notes;
    }
    NSString *encryptedData = [data encryptedStringWithPass:[Utils getPass] error:nil];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"email": [Utils getEmail], @"registerId":[Utils uuid], @"requestId" : self.requestId, @"data": encryptedData};
    
    NSLog(@"data %@",data);
    
    NSString * reqString = [NSString stringWithFormat:@"%@/api/requests/send?os=ios&ln=%@",MYKEE_URL,LANG];
    [manager POST:reqString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

     }];
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
