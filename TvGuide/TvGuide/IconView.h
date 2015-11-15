//
//  IconView.h
//  TvGuide
//
//  Created by Sophia Lazarova on 2/6/15.
//  Copyright (c) 2015 Sophia Lazarova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconView : UIView

@property(strong,nonatomic) UILabel *title;

@property(strong,nonatomic) UIImageView *iconImageView;

-(instancetype) initWithTitle: (NSString*) title icon:(UIImage*) icon;

-(void) addAction:(SEL) selector caller:(id) caller;

@end
