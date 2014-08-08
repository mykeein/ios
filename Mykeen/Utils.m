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
+(void)setApproved:(BOOL)approved{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:approved forKey:@"approved"];
}

+(BOOL)getApproved{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:@"approved"];
}

+(NSString *)getEmail{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * email = [userDefaults objectForKey:@"email"];
    return email;
}
+(void)setEmail:(NSString *)email{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:email forKey:@"email"];
}

+ (NSString *)uuid
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * uuidString = [userDefaults objectForKey:@"uuid"];
    if (uuidString)
        return uuidString;
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
        CFRelease(uuid);
    }
    [userDefaults setObject:uuidString forKey:@"uuid"];
    return uuidString;
}

@end
