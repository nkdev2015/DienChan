//
//  MASheetBackgroundWindow.h
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAAppearance.h"

@interface MASheetBackgroundWindow: UIWindow<MAAppearance>

@property (nonatomic, strong) UIColor *backgroundColor MA_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIImage *backgroundImage MA_APPEARANCE_SELECTOR;
@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;
@property (nonatomic, assign) BOOL backgroundBlurEffect MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat blurRadius MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIColor *blurTintColor MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat blurSaturation MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIImage *blurMaskImage MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL dynamicBlur MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat dynamicBlurInterval MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) UIInterfaceOrientationMask supportedInterfaceOrientations MA_APPEARANCE_SELECTOR;
@end
