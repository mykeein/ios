//
//  GlobalData.m
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/26/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

+ (GlobalData *)sharedData{
    static GlobalData * sharedData = nil;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate,^
                  {
                      sharedData = [[self alloc] init];
                  });
    
    return sharedData;
}

@end
