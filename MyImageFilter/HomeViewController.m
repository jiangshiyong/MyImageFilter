//
//  HomeViewController.m
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "HomeViewController.h"
#import "PhotoEditingViewController.h"
@interface HomeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    UIView *rightMenuBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 65, 44)];
    rightMenuBgView.backgroundColor = [UIColor clearColor];
    
    UIButton *rightMenuButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightMenuButton.frame = CGRectMake(15, (rightMenuBgView.frame.size.height-44)/2, rightMenuBgView.frame.size.width, 44);
    rightMenuButton.backgroundColor = [UIColor clearColor];
    rightMenuButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rightMenuButton setTitle:@"相册" forState:UIControlStateNormal];
    [rightMenuButton setTitle:@"相册" forState:UIControlStateHighlighted];
    [rightMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [rightMenuButton addTarget:self action:@selector(rightMenuButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [rightMenuBgView addSubview:rightMenuButton];
    
    UIBarButtonItem *rightmenuBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightMenuBgView];
    self.navigationItem.rightBarButtonItem = rightmenuBarItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

//相册功能区
- (void)rightMenuButtonClicked {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
        
    }else{
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
}

- (IBAction)cameraButtonClicked:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType= UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
        
    }else{
    
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType= UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {

    [picker dismissViewControllerAnimated:YES completion:^{
        
        PhotoEditingViewController *viewController = [[PhotoEditingViewController alloc]init];
        viewController.photoImage = image;
        [picker.navigationController pushViewController:viewController animated:YES];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSLog(@"info====%@",info);
    /*
     
     {
     UIImagePickerControllerCropRect = "NSRect: {{0, 0}, {1008, 669}}";
     UIImagePickerControllerEditedImage = "<UIImage: 0x7fcd537617e0> size {748, 496} orientation 0 scale 1.000000";
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x7fcd53761b40> size {1008, 669} orientation 0 scale 1.000000";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=5AC34474-8097-4E86-BCAF-73CFB908C1A2&ext=JPG";
     }
     */
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        PhotoEditingViewController *viewController = [[PhotoEditingViewController alloc]init];
        viewController.photoImage = image;
        [self.navigationController pushViewController:viewController animated:YES];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [self dismissViewControllerAnimated:YES completion:^{}];
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
