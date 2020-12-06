//
//  ActionPlanView.h
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationView.h"
@interface ActionPlanView : UIView
{
    AnimationView * animationView;
     UILabel * huyetNumber;
     UILabel * title;
}

-(void)updateContent:(NSString*)title;
@end
