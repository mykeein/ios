//
//  NSString+Crypto.h
//  test-encryption
//
//  Created by Ilia Kohanovski on 7/23/14.
//  Copyright (c) 2014 s. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (Crypto)

-(NSString *)decryptedStringWithPass:(NSString *)pass error:(NSError **)error;
-(NSString *)encryptedStringWithPass:(NSString *)pass error:(NSError **)error;

@end
