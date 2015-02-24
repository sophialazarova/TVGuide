//
//  UIColor+VeplayCommon.h
//  YouLocal
//
//  Created by uBo on 13/02/2013.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (VeplayCommon)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) UInt32 rgbHex;

+ (UIColor*)colorWithHexValue:(NSString*)hexValue alpha:(CGFloat)alpha;

@end
