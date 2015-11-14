//
//  CircularProgressView.h
//  CircularPorgressView
//
//  Created by Pankaj Chhikara on 27/05/15.
//  Copyright (c) 2015 pankajchhikara. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE


typedef enum {
    FlatStyle,
    OutlineStyle,
    KnobStyle
} StyleType;

@interface CircularProgressView : UIView


@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat progressBarLineWidth;
@property (nonatomic) CGFloat innerStrokeLineWidth;
@property (nonatomic) CGFloat outerStrokeLineWidth;

@property (nonatomic, strong) NSNumber *animate UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showBackground UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *progressBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *progressColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *background UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) NSNumber *showStroke UI_APPEARANCE_SELECTOR;


@property (nonatomic) StyleType type;

@end
