//
//  NSData+Crypto.m
//  test-encryption
//
//  Created by Ilia Kohanovski on 7/23/14.
//  Copyright (c) 2014 s. All rights reserved.
//

#import "NSData+Crypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation NSData (Crypto)

static const CCAlgorithm kAlgorithm = kCCAlgorithmAES128;
static const NSUInteger kAlgorithmKeySize = kCCKeySizeAES128;
static const NSUInteger kAlgorithmBlockSize = kCCBlockSizeAES128;
static const NSUInteger kAlgorithmIVSize = kCCBlockSizeAES128;
static const NSUInteger kPBKDFSaltSize = 8;
static const NSUInteger kPBKDFRounds = 1000;
static const NSString *ivHexString = @"F27D5C9927726BCEFE7510B1BDD3D137";
static const NSString *saltHexString = @"3FF2EC019C627B945225DEBAD71A01B6985FE84C95A70EB132882F88C0A59A55";


-(NSData*) operation:(CCOperation)operation withPass:(NSString*)pass error:(NSError**)error{
    NSData *iv = [NSData nsDataFromHexString:ivHexString];
    NSData *salt = [NSData nsDataFromHexString:saltHexString];
    NSData *key = [NSData AESKeyForPassword:pass salt:salt];
    size_t outLength;
    NSMutableData *
    cipherData = [NSMutableData dataWithLength:self.length +
                  kAlgorithmBlockSize];
    
    CCCryptorStatus
    result = CCCrypt(operation, // operation
                     kAlgorithm, // Algorithm
                     kCCOptionPKCS7Padding, // options
                     key.bytes, // key
                     key.length, // keylength
                     (iv).bytes,// iv
                     self.bytes, // dataIn
                     self.length, // dataInLength,
                     cipherData.mutableBytes, // dataOut
                     cipherData.length, // dataOutAvailable
                     &outLength); // dataOutMoved
    
    if (result == kCCSuccess) {
        cipherData.length = outLength;
    }
    else {
        if (error) {
            *error = [NSError errorWithDomain:@"cryptoerror"
                                         code:result
                                     userInfo:nil];
        }
        return nil;
    }
    return cipherData;
}
-(NSData*) encryptedDataWithPass:(NSString*)pass error:(NSError**)error{
    return [self operation:kCCEncrypt withPass:pass error:error];
}
-(NSData *)decryptedDataWithPass:(NSString *)pass error:(NSError **)error{
    return [self operation:kCCDecrypt withPass:pass error:error];
}

+(NSData*)nsDataFromHexString:(NSString*)hex{
    NSString *command = hex;
    
    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [command length]/2; i++) {
        byte_chars[0] = [command characterAtIndex:i*2];
        byte_chars[1] = [command characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    return commandToSend;
}

+ (NSData *)AESKeyForPassword:(NSString *)password
                         salt:(NSData *)salt {
    NSMutableData *
    derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    int
    result = CCKeyDerivationPBKDF(kCCPBKDF2,            // algorithm
                                  password.UTF8String,  // password
                                  [password lengthOfBytesUsingEncoding:NSUTF8StringEncoding],  // passwordLength
                                  salt.bytes,           // salt
                                  salt.length,          // saltLen
                                  kCCPRFHmacAlgSHA1,    // PRF
                                  kPBKDFRounds,         // rounds
                                  derivedKey.mutableBytes, // derivedKey
                                  derivedKey.length); // derivedKeyLen
    
    // Do not log password here
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for password: %d", result);
    
    return derivedKey;
}


@end
