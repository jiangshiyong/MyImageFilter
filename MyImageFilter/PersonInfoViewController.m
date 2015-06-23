//
//  PersonInfoViewController.m
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "CameraRecordViewController.h"
#import "RecorderViewController.h"

@interface PersonInfoViewController ()

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人";
    
    UIView *rightMenuBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 65, 44)];
    rightMenuBgView.backgroundColor = [UIColor clearColor];
    
    UIButton *rightMenuButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightMenuButton.frame = CGRectMake(15, (rightMenuBgView.frame.size.height-44)/2, rightMenuBgView.frame.size.width, 44);
    rightMenuButton.backgroundColor = [UIColor clearColor];
    rightMenuButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rightMenuButton setTitle:@"录像" forState:UIControlStateNormal];
    [rightMenuButton setTitle:@"录像" forState:UIControlStateHighlighted];
    [rightMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [rightMenuButton addTarget:self action:@selector(rightMenuButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightMenuBgView addSubview:rightMenuButton];
    
    UIBarButtonItem *rightmenuBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightMenuBgView];
    self.navigationItem.rightBarButtonItem = rightmenuBarItem;
}

//录像
- (void)rightMenuButtonClicked {
    
    //CameraRecordViewController *controller = [[CameraRecordViewController alloc]init];
    //[self.navigationController pushViewController:controller animated:YES];
    
    RecorderViewController *controller = [[RecorderViewController alloc]init];
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
