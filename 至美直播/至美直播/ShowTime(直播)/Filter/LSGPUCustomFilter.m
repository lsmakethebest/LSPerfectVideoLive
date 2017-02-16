





//
//  LSGPUCustomFilter.m
//  至美直播
//
//  Created by 刘松 on 16/8/24.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSGPUCustomFilter.h"

NSString *const kGPUImageInvertFragmentShaderString1 = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     lowp vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     
     gl_FragColor = vec4((1.0 - textureColor.rgb), textureColor.a);
 }
 );
@implementation LSGPUCustomFilter

- (id)init
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageInvertFragmentShaderString1]))
    {
        return nil;
    }
    
    return self;
}
@end
