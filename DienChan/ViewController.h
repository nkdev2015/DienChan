//
//  ViewController.h
//  DienChan
//
//  Created by vankhangfet on 6/26/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MASheetController.h"
@interface ViewController : UIViewController
{
   MASheetController *_sheetController;
}
- (void) presentAsSheetController: (UIViewController *) controller;
- (void) dismissSheetController;
@end
