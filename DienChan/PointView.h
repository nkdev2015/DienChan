//
//  PointView.h
//  DienChan
//
//  Created by vankhangfet on 6/30/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PointView;
@protocol PointViewDelegate

@required
- (void) PointViewTouchBegan: (PointView *) pointView;
@end

@interface PointView : UIView
{
    UIImageView * _background;
    UILabel * _lblNumber;
}

@property (weak) id<PointViewDelegate> delegate;
-(void)initView;
-(void)setNumber:(NSString*)number;
-(void)showNumber:(BOOL)isShow;
@property (nonatomic,assign) NSString* category;
@end
