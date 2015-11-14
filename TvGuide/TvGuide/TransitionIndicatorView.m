//
//  TransitionIndicatorView.m
//  TvGuide
//
//  Created by Sophiya Lazarova on 11/5/15.
//  Copyright © 2015 sph. All rights reserved.
//

#import "TransitionIndicatorView.h"
#import "UIColor+HexRepresentation.h"

@implementation TransitionIndicatorView
{
    NSMutableArray *_points;
    CGFloat _pointWidth;
    CGFloat _horizontalInsets;
    UIColor *_defaultPointColor;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _horizontalInsets =frame.size.width/3;
        _pointWidth = (_horizontalInsets/5)/2;
        _defaultPointColor = [UIColor colorWithHexValue:@"FA9A46" alpha:1.0];
        self.backgroundColor = [UIColor colorWithHexValue:@"000000" alpha:0.4];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.bounds;
        [self insertSubview:blurView atIndex:0];
        [self initializePoints];
    }
    
    return self;
}

-(void) initializePoints
{
    _points = [NSMutableArray new];

    for (int i = 0; i < 5; i++) {
        CALayer *point = [CALayer new];
        point.backgroundColor = _defaultPointColor.CGColor;
        if (i == 0){
            point.backgroundColor = [UIColor colorWithHexValue:@"FDFAE6" alpha:1.0].CGColor;
        }
        point.frame = CGRectMake(_horizontalInsets + i*_pointWidth*2 , self.bounds.size.height/2-_pointWidth/2, _pointWidth,  _pointWidth);
        point.cornerRadius = _pointWidth/2;
        [self.layer addSublayer:point];
        [_points addObject:point];
    }
}

-(void)resetPointsBackgroundColor
{
    for (int i = 0; i < _points.count; i++) {
        CALayer *current = _points[i];
        current.backgroundColor = _defaultPointColor.CGColor;
    }
}

-(void)setSelectionAtIndex:(NSInteger)index
{
    if (index >= 0 && index < _points.count)
    {
        [self resetPointsBackgroundColor];
        CALayer *selectedPoint = _points[index];
        selectedPoint.backgroundColor = [UIColor colorWithHexValue:@"FDFAE6" alpha:1.0].CGColor;
    }
}

@end
