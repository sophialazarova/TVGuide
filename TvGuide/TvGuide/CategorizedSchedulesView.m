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
    self.getScheduleButton = [[UIButton alloc] init];
    [self addSubview:self.getScheduleButton];
    
    self.datePicker = [[UIDatePicker alloc] init];
    [self addSubview:self.datePicker];
}

-(void) setupConstraints{
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.getScheduleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-20);
    }];
}

-(void) customizeSubviews{
    self.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    [self.getScheduleButton setTitle:@"Get Schedule" forState:UIControlStateNormal];
    self.getScheduleButton.layer.borderWidth = 2;
    self.getScheduleButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.getScheduleButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.getScheduleButton setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}
@end
