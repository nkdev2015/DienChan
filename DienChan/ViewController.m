//
//  ViewController.m
//  DienChan
//
//  Created by vankhangfet on 6/26/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil
{
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) presentAsSheetController: (UIViewController *) controller
{
    _sheetController = [[MASheetController alloc] initWithSize: controller.view.frame.size viewController: controller];
    _sheetController.landscapeTopInset = (self.view.frame.size.height - controller.view.frame.size.height) / 2;
    _sheetController.transitionStyle = MASheetTransitionStyleBounce;
    _sheetController.shouldDismissOnBackgroundViewTap = NO;
    _sheetController.shouldCenterVerticallyWhenKeyboardAppears = YES;
    [_sheetController presentAnimated: YES completionHandler: nil];
}

- (void) dismissSheetController
{
    [_sheetController dismissAnimated: YES completionHandler: ^(UIViewController *presentedFSViewController) {
        _sheetController = nil; }];
}
@end
