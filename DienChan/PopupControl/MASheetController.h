//
//  MASheetController.h
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAAppearance.h"
#import "MASheetBackgroundWindow.h"

#if defined(__GNUC__) && ((__GNUC__ >= 4) || ((__GNUC__ == 3) && (__GNUC_MINOR__ >= 1)))
#define MA_DEPRECATED_ATTRIBUTE(message) __attribute__((deprecated(message)))
#else
#define MA_DEPRECATED_ATTRIBUTE(message)
#endif

extern CGFloat const MASheetControllerDefaultAnimationDuration;
extern CGFloat const MASheetControllerWindowTag;

extern NSString *const MASheetWillRotateNotification;

typedef NS_ENUM(NSInteger, MASheetTransitionStyle)
{
    MASheetTransitionStyleSlideFromTop = 0,
    MASheetTransitionStyleSlideFromBottom,
    MASheetTransitionStyleSlideFromLeft,
    MASheetTransitionStyleSlideFromRight,
    MASheetTransitionStyleSlideAndBounceFromLeft,
    MASheetTransitionStyleSlideAndBounceFromRight,
    MASheetTransitionStyleFade,
    MASheetTransitionStyleBounce,
    MASheetTransitionStyleDropDown,
    MASheetTransitionStyleCustom,
    MASheetTransitionStyleNone,
};

extern NSString *const MASheetWillPresentNotification;
extern NSString *const MASheetWillDismissNotification;
extern NSString *const MASheetDidPresentNotification;
extern NSString *const MASheetDidDismissNotification;

@class MASheetController;

typedef void(^MASheetCompletionHandler)(UIViewController *presentedFSViewController);
typedef void(^MASheetBackgroundViewTapCompletionHandler)(CGPoint location);
typedef void(^MASheetPresentationCompletionHandler)(MASheetController *formSheetController);
typedef void(^MASheetTransitionCompletionHandler)();

@interface MASheetWindow: UIWindow<MAAppearance>

@property (nonatomic, assign, getter = isTransparentTouchEnabled) BOOL transparentTouchEnabled MA_APPEARANCE_SELECTOR;
@end

@interface MASheetController: UIViewController<MAAppearance>

+ (MASheetBackgroundWindow *) sharedBackgroundWindow;
+ (NSArray *) formSheetControllersStack;

@property (nonatomic, readonly, strong) MASheetWindow *formSheetWindow;
@property (nonatomic, readonly, strong) UIViewController *presentedFSViewController;
@property (nonatomic, readonly, weak) UIViewController *presentingViewController;
@property (nonatomic, assign) MASheetTransitionStyle transitionStyle MA_APPEARANCE_SELECTOR;
@property (nonatomic, copy) MASheetCompletionHandler willPresentCompletionHandler;
@property (nonatomic, copy) MASheetCompletionHandler willDismissCompletionHandler;
@property (nonatomic, copy) MASheetCompletionHandler didPresentCompletionHandler;
@property (nonatomic, copy) MASheetCompletionHandler didDismissCompletionHandler;
@property (nonatomic, copy) MASheetBackgroundViewTapCompletionHandler didTapOnBackgroundViewCompletionHandler;
@property (nonatomic, assign) CGFloat landscapeTopInset MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat portraitTopInset MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat cornerRadius MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat shadowRadius MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat shadowOpacity MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGSize presentedFormSheetSize MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL shouldCenterVertically MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL shouldDismissOnBackgroundViewTap MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL shouldMoveToTopWhenKeyboardAppears MA_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL shouldCenterVerticallyWhenKeyboardAppears MA_APPEARANCE_SELECTOR;

- (void) customTransitionEntryWithCompletionBlock: (MASheetTransitionCompletionHandler) completionBlock;
- (void) customTransitionOutWithCompletionBlock: (MASheetTransitionCompletionHandler) completionBlock;
- (instancetype) initWithViewController: (UIViewController *) presentedFormSheetViewController;
- (instancetype) initWithSize: (CGSize) formSheetSize
               viewController: (UIViewController *) presentedFormSheetViewController;
- (void) presentAnimated: (BOOL) animated completionHandler: (MASheetCompletionHandler) completionHandler;
- (void) dismissAnimated: (BOOL) animated completionHandler: (MASheetCompletionHandler) completionHandler;

@end

@interface UIViewController (MASheet)
@property (nonatomic, readonly) MASheetController *formSheetController;

- (void) presentFormSheetController: (MASheetController *) formSheetController animated: (BOOL) animated completionHandler: (MASheetPresentationCompletionHandler) completionHandler;
- (void) presentFormSheetWithViewController: (UIViewController *) viewController animated: (BOOL) animated transitionStyle: (MASheetTransitionStyle) transitionStyle completionHandler: (MASheetPresentationCompletionHandler) completionHandler;
- (void) presentFormSheetWithViewController: (UIViewController *) viewController animated: (BOOL) animated completionHandler: (MASheetPresentationCompletionHandler) completionHandler;
- (void) dismissFormSheetControllerAnimated: (BOOL) animated completionHandler: (MASheetPresentationCompletionHandler) completionHandler;

@end
