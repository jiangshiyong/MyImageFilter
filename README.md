# MyImageFilter
	图片滤镜效果的实现方式：

	一种是使用系统自带的CIFilter类，实现滤镜效果。
	另一种是用美工制作的



1. CIFilter分14个大类：共有127种效果

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





























