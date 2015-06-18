//
//  UIImage+Mark.m
//  MyImageFilter
//
//  Created by jiang on 15/6/18.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "UIImage+Mark.h"

@implementation UIImage (Mark)

/**
	加半透明水印
	@param useImage 需要加水印的图片
	@param maskImage 水印
	@return 加好水印的图片
 */
- (UIImage *)addUseImage:(UIImage *)useImage addWaterMarkImage:(UIImage *)maskImage withMarkRect:(CGRect)markRect {
    
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    //标记水印图片的位置
    [maskImage drawInRect:markRect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

/**
	加水印
	@param useImage 需要加水印的图片
	@param maskImage 水印
	@return 加好水印的图片
 */
- (UIImage *)addUseImage:(UIImage *)useImage addMarkImage:(UIImage *)maskImage withMarkRect:(CGRect)markRect{

    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    //标记水印图片的位置
    [maskImage drawInRect:markRect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

/**
 加文字
 */
- (UIImage *)addUseImage:(UIImage *)useImage addMarkText:(NSString *)markText withMarkRect:(CGRect)markRect {

//    //上下文的大小
//    int w = useImage.size.width;
//    int h = useImage.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
//    //创建上下文
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), useImage.CGImage);//将img绘至context上下文中
//    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
//    char* text = (char *)[markText cStringUsingEncoding:NSASCIIStringEncoding];
//    CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);//设置字体的大小
//    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
//    CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
//    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));//设置字体绘制的位置
//    //CGContextShowText(context, text, strlen(text));
//    
//    //Create image ref from the context
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
    
    return [self CSImage:useImage AddText:markText];
}

-(UIImage *)CSImage:(UIImage *)img AddText:(NSString *)text
{
    
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    view.image = img;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSString *s = text;
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    
    CGSize size = CGSizeMake(320,2000);
    CGSize labelSize = [s boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:NULL].size;
    label.frame = CGRectMake(0,0, labelSize.width, labelSize.height);
    
    [view addSubview:label];
    
    return [self convertViewToImage:view];
}

-(UIImage*)convertViewToImage:(UIView*)v
{
    CGSize s = v.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [v.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    v.layer.contents = nil;
    return image;
    
}


@end
