// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation SetCardView

#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat)faceCardScaleFactor{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setAmount:(NSUInteger)amount{
    _amount = amount;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape{
    _shape = shape;
    [self setNeedsDisplay];
}
- (void)setPattern:(kPattern)pattern{
    _pattern = pattern;
    [self setNeedsDisplay];
    
}

- (void)setChosen:(BOOL)chosen{
    _chosen = chosen;
    [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:
                                 [self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.chosen) {
        [roundedRect setLineWidth:3.0];
        [[UIColor redColor] setStroke];
        [roundedRect stroke];
    }
    
    
    for (int i = 0; i < self.amount; i++){
        if ([self.shape isEqualToString: @"○"]){
            [self drawCircleToSpot:i];
        }
        else if ([self.shape isEqualToString: @"~"]){
            [self drawSquiggleAtPoint:CGPointMake(self.bounds.origin.x + self.bounds.size.width/8,
                                                  self.bounds.origin.y + self.bounds.size.height/6
                                                  +i* self.bounds.size.height/3)];
        }
        else {//@"◇"
            [self drawDiamondToSpot:i];
        }
    }
    
}

- (void)createStrips:(UIBezierPath*)path
{
    // get the bounding rectangle for the outline shape
    CGRect bounds = path.bounds;
    // create a UIBezierPath for the fill pattern
    UIBezierPath *stripes = [UIBezierPath bezierPath];
    for ( int x = 0; x < bounds.size.width; x += 4 ){
        [stripes moveToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y )];
        [stripes addLineToPoint:CGPointMake( bounds.origin.x + x, bounds.origin.y + bounds.size.height )];
    }
    [stripes setLineWidth:2];
    CGContextRef context = UIGraphicsGetCurrentContext();
    // draw the fill pattern first, using the outline to clip
    CGContextSaveGState( context );
    [path addClip];
    [self.color set];
    [stripes stroke];
    CGContextRestoreGState( context );
}

- (void)drawCircleToSpot:(NSInteger)place
{
    UIBezierPath *shape1 = [[UIBezierPath alloc] init];
    CGPoint center = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2,
                                 self.bounds.origin.y + place * self.bounds.size.height/3 +
                                 self.bounds.size.height/6);
    
    CGPoint point2 = CGPointMake(self.bounds.origin.x + 2 * self.bounds.size.width/3,
                                 self.bounds.origin.y + place * self.bounds.size.height/3 +
                                 self.bounds.size.height/6);
    
    [shape1 moveToPoint: point2];
    [self.color setStroke];
    [shape1 addArcWithCenter:center radius:self.bounds.size.width/6 startAngle:0 endAngle:2 *
        M_PI clockwise:YES];
    if (self.pattern == kFull){
        [self.color setFill];
        [shape1 fill];
    }
    if (self.pattern == kStripped){
        [self createStrips: shape1];
    }
    [shape1 stroke];
}

- (void)drawDiamondToSpot:(NSInteger)place
{
    UIBezierPath *shape2 = [[UIBezierPath alloc] init];
    
    CGPoint start = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2,
                                self.bounds.origin.y + self.bounds.size.height/6 +
                                place * self.bounds.size.height/5 );
    
    CGPoint corner1 = CGPointMake(self.bounds.origin.x + 5 * self.bounds.size.width/6,
                                self.bounds.origin.y + place * self.bounds.size.height/5 +
                                4* self.bounds.size.height/15);

    CGPoint corner2 = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2,
                                  self.bounds.origin.y + place * self.bounds.size.height/5 +
                                   11*self.bounds.size.height/30);

    CGPoint corner3 = CGPointMake(self.bounds.origin.x + self.bounds.size.width/6,
                                  self.bounds.origin.y + place * self.bounds.size.height/5 +
                                   4*self.bounds.size.height/15);
    
    [shape2 moveToPoint: start];
    [shape2 addLineToPoint:corner1];
    [shape2 addLineToPoint:corner2];
    [shape2 addLineToPoint:corner3];
    [shape2 closePath];

    if (self.pattern == kFull){
        [self.color setFill];
        [shape2 fill];
    }
    if (self.pattern == kStripped){
        [self createStrips:shape2];
    }
    [self.color setStroke];
    [shape2 stroke];
}

#define SQUIGGLE_WIDTH 0.3
#define SQUIGGLE_HEIGHT 0.4
#define SQUIGGLE_FACTOR 0.4

- (void)drawSquiggleAtPoint:(CGPoint)point {
    CGFloat dx = self.bounds.size.width * SQUIGGLE_WIDTH / 2.0;
    CGFloat dy = self.bounds.size.height * SQUIGGLE_HEIGHT / 2.0;
    CGFloat dsqx = dx * SQUIGGLE_FACTOR;
    CGFloat dsqy = dy * SQUIGGLE_FACTOR;
    
    auto rotation = CGAffineTransformMakeRotation(CGFloat(M_PI / 2.0));
    point = CGPointMake(point.y, point.x - self.bounds.size.width/1.6);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(point.x - dx, point.y - dy)];
    [path addQuadCurveToPoint:CGPointMake(point.x + dx, point.y - dy)
                 controlPoint:CGPointMake(point.x - dsqx, point.y - dy - dsqy)];
    [path addCurveToPoint:CGPointMake(point.x + dx, point.y + dy)
            controlPoint1:CGPointMake(point.x + dx + dsqx, point.y - dy + dsqy)
            controlPoint2:CGPointMake(point.x + dx - dsqx, point.y + dy - dsqy)];
    [path addQuadCurveToPoint:CGPointMake(point.x - dx, point.y + dy)
                 controlPoint:CGPointMake(point.x + dsqx, point.y + dy + dsqy)];
    [path addCurveToPoint:CGPointMake(point.x - dx, point.y - dy)
            controlPoint1:CGPointMake(point.x - dx - dsqx, point.y + dy - dsqy)
            controlPoint2:CGPointMake(point.x - dx + dsqx, point.y - dy + dsqy)];
    [path applyTransform:rotation];
    
    // In here is code from online
    if (self.pattern == kStripped) {
        [self createStrips:path];
    }
    if(self.pattern == kFull){
        [self.color setFill];
        [path fill];
    }
    [self.color setStroke];
    [path stroke];
}

- (void)pushContextAndRotateUpsideDown{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)setup{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end

NS_ASSUME_NONNULL_END
