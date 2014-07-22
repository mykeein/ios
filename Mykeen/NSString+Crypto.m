//
//  NSString+Crypto.m
//  test-encryption
//
//  Created by Ilia Kohanovski on 7/23/14.
//  Copyright (c) 2014 s. All rights reserved.
//

#import "NSString+Crypto.h"
#import "NSData+Crypto.m"

@implementation NSString (Crypto)

static const NSStringEncoding Encoding = NSUTF8StringEncoding;

-(NSString *)encryptedStringWithPass:(NSString *)pass error:(NSError **)error{
    NSData *toencrypt = [self dataUsingEncoding:Encoding];
    NSData *encrypted = [toencrypt encryptedDataWithPass:pass error:nil];
    NSString *res = [encrypted base64EncodedStringWithOptions:0];
    return res;
}
-(NSString *)decryptedStringWithPass:(NSString *)pass error:(NSError **)error{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData * decrypted = [decodedData decryptedDataWithPass:pass error:nil];
    NSString *res = [[NSString alloc] initWithData:decrypted encoding:Encoding];
    return res;
}


@end
