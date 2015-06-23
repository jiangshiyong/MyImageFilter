//
//  SearchViewController.m
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "SearchViewController.h"
#import "FeSlideFilterView.h"
#import "CIFilter+LUT.h"

@interface SearchViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,FeSlideFilterViewDataSource, FeSlideFilterViewDelegate>
@property (strong, nonatomic) FeSlideFilterView *slideFilterView;
@property (strong, nonatomic) NSMutableArray *arrPhoto;
@property (strong, nonatomic) NSArray *arrTittleFilter;
@property (strong, nonatomic) UIImage *photoImage;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    
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

#pragma mark - Init
- (void)initPhotoFilter {
    
    _arrPhoto = [NSMutableArray arrayWithCapacity:5];
    
    for (NSInteger i = 0; i < 5; i++)
    {
        if (i == 4)
        {
            UIImage *image = [self imageDependOnDevice];
            [_arrPhoto addObject:image];
        }
        else
        {
            NSString *nameLUT = [NSString stringWithFormat:@"filter_lut_%d",i + 1];
            
            //////////
            // FIlter with LUT
            // Load photo
            UIImage *photo = [self imageDependOnDevice];
            
            // Create filter
            CIFilter *lutFilter = [CIFilter filterWithLUT:nameLUT dimension:64];
            
            // Set parameter
            CIImage *ciImage = [[CIImage alloc] initWithImage:photo];
            [lutFilter setValue:ciImage forKey:@"inputImage"];
            CIImage *outputImage = [lutFilter outputImage];
            
            CIContext *context = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:(__bridge id)(CGColorSpaceCreateDeviceRGB()) forKey:kCIContextWorkingColorSpace]];
            
            UIImage *newImage = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
            
            [_arrPhoto addObject:newImage];
        }
    }
}

- (void)initTitle {
    
    _arrTittleFilter = @[@"Los Angeles",@"Paris",@"London",@"Rio",@"Original"];
}

-(void)initFeSlideFilterView {
    
    CGRect frame;
//    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        if (isiPhone5)
//            frame = CGRectMake(0, 0, 568, 320);
//        else
//            frame = CGRectMake(0, 0, 480, 320);
//    }
//    else
//    {
//        frame = CGRectMake(0, 0, 1024, 768);
//    }
    frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44-49);
    
    _slideFilterView = [[FeSlideFilterView alloc] initWithFrame:frame];
    _slideFilterView.dataSource = self;
    _slideFilterView.delegate = self;
    
    [self.view addSubview:_slideFilterView];
    
    // Btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    
    _slideFilterView.doneBtn = btn;
}

#pragma mark - Delegate / Data Source
-(NSInteger) numberOfFilter
{
    return 5;
}

-(NSString *) FeSlideFilterView:(FeSlideFilterView *)sender titleFilterAtIndex:(NSInteger)index
{
    return _arrTittleFilter[index];
}

-(UIImage *) FeSlideFilterView:(FeSlideFilterView *)sender imageFilterAtIndex:(NSInteger)index
{
    return _arrPhoto[index];
}

-(void)FeSlideFilterView:(FeSlideFilterView *)sender didTapDoneButtonAtIndex:(NSInteger)index
{
    NSLog(@"did tap at index = %ld",(long)index);
}

-(NSString *)kCAContentGravityForLayer
{
    return kCAGravityResizeAspectFill;
}

#pragma mark - Private
-(UIImage *) imageDependOnDevice
{
    UIImage *imageOriginal;
    
    imageOriginal = self.photoImage;
    
//    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        imageOriginal = [UIImage imageNamed:@"sample.jpg"];
//    }
//    else
//    {
//        imageOriginal = [UIImage imageNamed:@"sample_iPad.jpg"];
//    }
    return imageOriginal;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.photoImage = image;
        
        [self initPhotoFilter];
        
        [self initTitle];
        
        [self initFeSlideFilterView];
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
        self.photoImage = image;
        
        [self initPhotoFilter];
        
        [self initTitle];
        
        [self initFeSlideFilterView];
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
