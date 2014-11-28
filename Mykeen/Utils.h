//
//  Utils.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 6/27/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(void)forView:(UIView*)view addToX:(int)x addToY:(int)y;
+(void)forView:(UIView*)view setX:(int)x setY:(int)y;

+(BOOL)getApproved;
+(void)setApproved:(BOOL)approved;

+(NSString*)getEmail;
+(void)setEmail:(NSString*)email;

+(NSString*)getPass;
+(void)setPass:(NSString*)pass;

+(NSString *)uuid;
+(void)setUUID:(NSString*)uuid;

+ (NSDate *)dateForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString;


@end
