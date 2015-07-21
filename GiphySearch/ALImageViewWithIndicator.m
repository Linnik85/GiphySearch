//
//  SCImageViewWithIndicator.m
//  SmartChat
//
//  Created by Yuriy Nezhura on 25.03.15.
//  Copyright (c) 2015 Yuriy Nezhura. All rights reserved.
//

#import "SCImageViewWithIndicator.h"


#define SEPARATOR_HEIGHT 2.0f

#define degreesToRadians(x) (((x-90.0) * M_PI / 180.0))

@implementation SCImageViewWithIndicator
{
    CALayer* shadowLayer;
    CAShapeLayer *shapeLayer;
}

-(void) awakeFromNib
{
    [super awakeFromNib];
    [self _init];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _init];
    }
    return self;
}

-(void) dealloc
{
    
}

-(void) _init
{
    _isRounded = YES;
    
    self.layer.borderWidth = SEPARATOR_HEIGHT;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.cornerRadius = self.frame.size.width*0.5;
    self.image = [UIImage imageNamed:@"nofoto"];

    shadowLayer = [CALayer layer];
    shadowLayer.frame = self.bounds;
    [self.layer addSublayer:shadowLayer];
    
    shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:shapeLayer];
    
    self.clipsToBounds = YES;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if(!CGRectEqualToRect(frame, CGRectZero))
    {
        if(_isRounded)
        {
            self.layer.borderWidth = SEPARATOR_HEIGHT;
            self.layer.borderColor = [[UIColor whiteColor] CGColor];
            self.layer.cornerRadius = self.frame.size.width*0.5;
        }
        shadowLayer.frame = self.bounds;
        shapeLayer.frame = self.bounds;
//        [self.layer addSublayer:shapeLayer];
    }
    else
        NSLog(@"Zero");
}

-(void) setProgress:(long long) totalBytesRead totalBytesExpectedToRead:(long long) totalBytesExpectedToRead
{
//    [shapeLayer removeFromSuperlayer];
    shadowLayer.backgroundColor = [[UIColor colorWithWhite:0.1 alpha:0.4] CGColor];
    
    CGFloat u = totalBytesRead*360/totalBytesExpectedToRead;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(self.frame.size.width*0.5,self.frame.size.height*0.5)];
    [path addArcWithCenter:CGPointMake(self.frame.size.width*0.5,self.frame.size.height*0.5) radius:self.frame.size.width*0.3 startAngle:degreesToRadians(0) endAngle:degreesToRadians(u) clockwise:YES];
    [path moveToPoint:CGPointMake(self.frame.size.width*0.5,self.frame.size.height*0.5)];
    
    shapeLayer.path = [path CGPath];
    shapeLayer.lineWidth = 0.1;
    shapeLayer.fillColor = [[UIColor colorWithWhite:0.9 alpha:0.4] CGColor];
    shapeLayer.hidden = NO;
//    [self.layer addSublayer:shapeLayer];
}

-(void) endProgress
{
    shapeLayer.hidden = YES;
    shadowLayer.backgroundColor = [[UIColor clearColor] CGColor];
}
@end
