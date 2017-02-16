

//
//  NSString+Security.m
//  des
//
//  Created by ls on 16/1/13.
//
//

#import "LSGTMBase64.h"
#include <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+ASE128.h"

@implementation NSString (Security)

-(NSString *) aes256_encrypt:(NSString *)key
{
    NSData *originData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryData = [originData AES128EncryptWithKey:key];
    NSString* result = [self hexStringFromData:encryData];
    return result;
}

-(NSString *) aes256_decrypt:(NSString *)key
{
    // 开始解密
   NSData *encryData = [self stringToHexData:self];
    NSData *decryData = [encryData AES128DecryptWithKey:key];
    NSString *decryStr = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];

    return decryStr;
}
- (NSData *) stringToHexData:(NSString*)hexStr
{
    NSInteger len = [hexStr length] / 2;    // Target length
    unsigned char *buf = malloc(len);
    unsigned char *whole_byte = buf;
    char byte_chars[3] = {'\0','\0','\0'};
    
    int i;
    for (i=0; i < [hexStr length] / 2; i++) {
        byte_chars[0] = [hexStr characterAtIndex:i*2];
        byte_chars[1] = [hexStr characterAtIndex:i*2+1];
        *whole_byte = strtol(byte_chars, NULL, 16);
        whole_byte++;
    }
    
    NSData *data = [NSData dataWithBytes:buf length:len];
    free( buf );
    return data;
}


- (NSString *)hexStringFromData:(NSData*)data{
    return [[[[[NSString stringWithFormat:@"%@",data]
               stringByReplacingOccurrencesOfString: @"<" withString: @""]
              stringByReplacingOccurrencesOfString: @">" withString: @""]
             stringByReplacingOccurrencesOfString: @" " withString: @""]uppercaseString];
}

#pragma mark - string-->base64
-(NSString*)base64StringWithString:(NSString*)text
{
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
#pragma mark - base64-->string
- (NSString*)stringWithBase64String:(NSString*)text
{
    NSData* data = [[NSData alloc] initWithBase64EncodedString:text options:0];
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}
#pragma mark - DES解密
- (NSString*)decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [LSGTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;

    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
        kCCAlgorithmDES,
        kCCOptionPKCS7Padding | kCCOptionECBMode,
        [key UTF8String],
        kCCKeySizeDES,
        nil,
        [cipherData bytes],
        [cipherData length],
        buffer,
        1024,
        &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
#pragma mark - DES加密
- (NSString*)encryptUseDES:(NSString*)clearText key:(NSString*)key
{
    NSData* data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
        kCCAlgorithmDES,
        kCCOptionPKCS7Padding | kCCOptionECBMode,
        [key UTF8String],
        kCCKeySizeDES,
        nil,
        [data bytes],
        [data length],
        buffer,
        1024,
        &numBytesEncrypted);

    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [LSGTMBase64 stringByEncodingData:dataTemp];
    }
    else {
        NSLog(@"DES加密失败");
    }
    return plainText;
}
- (NSString*)md5String
{
    const char* string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString*)sha1String
{
    const char* string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString*)sha256String
{
    const char* string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString*)sha512String
{
    const char* string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString*)hmacSHA1StringWithKey:(NSString*)key
{
    NSData* keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData* messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char*)mutableData.bytes length:mutableData.length];
}

- (NSString*)hmacSHA256StringWithKey:(NSString*)key
{
    NSData* keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData* messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* mutableData = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char*)mutableData.bytes length:mutableData.length];
}

- (NSString*)hmacSHA512StringWithKey:(NSString*)key
{
    NSData* keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData* messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* mutableData = [NSMutableData dataWithLength:CC_SHA512_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA512, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [self stringFromBytes:(unsigned char*)mutableData.bytes length:mutableData.length];
}

#pragma mark - Helpers

- (NSString*)stringFromBytes:(unsigned char*)bytes length:(int)length
{
    NSMutableString* mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

@end
