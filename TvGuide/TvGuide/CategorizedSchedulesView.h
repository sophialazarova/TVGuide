//
//  CategorizedSchedulesView.h
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGTextField.h"

@interface CategorizedSchedulesView : UIView

@property(strong, nonatomic) UIButton *getScheduleButton;
@property(strong,nonatomic) UIDatePicker *datePicker;
@property (strong,nonatomic) UIActivityIndicatorView *activityIndicator;

-(void) addAction:(SEL) selector caller:(id) caller;

@end
