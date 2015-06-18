//
//  CIFilter+Image.h
//  MyImageFilter
//
//  Created by jiang on 15/6/17.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@class CIFilter;

@interface CIFilter (Image)

+(CIFilter *)filterWithImageName:(NSString *)name dimension:(NSInteger)n;

@end
