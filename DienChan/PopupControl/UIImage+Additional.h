//
//  UIImage+Additional.h
//  ColorBuddy
//
//  Created by Nguyen Duc Hiep on 18/09/2013.
//  Copyright (c) 2013 Med-Aid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additional)

- (UIImage *) imageRotatedByRadians: (CGFloat) radians;
- (UIImage *) imageRotatedByDegrees: (CGFloat) degrees;

- (UIImage *) blurredImageWithRadius: (CGFloat) blurRadius
                          tintColor: (UIColor *) tintColor
              saturationDeltaFactor: (CGFloat) saturationDeltaFactor
                          maskImage: (UIImage *) maskImage;
@end
