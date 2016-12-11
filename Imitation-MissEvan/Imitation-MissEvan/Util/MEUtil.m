//
//  MEUtil.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/28.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEUtil.h"
#import "MEHeader.h"

@implementation MEUtil

+ (UIButton *)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft isRight:(BOOL)isRight
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isRight == YES) {
        button.frame = CGRectMake(ME_Width - 40, -3, 40, 40);
    } else if (isLeft == YES) {
        button.frame = CGRectMake(0, -3, 40, 40);
    }
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    return [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

+ (UIBarButtonItem *)barButtonWithTarget:(id)target action:(SEL)selector withImage:(UIImage *)image
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 30, 30);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 4)];
    [button setImage:image forState:UIControlStateNormal];
    //    [button setTitle:@"返回" forState:UIControlStateNormal];
    //    button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return barButtonItem;
}

+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level
{
    //获取BitmapData
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = orginImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  kBitsPerComponent,        //每个颜色值8bit
                                                  width*kPixelChannelCount, //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit
                                                  colorSpace,
                                                  kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    unsigned char * bitmapData = CGBitmapContextGetData (context);
    //这里把BitmapData进行马赛克转换,就是用一个点的颜色填充一个level*level的正方形
    unsigned char pixel[kPixelChannelCount] = {0};
    NSUInteger index,preIndex;
    for (NSUInteger i = 0; i < height - 1 ; i++) {
        for (NSUInteger j = 0; j < width - 1; j++) {
            index = i * width + j;
            if (i % level == 0) {
                if (j % level == 0) {
                    memcpy(pixel, bitmapData + kPixelChannelCount*index, kPixelChannelCount);
                }else{
                    memcpy(bitmapData + kPixelChannelCount*index, pixel, kPixelChannelCount);
                }
            } else {
                preIndex = (i-1) * width +j;
                memcpy(bitmapData + kPixelChannelCount*index, bitmapData + kPixelChannelCount*preIndex, kPixelChannelCount);
            }
        }
    }
    
    NSInteger dataLength = width*height* kPixelChannelCount;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, dataLength, NULL);
    //创建要输出的图像
    CGImageRef mosaicImageRef = CGImageCreate(width, height,
                                              kBitsPerComponent,
                                              kBitsPerPixel,
                                              width * kPixelChannelCount ,
                                              colorSpace,
                                              (CGBitmapInfo)kCGImageAlphaPremultipliedLast,//iOS7以上需要转换CGBitmapInfo
                                              provider,
                                              NULL, NO,
                                              kCGRenderingIntentDefault);
    CGContextRef outputContext = CGBitmapContextCreate(nil,
                                                       width,
                                                       height,
                                                       kBitsPerComponent,
                                                       width * kPixelChannelCount,
                                                       colorSpace,
                                                       (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(outputContext, CGRectMake(0.0f, 0.0f, width, height), mosaicImageRef);
    CGImageRef resultImageRef = CGBitmapContextCreateImage(outputContext);
    UIImage *resultImage = nil;
    if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
        float scale = [[UIScreen mainScreen] scale];
        resultImage = [UIImage imageWithCGImage:resultImageRef scale:scale orientation:UIImageOrientationUp];
    } else {
        resultImage = [UIImage imageWithCGImage:resultImageRef];
    }
    //释放
    if(resultImageRef){
        CFRelease(resultImageRef);
    }
    if(mosaicImageRef){
        CFRelease(mosaicImageRef);
    }
    if(colorSpace){
        CGColorSpaceRelease(colorSpace);
    }
    if(provider){
        CGDataProviderRelease(provider);
    }
    if(context){
        CGContextRelease(context);
    }
    if(outputContext){
        CGContextRelease(outputContext);
    }
    return resultImage;
}

@end
