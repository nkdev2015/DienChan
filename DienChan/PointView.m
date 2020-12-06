//
//  PointView.m
//  DienChan
//
//  Created by vankhangfet on 6/30/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "PointView.h"

@implementation PointView
@synthesize category = _category;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
        _background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
       
        CGPoint  point =   CGPointMake(frame.size.width/2, frame.size.height/2);
        _background.center  = point;
        
        _background.image = [UIImage imageNamed:@"Resource/Point.png"];
        [self addSubview:_background];
        
        _lblNumber = [[UILabel alloc]initWithFrame:CGRectMake(-10, 0, 40, 20)];
        [self addSubview:_lblNumber];
        [_lblNumber setBackgroundColor:[UIColor clearColor]];
        [_lblNumber setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [_lblNumber setTextColor:[UIColor whiteColor]];
        _lblNumber.text = @"";
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;

}

-(void)setNumber:(NSString*)number
{

    _lblNumber.text = number;
}

-(void)showNumber:(BOOL)isShow
{
    if(isShow)
    {
        _lblNumber.hidden = NO;
    }
    else
    {
      _lblNumber.hidden = YES;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* TO DO: Display information
    NSString * _number = [NSString stringWithFormat:@"%@",_lblNumber.text];
    NSLog(@"touch on point");
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Huyệt Số" message:_number delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
     */
}

-(void)initView
{
    [self setBackgroundColor:[UIColor clearColor]];
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
