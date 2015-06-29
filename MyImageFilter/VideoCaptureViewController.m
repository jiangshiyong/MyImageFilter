//
//  VideoCaptureViewController.m
//  MyImageFilter
//
//  Created by jiang on 15/6/29.
//  Copyright © 2015年 jiangshiyong. All rights reserved.
//

#import "VideoCaptureViewController.h"
#import "IDImagePickerCoordinator.h"
#import "IDCaptureSessionPipelineViewController.h"

@interface VideoCaptureViewController ()

@property (nonatomic, strong) IDImagePickerCoordinator *imagePickerCoordinator;
@end

@implementation VideoCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            self.imagePickerCoordinator = [IDImagePickerCoordinator new];
            [self presentViewController:[_imagePickerCoordinator cameraVC] animated:YES completion:nil];
            break;
        case 1:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            IDCaptureSessionPipelineViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"captureSessionVC"];
            [viewController setupWithPipelineMode:PipelineModeMovieFileOutput];
            [self presentViewController:viewController animated:YES completion:nil];
            break;
        }
        case 2:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            IDCaptureSessionPipelineViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"captureSessionVC"];
            [viewController setupWithPipelineMode:PipelineModeAssetWriter];
            [self presentViewController:viewController animated:YES completion:nil];
            break;
        }
        default:
            break;
    }
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
