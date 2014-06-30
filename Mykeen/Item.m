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
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.imageName forKey:@"imageName"];
}
@end
