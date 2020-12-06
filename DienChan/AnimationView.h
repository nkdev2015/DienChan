//
//  AnimationView.h
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView
{
    NSString *_extension;
    NSString *_path;
    UIImageView *animationImageView;
}

-(NSMutableArray*)loadPicture:(NSString*)extension path:(NSString*)path;
-(void)initdataPic:(NSString*)ex path:(NSString*)path;
-(void)playAnimation:(float)duration;
-(void)stopAnimation;
-(void)startAnimation;
@end