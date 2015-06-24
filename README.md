# MyImageFilter
	图片滤镜效果的实现方式：

	一种方式是使用系统自带的CIFilter类，实现滤镜效果。
	另一种方式是依靠美工，利用Color Lookup Table(ColorLUT)的技术，即需要一张cube映射表，这样表就是张颜色表。


第一种方式：

CIFilter分14个大类：共有127种效果

```
	kCICategoryDistortionEffect;扭曲效果，比如bump、旋转、hole
	kCICategoryGeometryAdjustment;几何开着调整，比如仿射变换、平切、透视转换
	kCICategoryCompositeOperation;合并，比如源覆盖（source over）、最小化、源在顶（source atop）、色彩混合模式
	kCICategoryHalftoneEffect;Halftone效果，比如screen、line screen、hatched
	kCICategoryColorAdjustment;色彩调整，比如伽马调整、白点调整、曝光
	kCICategoryColorEffect;色彩效果，比如色调调整、posterize
	kCICategoryTransition;图像间转换，比如dissolve、disintegrate with mask、swipe
	kCICategoryTileEffect;瓦片效果，比如parallelogram、triangle
	kCICategoryGenerator;图像生成器，比如stripes、constant color、checkerboard
	kCICategoryReduction __OSX_AVAILABLE_STARTING(__MAC_10_5, 		__IPHONE_5_0);
	kCICategoryGradient;渐变，比如轴向渐变、仿射渐变、高斯渐变
	kCICategoryStylize;风格化，比如像素化、水晶化
	kCICategorySharpen;锐化、发光
	kCICategoryBlur;模糊，比如高斯模糊、焦点模糊、运动模糊

```

经常使用的是kCICategoryColorEffect类别里面的27个效果：

A filter that modifies the color of an image to achieve an artistic effect. Examples of color effect filters include filters that change a color image to a sepia image or a monochrome image or that produces such effects as posterizing.
(一个过滤器，修改图像的颜色达到一种艺术效果。彩色滤镜效果的例子包括过滤器，改变彩色图像到一个褐色的图像或单色图像或产生这些效果是色调分离。)

```

    CIColorClamp,
    CIColorCrossPolynomial,
    CIColorCube,
    CIColorCubeWithColorSpace,
    CIColorInvert,
    CIColorMap,
    CIColorMonochrome,
    CIColorPolynomial,
    CIColorPosterize,
    CIFalseColor,
    CIMaskToAlpha,
    CIMaximumComponent,
    CIMinimumComponent,
    CIPhotoEffectChrome,
    CIPhotoEffectFade,
    CIPhotoEffectInstant,
    CIPhotoEffectMono,
    CIPhotoEffectNoir,
    CIPhotoEffectProcess,
    CIPhotoEffectTonal,
    CIPhotoEffectTransfer,
    CISepiaTone,
    CIVignette,
    CIVignetteEffect
```
其中大部分颜色对应为：

```

CIPhotoEffectInstant :怀旧
CIPhotoEffectNoir :黑白
CIPhotoEffectTonal:色调
CIPhotoEffectTransfer:岁月
CIPhotoEffectMono:单色
CIPhotoEffectFade:褪色
CIPhotoEffectProcess:冲印
CIPhotoEffectChrome:铬黄

```



第二种方式:

在同一张图片上覆盖一层滤镜。利用Color Lookup Table(ColorLUT)的技术，即需要一张cube映射表，这样表就是张颜色表，需要美工提供几张颜色表。


```

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

```










# MyRecordingVideo
	视频录制的实现方式：

	一种方式是使用系统自带的UIImagePickerController类，调用系统自带的录制效果。
	另一种方式是依靠AVFoundation类库里面的视频输出类AVCaptureVideoPreviewLayer,比较第一种方式有扩展性。












参考资料：

http://huangtw-blog.logdown.com/posts/176980-ios-quickly-made-using-a-cicolorcube-filter

http://blog.csdn.net/zhangao0086/article/details/39120331





