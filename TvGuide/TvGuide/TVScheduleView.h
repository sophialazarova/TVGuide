//
//  TVScheduleView.h
//  TvGuide
//
//  Created by Admin on 2/21/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVScheduleView : UIView

@property (strong, nonatomic) UIPickerView *channelPicker;
@property (strong,nonatomic) UIButton *getScheduleButton;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;

-(void) addAction:(SEL) selector caller:(id) caller;

@end
