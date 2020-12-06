//
//  AnimationView.m
//  DienChan
//
//  Created by khangfet on 7/4/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "AnimationView.h"


@implementation AnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initView];
    }
    return self;
}

- (id) initWithCoder: (NSCoder *) aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        [self _initView];
    }
    return self;
}

-(void)_initView
{
    self.backgroundColor = [UIColor colorWithWhite: 0 alpha: 0];
    self.userInteractionEnabled = YES;
    animationImageView.userInteractionEnabled = YES;
    CGRect r = self.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    animationImageView = [[UIImageView alloc] initWithFrame:r];
    [self addSubview:animationImageView];
}

-(NSMutableArray*)loadPicture:(NSString*)extension path:(NSString*)path
{
    NSArray *PhotoArray = [[NSBundle mainBundle] pathsForResourcesOfType:extension inDirectory:path];
    NSMutableArray *imgQueue = [[NSMutableArray alloc] initWithCapacity:PhotoArray.count];
    for (NSString* path in PhotoArray) {
        [imgQueue addObject:[UIImage imageWithContentsOfFile:path]];
    }
    
    return imgQueue;
    
}

-(void)initdataPic:(NSString*)ex path:(NSString*)path
{
    if(_path != path){
        _extension = ex;
        _path = path;
        animationImageView.opaque = NO;
        animationImageView.animationImages = [self loadPicture:_extension path:_path];
    }
}

-(void)playAnimation:(float)duration
{
    self.hidden = NO;
    animationImageView.animationDuration = duration; // 0.5
    [animationImageView startAnimating];
}

-(void)stopAnimation
{
    [animationImageView stopAnimating];
    self.hidden = YES;
}
-(void)startAnimation
{
    [animationImageView startAnimating];
    self.hidden = YES;
    
}
@end