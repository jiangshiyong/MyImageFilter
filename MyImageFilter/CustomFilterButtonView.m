//
//  CustomFilterButtonView.m
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "CustomFilterButtonView.h"

@implementation CustomFilterButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withImage:(UIImage *)filterImage withType:(NSString *)type {

    self = [super initWithFrame:frame];
    self.frame = frame;
    if (self) {
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-25)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.image = filterImage;
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-25, self.frame.size.width, 20)];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.text = type;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.titleLabel];
        
        self.choiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.choiceButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.choiceButton.backgroundColor = [UIColor clearColor];
        [self.choiceButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.choiceButton];
        
    }
    
    return self;
}

- (void)buttonAction:(UIButton *)bt {

    if ([self.delegate respondsToSelector:@selector(customFilterButtonView:didSelectFilterImage:)]) {
        [self.delegate customFilterButtonView:self didSelectFilterImage:self.imageView.image];
    }

}

@end
