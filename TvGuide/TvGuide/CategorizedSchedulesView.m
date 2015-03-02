//
//  CategorizedSchedulesView.m
//  TvGuide
//
//  Created by Admin on 3/1/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "CategorizedSchedulesView.h"
#import "Masonry.h"
#import "UIColor+VeplayCommon.h"


@implementation CategorizedSchedulesView

-(instancetype)init{
    self = [super init];
    if(self){
        [self initializeSubviews];
        [self setupConstraints];
        [self customizeSubviews];
    }
    
    return self;
}

-(void)addAction:(SEL)selector caller:(id)caller{
    [self.getScheduleButton addTarget:caller action:selector forControlEvents:UIControlEventTouchUpInside];
}

-(void) initializeSubviews{
    self.getScheduleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.getScheduleButton];
    
    self.datePicker = [[UIDatePicker alloc] init];
    [self addSubview:self.datePicker];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:self.activityIndicator];
}

-(void) setupConstraints{
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(30);
    }];
    
    [self.getScheduleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-40);
    }];
    
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.mas_height);
        make.width.mas_equalTo(self.mas_width);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

-(void) customizeSubviews{
    self.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    [self.getScheduleButton setTitle:@"Get Schedule" forState:UIControlStateNormal];
    self.getScheduleButton.layer.borderWidth = 2;
    self.getScheduleButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.getScheduleButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.getScheduleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getScheduleButton setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.activityIndicator.backgroundColor = [UIColor colorWithHexValue:@"#000000" alpha:0.2];
    [self limitDatePicker];
}

-(void) limitDatePicker{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    NSDate *minDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    [comps setDay:5];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
}

@end
