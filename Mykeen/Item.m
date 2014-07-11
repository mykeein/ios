//
//  Item.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/1/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.notes = [aDecoder decodeObjectForKey:@"notes"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.notes forKey:@"notes"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
}
@end
