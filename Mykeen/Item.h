//
//  Item.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/1/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>

@property NSString *title;
@property NSString *username;
@property NSString *imageName;
@property NSString *notes;
@property NSString *password;

@end
