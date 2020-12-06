//
//  InfoViewController.h
//  DienChan
//
//  Created by khangfet on 7/3/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class InfoViewController;

@protocol InfoViewControllerDelegate <NSObject>
@required
-(void)selectedExit:(InfoViewController*)controller;
@end
@interface InfoViewController : ViewController

@property (nonatomic,weak) id<InfoViewControllerDelegate> delegate;
-(IBAction)btnCloseTouch:(id)sender;
@end
