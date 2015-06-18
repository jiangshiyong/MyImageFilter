//
//  UIImage+Mark.h
//  MyImageFilter
//
//  Created by jiang on 15/6/18.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//  水印标记

#import <UIKit/UIKit.h>

@interface UIImage (Mark)

/**
	加半透明水印
	@param useImage 需要加水印的图片
	@param maskImage 水印
	@return 加好水印的图片
 */
- (UIImage *)addUseImage:(UIImage *)useImage addWaterMarkImage:(UIImage *)maskImage withMarkRect:(CGRect)markRect;


/**
	加水印
	@param useImage 需要加水印的图片
	@param maskImage 水印
	@return 加好水印的图片
 */
- (UIImage *)addUseImage:(UIImage *)useImage addMarkImage:(UIImage *)maskImage withMarkRect:(CGRect)markRect;



/**
    加文字
*/
- (UIImage *)addUseImage:(UIImage *)useImage addMarkText:(NSString *)markText withMarkRect:(CGRect)markRect;

@end
