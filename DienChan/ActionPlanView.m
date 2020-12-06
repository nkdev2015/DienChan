//
//  ActionPlanView.m
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "ActionPlanView.h"

@implementation ActionPlanView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        animationView = [[AnimationView alloc]initWithFrame:CGRectMake(0, 0, 80, 200)];
        [animationView initdataPic:@"png"  path:@"Resource/quedienchan"];
        [animationView playAnimation:0.5];
        [self addSubview:animationView];
        
        huyetNumber = [[UILabel alloc]initWithFrame:CGRectMake(65,50,150,30)];
        [huyetNumber setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [huyetNumber setTextColor:[UIColor blackColor]];
       
        
        title = [[UILabel alloc]initWithFrame:CGRectMake(65,70,150,30)];
        [title setFont:[UIFont fontWithName:@"Helvetica" size:15]];
        [title setTextColor:[UIColor blackColor]];
       
        
        //UIView * tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 170, 180, 70)];
        //[tempView setBackgroundColor:[UIColor clearColor]];
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(50, 40, 180, 70)];
        background.image = [UIImage imageNamed:@"Resource/FAQ-512.png"];
        [self addSubview:background];
        
        
         //[self addSubview:tempView];
         [self addSubview:huyetNumber];
         [self addSubview:title];
        
        
    }
    return self;
}

-(void)updateContent:(NSString*)titleNumber
{
    huyetNumber.text = [NSString stringWithFormat:@"Huyệt số : %@",titleNumber];
    title.text = @"Thực hiện: Ấn 30 lần";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
