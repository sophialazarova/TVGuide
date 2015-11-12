//
//  UIColor + HexRepresentation.h
//  TvGuide
//
//  Created by Sophia on 11/12/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexRepresentation)

+ (UIColor*)colorWithHexValue:(NSString*)hexValue alpha:(CGFloat)alpha;

@end
