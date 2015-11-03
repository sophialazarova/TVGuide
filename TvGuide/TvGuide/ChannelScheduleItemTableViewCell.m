//
//  ChannelScheduleItemTableViewCell.m
//  TvGuide
//
//  Created by Admin on 1/4/15.
//  Copyright (c) 2015 sph. All rights reserved.
//

#import "ChannelScheduleItemTableViewCell.h"
#import "Masonry.h"
#import "UIColor+VeplayCommon.h"

@implementation ChannelScheduleItemTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initializeSubviews];
        [self setupConstraints];
        [self customizeCell];
        self.title.numberOfLines = 0;
        self.title.lineBreakMode = NSLineBreakByWordWrapping;
        self.backgroundColor = [UIColor colorWithHexValue:@"fb9b46" alpha:1.0];
    }
    return self;
}


-(void) initializeSubviews{
    self.title = [[UILabel alloc] init];
    [self addSubview:self.title];
    
    self.time = [[UILabel alloc] init];
    [self addSubview:self.time];
}

-(void) setupConstraints{
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(50);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(10);
        make.bottom.mas_equalTo(self.mas_bottom).with.offset(-10);
        make.left.mas_equalTo(self.time.mas_right).with.offset(20);
        make.right.mas_equalTo(self.mas_right).with.offset(-5);
    }];
}

-(void) customizeCell{
    self.time.textColor = [UIColor whiteColor];
    self.time.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    self.title.font = [UIFont fontWithName:@"Helvetica" size:15];
}

@end
