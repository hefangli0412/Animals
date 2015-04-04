//
//  SquareView.m
//  Animals
//
//  Created by Hefang Li on 4/4/15.
//  Copyright (c) 2015 hefang. All rights reserved.
//

#import "SquareView.h"

@implementation SquareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque=NO;
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGRect bounds=self.bounds;
    //Figure out the center of the bounds rectangle.
    
    CGPoint center;
    
    center.x=bounds.origin.x+bounds.size.width/2.0;
    center.y=bounds.origin.y+bounds.size.height/2.0;
    
    
    //I make the radius a 10th the length of the hypotenuse:
    
    float radius=hypot(bounds.size.width, bounds.size.height)/10.0;
    
    
    //Draw using UIBezierPath:
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    //
    [path addArcWithCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    [path moveToPoint:CGPointMake(center.x, center.y-radius-15)];
    
    [path addLineToPoint:CGPointMake(center.x, center.y-radius+15)];
    
    [path moveToPoint:CGPointMake(center.x, center.y+radius-15)];
    
    [path addLineToPoint:CGPointMake(center.x, center.y+radius+15)];
    
    [path moveToPoint:CGPointMake(center.x-radius-15, center.y)];
    
    [path addLineToPoint:CGPointMake(center.x-radius+15, center.y)];
    
    [path moveToPoint:CGPointMake(center.x+radius-15, center.y)];
    
    [path addLineToPoint:CGPointMake(center.x+radius+15, center.y)];
    
    
    path.lineWidth=7;
    
    [[UIColor lightGrayColor] setStroke];
    
    //Draw it!
    
    [path stroke];
}

@end
