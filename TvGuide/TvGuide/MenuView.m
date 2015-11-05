//
//  AnimationView.m
//  LocationAnimation
//
//  Created by Sophia Lazarova on 2/6/15.
//  Copyright (c) 2015 Sophia Lazarova. All rights reserved.
//

#import "MenuView.h"
#import <Masonry.h>
#import "UIColor+VeplayCommon.h"

@implementation MenuView{
    BOOL areIconsVisisble;
}
-(instancetype)init{
    self = [super init];
    if(self){
        areIconsVisisble = NO;
        [self initializeComponents];
        [self setupClosedStateIconsConstrants];
        [self setBackgroundColor:[UIColor colorWithHexValue:@"FCAD5D" alpha:1.0]];
    }
        return self;
}

-(void) initializeComponents{
    UIImage *seriesImg = [UIImage imageNamed:@"series.png"];
    self.seriesIcon = [[IconView alloc] initWithTitle:@"Сериали" icon:seriesImg];
    [self addSubview:self.seriesIcon];
    
    UIImage *TVImg = [UIImage imageNamed:@"tv.png"];
    self.TVIcon = [[IconView alloc] initWithTitle:@"ТВ програма" icon:TVImg];
    [self addSubview:self.TVIcon];
    
    UIImage *moviesImg = [UIImage imageNamed:@"movies.png"];
    self.moviesIcon= [[IconView alloc] initWithTitle:@"Филми" icon:moviesImg];
    [self addSubview:self.moviesIcon];
    
    UIImage *sportsImg = [UIImage imageNamed:@"sports.png"];
    self.sportsIcon = [[IconView alloc] initWithTitle:@"Спорт" icon:sportsImg];
    [self addSubview:self.sportsIcon];
}

-(void) setupClosedStateIconsConstrants{
    [self.seriesIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.seriesIcon.alpha = 0.0;
    
    [self.moviesIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.moviesIcon.alpha = 0.0;
    
    [self.TVIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.TVIcon.alpha = 0.0;
    
    [self.sportsIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    self.sportsIcon.alpha = 0.0;
}

-(void) setupOpenStateIconsConstrants{
    [self.seriesIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-80);
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(-76.5);
    }];
    
    [self.moviesIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seriesIcon.mas_bottom).with.offset(57.4);
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(-76.5);
        
    }];
    
    [self.TVIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(-80);
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(76.5);
    }];
    
    [self.sportsIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.seriesIcon.mas_bottom).with.offset(57.4);
       make.centerX.mas_equalTo(self.mas_centerX).with.offset(76.5);
    }];
}

-(void) showIcons{
    [self setupOpenStateIconsConstrants];
    [self zoomIn:self.seriesIcon];
    [self zoomIn:self.sportsIcon];
    [self zoomIn:self.TVIcon];
    [self zoomIn:self.moviesIcon];
    areIconsVisisble = !areIconsVisisble;
    [self animateConstrants];
}

-(void) hideIcons{
    [self setupClosedStateIconsConstrants];
    [self zoomOut:self.seriesIcon];
    [self zoomOut:self.sportsIcon];
    [self zoomOut:self.TVIcon];
    [self zoomOut:self.moviesIcon];
    areIconsVisisble = !areIconsVisisble;
    [self animateConstrants];
}

-(void) zoomIn:(UIView*) element{
    element.alpha = 0.0f;
    element.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView beginAnimations:@"zoomIn" context:NULL];
    [UIView setAnimationDuration:0.8];
    element.transform = CGAffineTransformMakeScale(1,1);
    element.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void) zoomOut:(UIView*) element{
    element.alpha = 1.0f;
    element.transform = CGAffineTransformMakeScale(1,1);
    [UIView beginAnimations:@"zoomOut" context:NULL];
    [UIView setAnimationDuration:0.8];
    element.transform = CGAffineTransformMakeScale(0.1,0.1);
    element.alpha = 0.0f;
    [UIView commitAnimations];
}

-(void) animateConstrants{
    [UIView animateWithDuration:0.8 animations:^{
        [self.seriesIcon layoutIfNeeded];
        [self.TVIcon layoutIfNeeded];
        [self.moviesIcon layoutIfNeeded];
        [self.sportsIcon layoutIfNeeded];
    }];
}

@end
