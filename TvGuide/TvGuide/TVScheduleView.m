//
//  TVScheduleView.m
//  TvGuide
//
//  Created by Admin on 2/21/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "TVScheduleView.h"
#import "Masonry.h"
#import "UIColor+VeplayCommon.h"

@implementation TVScheduleView

-(instancetype)init{
    self = [super init];
    if(self){
        [self initializeSubviews];
        [self setupConstraints];
        [self customizeView];
    }
    
    return self;
}

-(void) initializeSubviews{
    self.channel = [[UITextField alloc] init];
    [self addSubview:self.channel];
    
    self.channelPicker = [[UIPickerView alloc] init];
    [self addSubview:self.channelPicker];
    
    self.getScheduleButton = [[UIButton alloc] init];
    [self addSubview:self.getScheduleButton];
    
    self.datePicker = [[UIDatePicker alloc] init];
    [self addSubview:self.datePicker];
}

-(void) customizeView{
    self.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    [self.getScheduleButton setTitle:@"Get Schedule" forState:UIControlStateNormal];
    self.getScheduleButton.layer.borderWidth = 2;
    self.getScheduleButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.getScheduleButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:20]];
    [self.getScheduleButton setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

-(void) setupConstraints{
    [self.channelPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.channel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.channelPicker.mas_bottom).with.offset(10);
    }];
    
    [self.getScheduleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-20);
    }];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.channel.mas_bottom).with.offset(20);
        make.height.mas_equalTo(50);
    }];
}

-(void)addAction:(SEL)selector caller:(id)caller{
    [self.getScheduleButton addTarget:caller action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
