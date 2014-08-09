//
//  Utils.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static NSDateFormatter * rfc3339DateFormatter;
+(void)initialize{
    rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    [rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
    [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
}
// Modified version of an Apple Docs example that accomodates for the extra milliseconds used in NodeJS/JS dates
// https://developer.apple.com/library/ios/#documentation/Cocoa/Conceptual/DataFormatting/Articles/dfDateFormatting10_4.html#//apple_ref/doc/uid/TP40002369-SW1
+ (NSDate *)dateForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString {
    
	// Convert the RFC 3339 date time string to an NSDate.
	NSDate *result = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
	return result;
}

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
