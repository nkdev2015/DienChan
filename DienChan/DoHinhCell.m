//
//  DoHinhCell.m
//  DienChan
//
//  Created by vankhangfet on 6/28/14.
//  Copyright (c) 2014 5solution. All rights reserved.
//

#import "DoHinhCell.h"

@implementation DoHinhCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _img = [[UIImageView alloc]initWithFrame:frame];
        [self addSubview:_img];
        
    }
    return self;
}


-(void)setImgeForCell:(NSString*)path
{
    _img.image = [UIImage imageNamed:path];
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
