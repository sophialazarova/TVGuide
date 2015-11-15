//
//  IconView.m
//  TvGuide
//
//  Created by Sophia Lazarova on 2/6/15.
//  Copyright (c) 2015 Sophia Lazarova. All rights reserved.
//

#import "IconView.h"
#import <Masonry.h>
#import "UIColor+HexRepresentation.h"

@implementation IconView

-(instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon
{
    self = [super init];
    if(self){
        [self intializeSubviews];
        [self setTitle:title icon:icon];
        [self setTitleFont];
        [self addConstraintsToSubviews];
    }
    
    return self;
}

-(void) intializeSubviews
{
    self.iconImageView = [[UIImageView alloc] init];
    [self addSubview:self.iconImageView];
    
    self.title = [[UILabel alloc] init];
    [self addSubview:self.title];
}

-(void) setTitle:(NSString*) title icon:(UIImage*) icon
{
    self.iconImageView.image = icon;
    self.title.text = title;
}

-(void) addConstraintsToSubviews
{
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).with.offset(16);
        make.centerX.mas_equalTo(self.iconImageView.mas_centerX);
    }];
}

-(CGSize)intrinsicContentSize
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12.88]};
    CGSize textSize =  [self.title.text sizeWithAttributes:attributes];
    CGFloat width = MAX(self.iconImageView.image.size.width, textSize.width);
    CGFloat height = self.iconImageView.image.size.height + textSize.height;
    CGFloat verticalSpace = 16;
    return CGSizeMake(width, height+verticalSpace);
}

-(void) setTitleFont
{
    self.title.textColor = [UIColor blackColor];
    [self.title setFont:[UIFont boldSystemFontOfSize:17]];
}

-(void)addAction:(SEL)selector caller:(id)caller
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:caller action:selector];
    [self addGestureRecognizer:tapRecognizer];
}

@end
