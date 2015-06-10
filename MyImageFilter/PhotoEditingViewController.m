//
//  PhotoEditingViewController.m
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "PhotoEditingViewController.h"
#import "AppDelegate.h"

@interface PhotoEditingViewController ()<CustomFilterButtonViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *myPhotoImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *filterScrollView;

@property (strong, nonatomic) NSArray *filters;

@property (strong, nonatomic) NSArray *filteredImages;
@property (strong, nonatomic) CIImage *inputImage;
@end

@implementation PhotoEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _filters = @[@"CIPhotoEffectChrome", @"CIPhotoEffectFade", @"CIPhotoEffectInstant",
                 @"CIPhotoEffectMono", @"CIPhotoEffectNoir", @"CIPhotoEffectProcess",
                 @"CIPhotoEffectTonal", @"CIPhotoEffectTransfer"];
    _inputImage = [CIImage imageWithCGImage:[self.photoImage CGImage]];
    _filteredImages = [self preFilterImages];
    [self initContentView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setTabBarHidden:YES withAnimation:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [appDelegate setTabBarHidden:NO withAnimation:YES];
}

- (void)initContentView {
    
    self.myPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.myPhotoImageView.image = self.photoImage;
    
    __weak PhotoEditingViewController *weakSelf = self;
    //延后执行某个方法
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakSelf layoutScorllViewSubViews];
    });
}

#pragma mark - Utility Methods
- (NSArray *)preFilterImages
{
    NSMutableArray *images = [NSMutableArray new];
    for(NSString *filterName in _filters) {
        // Filter the image
        CIFilter *filter = [CIFilter filterWithName:filterName];
        [filter setValue:_inputImage forKey:kCIInputImageKey];
        // Create a CG-back UIImage
        CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:filter.outputImage fromRect:filter.outputImage.extent];
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        CGImageRelease(cgImage);
        
        [images addObject:image];
    }
    
    return [images copy];
}


- (void)layoutScorllViewSubViews {

    
    for (CustomFilterButtonView *customView in self.filterScrollView.subviews) {
        
        [customView removeFromSuperview];
    }
    if ([_filteredImages count]>1) {
        
        
        self.filterScrollView.contentSize = CGSizeMake(100*([_filteredImages count]+1), self.filterScrollView.frame.size.height);
        
        for (int i=0; i<[_filteredImages count]; i++) {
            
            UIImage *image = _filteredImages[i];
            NSString *text = _filters[i];
            
            CustomFilterButtonView *customView = [[CustomFilterButtonView alloc]initWithFrame:CGRectMake(i*(100.0f+10), 0, 100, 120) withImage:image withType:text];
            customView.delegate = self;
            [self.filterScrollView addSubview:customView];
        }
    }
}

- (void)customFilterButtonView:(CustomFilterButtonView *)customFilterButtonView didSelectFilterImage:(UIImage *)filterImage {

    self.myPhotoImageView.image = filterImage;

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