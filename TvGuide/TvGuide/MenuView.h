//
//  AnimationView.h
//  TvGuide
//
//  Created by Sophia Lazarova on 2/6/15.
//  Copyright (c) 2015 Sophia Lazarova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconView.h"

@interface MenuView : UIView

@property(strong, nonatomic) IconView *seriesIcon;
@property(strong, nonatomic) IconView *sportsIcon;
@property(strong,nonatomic) IconView *moviesIcon;
@property(strong,nonatomic) IconView *TVIcon;

-(void) showIcons;

@end
