//
//  CircularProgressView.m
//  CircularPorgressView
//
//  Created by Pankaj Chhikara on 27/05/15.
//  Copyright (c) 2015 pankajchhikara. All rights reserved.
//

#import "CircularProgressView.h"
#import "UIColor+customColors.h"

@interface CircularProgressView ()
@property(strong, nonatomic)UILabel *percentLabel;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic) CGFloat progressToAnimateTo;
@property (nonatomic) CGFloat startAngle;
@end
 

@implementation CircularProgressView


@synthesize radius=_radius,innerStrokeLineWidth=_innerStrokeLineWidth,outerStrokeLineWidth=_outerStrokeLineWidth,progressBarLineWidth=_progressBarLineWidth;
@synthesize progressColor = _progressColor;
@synthesize progressBackgroundColor=_progressBackgroundColor;
@synthesize animate=_animate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initalize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initalize];
        
    }
    return self;
}

-(void)initalize{
    
    self.backgroundColor = [UIColor clearColor];
    self.startAngle =1.5 * M_PI;
    
}



- (void)setProgress:(CGFloat)progress {
    
    //NSLog(@"%@",self.animate);
    self.progressToAnimateTo = progress;
    if ([self.animate boolValue]) {
        if (self.animationTimer) {
            [self.animationTimer invalidate];
        }
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.008 target:self selector:@selector(incrementAnimatingProgress) userInfo:nil repeats:YES];
    } else {
        _progress = progress;
        [self setNeedsDisplay];
    }
}
- (void)incrementAnimatingProgress {
    if (_progress >= self.progressToAnimateTo-0.01 && _progress <= self.progressToAnimateTo+0.01) {
        _progress = self.progressToAnimateTo;
        [self.animationTimer invalidate];
        [self setNeedsDisplay];
    } else {
        _progress = (_progress < self.progressToAnimateTo) ? _progress + 0.01 : _progress - 0.01;
        [self setNeedsDisplay];
    }
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    if ([self.showBackground boolValue]) {
        [self drawBackGround:rect];
        
    }
    if (self.progress >= 0) {
        switch (self.type) {
            case OutlineStyle:
                [self outlineStyle:rect];
                break;
            case KnobStyle:
                [self knobStyle:rect];
                break;
            default:
                [self flatStyle:rect];
                //[self drawBackGround:rect];
                break;
        }
    }
}

-(void)knobStyle:(CGRect)rect{
    
    [self flatStyle:rect];
    //outer stroke
    [self drawArc:rect radius:self.radius+11 startAngle:0 endAngle:2*M_PI lineWidth:self.outerStrokeLineWidth color:self.progressColor];
    
}
-(void)flatStyle:(CGRect)rect{
    
    
    float percentage =self.progress*100;
    
    if (percentage<=20) {
        self.progressColor=[UIColor newRedColor];
    }else if (percentage >20 && percentage<50){
        self.progressColor=[UIColor newOrangeColor];
    }else if (percentage>50 && percentage<70){
        self.progressColor=[UIColor newGreenColor];
    }else if(percentage>70){
        self.progressColor=[UIColor newBlueColor];
    }
    
    [self drawArc:rect  radius:self.radius startAngle:self.startAngle endAngle:(self.progress * M_PI) / 0.5 + self.startAngle lineWidth:self.progressBarLineWidth color:self.progressColor];
    [self addPercentageLabel:self.progress];
}

-(void)outlineStyle:(CGRect)rect{
    
    [self flatStyle:rect];
    //outer stroke
    [self drawArc:rect radius:self.radius+11 startAngle:0 endAngle:2*M_PI lineWidth:self.outerStrokeLineWidth color:self.progressColor];
    //inner stroke
    [self drawArc:rect radius:self.radius-11 startAngle:0 endAngle:2*M_PI lineWidth:self.innerStrokeLineWidth color:self.progressColor];
}

-(void)drawBackGround:(CGRect)rect{
    [self drawArc:rect radius:self.radius startAngle:0 endAngle:2*M_PI lineWidth:self.progressBarLineWidth-2.0 color:self.progressBackgroundColor];
}

-(void)addPercentageLabel:(CGFloat)percentage{
    
    if (!_percentLabel) {
        _percentLabel= [[UILabel alloc]initWithFrame:CGRectMake(0,0, 62, 72)];
        [self addSubview:_percentLabel];
        
    }
    
    [_percentLabel setCenter:CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2+40)];
    [_percentLabel setBackgroundColor:[UIColor clearColor]];
    [_percentLabel setTextColor:[UIColor blackColor]];
    [_percentLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:18]];
    [_percentLabel setTextColor:[UIColor whiteColor]];
    [_percentLabel setText:[NSString stringWithFormat:@"%0.0f%%", percentage*100]];
    [_percentLabel setTextAlignment:NSTextAlignmentCenter];
   // NSLog(@"%.0f",percentage*100);
    
    
    
}

-(void)drawArc:(CGRect)rect radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)lineWidth color:(UIColor *)color{
    
    
    
    UIBezierPath *arc = [UIBezierPath bezierPath];
    //arc.miterLimit=-10;
    [arc addArcWithCenter:CGPointMake(rect.size.width/2, rect.size.height/2)
                   radius:radius
               startAngle:startAngle
                 endAngle:endAngle
                clockwise:YES];
    arc.lineCapStyle=kCGLineCapRound;
    arc.lineWidth =lineWidth;
    
    [color setStroke];
    [arc stroke];
    
    
    
}


#pragma mark - Accessors


-(CGFloat)progressBarLineWidth{
    
    
    if (!_progressBarLineWidth) {
        _progressBarLineWidth=14.0;
    }
    return _progressBarLineWidth;
}


-(CGFloat)outerStrokeLineWidth{
    
    
    if (!_outerStrokeLineWidth) {
        _outerStrokeLineWidth=2.0;
    }
    return _outerStrokeLineWidth;
}


-(CGFloat)innerStrokeLineWidth{
    
    if (!_innerStrokeLineWidth) {
        _innerStrokeLineWidth=2.0;
    }
    return _innerStrokeLineWidth;
}

- (CGFloat)radius {
    if (!_radius) {
        _radius=110.0;
    }
    return _radius;
}


-(UIColor *)progressColor{
    
    if (!_progressColor) {
        //  _color= [UIColor colorWithRed:0.86f green:0.86f blue:0.86f alpha:1.00f];
        _progressColor=[UIColor blueColor];
    }
    return _progressColor;
}

-(UIColor *)progressBackgroundColor{
    
    if (!_progressBackgroundColor) {
        _progressBackgroundColor= [UIColor colorWithRed:0.86f green:0.81f blue:0.92f alpha:0.10f];
    }
    return _progressBackgroundColor;
}

- (NSNumber *)showStroke {
    if (!_showStroke) {
        return @NO;
    }
    return _showStroke;
}

- (NSNumber *)showBackground {
    if (!_showBackground) {
        return @YES;
    }
    return _showBackground;
}
- (NSNumber *)animate {
    if (_animate == nil) {
        return @YES;
    }
    return _animate;
}



@end
