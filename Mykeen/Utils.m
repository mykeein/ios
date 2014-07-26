//
//  Utils.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(void)forView:(UIView*)view addToX:(int)x addToY:(int)y{
    CGRect frame = view.frame;
    frame.origin.x += x;
    frame.origin.y += y;
    view.frame = frame;
}
+(void)forView:(UIView*)view setX:(int)x setY:(int)y{
    CGRect frame = view.frame;
    frame.origin.x = x;
    frame.origin.y = x;
    view.frame = frame;
}

+(NSString *)getPass{
   return [SSKeychain passwordForService:@"Mykeen" account:@"me"];
}
+(void)setPass:(NSString*)pass{
    [SSKeychain setPassword:pass forService:@"Mykeen" account:@"me"];
}

@end
