//
//  CustomFilterButtonView.h
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomFilterButtonView;

@protocol CustomFilterButtonViewDelegate <NSObject>

@optional

- (void)customFilterButtonView:(CustomFilterButtonView *)customFilterButtonView didSelectFilterImage:(UIImage *)filterImage;

@end

@interface CustomFilterButtonView : UIView

@property (nonatomic, unsafe_unretained)id<CustomFilterButtonViewDelegate> delegate;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *choiceButton;

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)filterImage withType:(NSString *)type;
    
@end
