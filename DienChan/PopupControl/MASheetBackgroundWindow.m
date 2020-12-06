//
//  MASheetBackgroundWindow.m
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import "MASheetBackgroundWindow.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Additional.h"

CGFloat const MASheetControllerDefaultBackgroundOpacity = 0.5;
CGFloat const MASheetControllerDefaultBackgroundBlurRadius = 2.0;
CGFloat const MASheetControllerDefaultBackgroundBlurSaturation = 1.0;

UIWindowLevel const UIWindowLevelFormSheetBackground = 2;

extern CGFloat MASheetControllerWindowTag;

static CGFloat const UIInterfaceOrientationAngleOfOrientation(UIInterfaceOrientation orientation)
{
    switch (orientation)
    {
        case UIInterfaceOrientationPortraitUpsideDown: return M_PI;
        case UIInterfaceOrientationLandscapeLeft: return -M_PI_2;
        case UIInterfaceOrientationLandscapeRight: return M_PI_2;
        default: return 0.0f;
    }
}

static UIInterfaceOrientationMask const UIInterfaceOrientationMaskFromOrientation(UIInterfaceOrientation orientation)
{
    return 1 << orientation;
}

#pragma mark - MASheetBackgroundWindow

@interface MASheetBackgroundWindow()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign, getter = isUpdatingBlur) BOOL updatingBlur;
@end

@implementation MASheetBackgroundWindow
@synthesize backgroundColor = _backgroundColor;

#pragma mark - Class methods

+ (void)initialize
{
    if (self == [MASheetBackgroundWindow class])
    {
        [[self appearance] setBackgroundColor:[UIColor colorWithWhite:0 alpha:MASheetControllerDefaultBackgroundOpacity]];
        [[self appearance] setBackgroundBlurEffect:NO];
        [[self appearance] setBlurRadius:MASheetControllerDefaultBackgroundBlurRadius];
        [[self appearance] setBlurSaturation:MASheetControllerDefaultBackgroundBlurSaturation];
        [[self appearance] setDynamicBlur:NO];
        [[self appearance] setDynamicBlurInterval:0.0f];
    }
}

+ (id)appearance
{
    return [MAAppearance appearanceForClass:[self class]];
}

+ (UIImage *)screenshot
{
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if ((![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) && window.tag != MASheetControllerWindowTag && ![window isKindOfClass:[MASheetBackgroundWindow class]])
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            [[window layer] renderInContext:context];
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Setters

- (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    _supportedInterfaceOrientations = supportedInterfaceOrientations;
    
    [self rotateWindow];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    [super setBackgroundColor:backgroundColor];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (self.backgroundImageView)
    {
        self.backgroundImageView.image = backgroundImage;
    }
    else
    {
        _backgroundImage = backgroundImage;
    }
    
}

- (void)setBackgroundBlurEffect:(BOOL)backgroundBlurEffect
{
    if (_backgroundBlurEffect && !backgroundBlurEffect)
    {
        self.backgroundImageView.image = [[UIImage alloc] init];
    }
    
    _backgroundBlurEffect = backgroundBlurEffect;
    
    if (backgroundBlurEffect)
    {
        [self updateBlur];
    }
    if (self.dynamicBlur)
    {
        [self updateBlurAsynchronously];
    }
}

- (void)setDynamicBlur:(BOOL)dynamicBlur
{
    if (_dynamicBlur != dynamicBlur)
    {
        _dynamicBlur = dynamicBlur;
        if (dynamicBlur)
        {
            [self updateBlurAsynchronously];
        }
    }
}

#pragma mark - Getters

- (UIColor *)backgroundColor
{
    return _backgroundColor;
}

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.opaque = NO;
        self.windowLevel = UIWindowLevelFormSheetBackground;
        
        _supportedInterfaceOrientations = UIInterfaceOrientationMaskAll;
        
        id appearance = [[self class] appearance];
        [appearance applyInvocationTo:self];
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame:frame];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _backgroundImageView.image = _backgroundImage;
        
        [self addSubview:_backgroundImageView];
        
        [_backgroundImageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:NULL];
        
        [self rotateWindow];
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeStatusBarNotificationHandler:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeStatusBarNotificationHandler:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didOrientationChangeNotificationHandler:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
    }
    return self;
}

#pragma mark - Notification handlers

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isEqual:self.backgroundImageView] && [keyPath isEqualToString:@"image"])
    {
        _backgroundImage = change[@"new"];
    }
}

- (void)didOrientationChangeNotificationHandler:(NSNotification *)notification
{
    [self rotateWindow];
}

- (void)didChangeStatusBarNotificationHandler:(NSNotification *)notification
{
    // This notification is inside an animation block
    [self rotateWindow];
}

#pragma mark - Blur

- (UIImage *)rotateImageToStatusBarOrientation:(UIImage *)image
{
    if ([self windowOrientation] == UIInterfaceOrientationLandscapeLeft)
    {
        return [image imageRotatedByDegrees:90];
    }
    else if ([self windowOrientation] == UIInterfaceOrientationLandscapeRight)
    {
        return [image imageRotatedByDegrees:-90];
    }
    else if ([self windowOrientation] == UIInterfaceOrientationPortraitUpsideDown)
    {
        return [image imageRotatedByDegrees:180];
    }
    return image;
}

- (void)updateBlur
{
    UIImage *blurredImage = [[MASheetBackgroundWindow screenshot] blurredImageWithRadius:self.blurRadius tintColor:self.blurTintColor saturationDeltaFactor:self.blurSaturation maskImage:self.blurMaskImage];
    
    self.backgroundImageView.image = [self rotateImageToStatusBarOrientation:blurredImage];
}


- (void)updateBlurAsynchronously
{
    if (self.dynamicBlur && !self.isUpdatingBlur && self.backgroundBlurEffect)
    {
        UIImage *snapshot = [self rotateImageToStatusBarOrientation:[MASheetBackgroundWindow screenshot]];
        
        self.updatingBlur = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            UIImage *blurredImage = [snapshot blurredImageWithRadius:self.blurRadius tintColor:self.blurTintColor saturationDeltaFactor:self.blurSaturation maskImage:self.blurMaskImage];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                self.updatingBlur = NO;
                if (self.dynamicBlur)
                {
                    self.backgroundImageView.image = blurredImage;
                    if (self.dynamicBlurInterval)
                    {
                        [self performSelector:@selector(updateBlurAsynchronously) withObject:nil
                                   afterDelay:self.dynamicBlurInterval inModes:@[NSDefaultRunLoopMode, UITrackingRunLoopMode]];
                    }
                    else
                    {
                        [self performSelectorOnMainThread:@selector(updateBlurAsynchronously) withObject:nil
                                            waitUntilDone:NO modes:@[NSDefaultRunLoopMode, UITrackingRunLoopMode]];
                    }
                }
            });
        });
    }
}

#pragma mark - Window rotations

- (void)rotateWindow
{
    if (self.backgroundBlurEffect)
    {
        [self updateBlur];
    }
    
    CGFloat angle = UIInterfaceOrientationAngleOfOrientation([self windowOrientation]);
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    
    [self makeTransform:transform forView:self.backgroundImageView inFrame:self.bounds];
}

- (void)makeTransform:(CGAffineTransform)transform forView:(UIView *)view inFrame:(CGRect)frame
{
    if(!CGAffineTransformEqualToTransform(view.transform, transform))
    {
        view.transform = transform;
    }
    
    if(!CGRectEqualToRect(view.frame, frame))
    {
        view.frame = frame;
    }
}

- (UIInterfaceOrientation)windowOrientation
{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIInterfaceOrientationMask statusBarOrientationAsMask = UIInterfaceOrientationMaskFromOrientation(statusBarOrientation);
    
    if(self.supportedInterfaceOrientations & statusBarOrientationAsMask)
    {
        return statusBarOrientation;
        
    }
    else
    {
        if(self.supportedInterfaceOrientations & UIInterfaceOrientationMaskPortrait)
        {
            return UIInterfaceOrientationPortrait;
            
        }
        else if(self.supportedInterfaceOrientations & UIInterfaceOrientationMaskLandscapeLeft)
        {
            return UIInterfaceOrientationLandscapeLeft;
            
        }
        else if(self.supportedInterfaceOrientations & UIInterfaceOrientationMaskLandscapeRight)
        {
            return UIInterfaceOrientationLandscapeRight;
            
        }
        else
        {
            return UIInterfaceOrientationPortraitUpsideDown;
        }
    }
}

#pragma mark - Dealloc

- (void)dealloc
{
    [self.backgroundImageView removeObserver:self forKeyPath:@"image"];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

@end
