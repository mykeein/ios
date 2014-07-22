//
//  NSData+Crypto.h
//  test-encryption
//
//  Created by Ilia Kohanovski on 7/23/14.
//  Copyright (c) 2014 s. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Crypto)

-(NSData*) encryptedDataWithPass:(NSString*)pass error:(NSError**)error;

-(NSData*) decryptedDataWithPass:(NSString*)pass error:(NSError**)error;

@end
