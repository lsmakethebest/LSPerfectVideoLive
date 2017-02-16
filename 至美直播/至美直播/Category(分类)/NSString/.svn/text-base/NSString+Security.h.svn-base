//
//  NSString+Security.h
//  des
//
//  Created by ls on 16/1/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Security)

@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1String;
@property (readonly) NSString *sha256String;
@property (readonly) NSString *sha512String;

// string--->base64

-(NSString*)base64StringWithString:(NSString*)text;

// base64-string

-(NSString*)stringWithBase64String:(NSString*)text;

// DES加密

-(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;

// DES解密


-(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;
@end
