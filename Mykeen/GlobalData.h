//
//  GlobalData.h
//  Mykeen
//
//  Created by Ilia Kohanovski on 7/26/14.
//  Copyright (c) 2014 Mykeen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

+ (GlobalData *)sharedData;

@property NSString* pass;

@end
