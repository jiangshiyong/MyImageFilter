//
//  HomeViewController.m
//  MyImageFilter
//
//  Created by jiang on 15/6/8.
//  Copyright (c) 2015年 jiangshiyong. All rights reserved.
//

#import "HomeViewController.h"
#import "PhotoEditingViewController.h"
#import "PhotoCollectionViewCell.h"
#include <AssetsLibrary/AssetsLibrary.h>

@interface HomeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *photosCollectionView;//图片列表
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (strong, nonatomic) NSMutableArray *photosArray;//

@property (strong, nonatomic) ALAssetsLibrary *library;

@property (strong, nonatomic) NSArray *imageArray;

@property (strong, nonatomic) NSMutableArray *mutableArray;
@end

@implementation HomeViewController
static int count=0;

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
    
    self.photosArray = [[NSMutableArray alloc]init];

    
    int itemWidth = (self.view.bounds.size.width-5)/3-5;
    [_layout setItemSize:CGSizeMake(itemWidth, itemWidth)];
    _layout.minimumInteritemSpacing = 2.0f;
    [_layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_layout setMinimumInteritemSpacing:0.5];
    [_layout setMinimumLineSpacing:5];
    
    self.photosCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.photosCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCollectionViewCell class]) bundle:nil]forCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class])];
    self.photosCollectionView.delegate= self;
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.scrollEnabled = YES;
    [self.photosCollectionView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getAllPictures];
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

-(void)getAllPictures {
    
    _imageArray=[[NSArray alloc] init];
    
    _mutableArray =[[NSMutableArray alloc]init];
    
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    _library = [[ALAssetsLibrary alloc] init];
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if(result != nil) {
            
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                [_library assetForURL:url
                 
                          resultBlock:^(ALAsset *asset) {
                              
                              [_mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                              
                              if ([_mutableArray count]==count)
                                  
                              {
                                  
                                  _imageArray=[[NSArray alloc] initWithArray:_mutableArray];
                                  
                                  [self allPhotosCollected:_imageArray];
                                  
                              }
                          }
                 
                         failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
            }
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        
        if(group != nil) {
            
            [group enumerateAssetsUsingBlock:assetEnumerator];
            
            [assetGroups addObject:group];
            
            count=[group numberOfAssets];
            
        }
        
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [_library enumerateGroupsWithTypes:ALAssetsGroupAll
     
                            usingBlock:assetGroupEnumerator
     
                          failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}



- (void)allPhotosCollected:(NSArray*)imgArray {
    
    //write your code here after getting all the photos from library...
    
    NSLog(@"all pictures are %@",imgArray);
    [self.photosArray removeAllObjects];
    [self.photosArray addObjectsFromArray:imgArray];
    [self.photosCollectionView reloadData];
}

#pragma mark
#pragma mark - UICollectionView Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (collectionView==self.photosCollectionView) {
        return 1;
        //        if ([self.hotSearchKeyArray count]%3==0) {
        //
        //            return  [self.hotSearchKeyArray count]/3;
        //        }else{
        //            return  [self.hotSearchKeyArray count]/3+1;
        //        }
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView==self.photosCollectionView) {
        
        return [self.photosArray count]+1;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView==self.photosCollectionView) {
        
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoCollectionViewCell class])
                                                                                         forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:245.0f/255 green:245.0f/255 blue:245.0f/255 alpha:1];
        UIView *tempBgView = [[UIView alloc] initWithFrame:cell.frame];
        tempBgView.backgroundColor = [UIColor colorWithRed:235.0f/255 green:235.0f/255 blue:235.0f/255 alpha:1];
        cell.selectedBackgroundView = tempBgView;

        if (indexPath.row>0) {
            
            cell.imageView.image = (UIImage *)self.photosArray[indexPath.row-1];
        }else{
        
            cell.imageView.image = [UIImage imageNamed:@"icon_facial_btn_take.png"];
        }
        return cell;
        
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    if ([collectionView isEqual:self.hotSearchKeyCollectionView]) {
    //        HotSearchKeyCollectionViewCell *cell = (HotSearchKeyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //        [cell setBackgroundColor:UIColorWithHex(0xebebeb)];
    //    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        
        if (indexPath.row<[self.photosArray count]) {
            
            if (indexPath.row==0) {
                
                [self cameraButtonClicked];
            }else{
                
                PhotoEditingViewController *viewController = [[PhotoEditingViewController alloc]init];
                viewController.photoImage = self.photosArray[indexPath.row-1];
                [self.navigationController pushViewController:viewController animated:YES];
            }
        }
    }
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

//拍照功能
- (void)cameraButtonClicked{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType= UIImagePickerControllerSourceTypeCamera;
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
