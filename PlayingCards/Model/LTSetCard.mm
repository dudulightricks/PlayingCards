// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTSetCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTSetCard()

@property (nonatomic, readwrite) NSUInteger amount;
@property (nonatomic, readwrite) UIColor* color;
@property (nonatomic, readwrite) NSString* shape;
@property (nonatomic, readwrite) kPattern pattern;

@end

@implementation LTSetCard

- (instancetype)initWithPattern: (kPattern)chosenPattern withColor: (UIColor *)chosenColor
                     withShape: (NSString *)chosenShape withAmount:(NSUInteger)chosenAmount{
    if (self = [super init]){
        _color = chosenColor;
        _shape = chosenShape;
        _pattern = chosenPattern;
        _amount = chosenAmount;
    }
    return self;
}

- (NSAttributedString *)contents{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] init];
    
    for (int i = 0; i < _amount; i++){
        [content appendAttributedString:[[NSAttributedString alloc] initWithString:self.shape]];
    }
    
    switch (self.pattern) {
        case kFull:
            [content addAttributes:@{NSStrokeWidthAttributeName: @-5}
                             range:NSMakeRange(0, content.length)];
            break; //StrokeColor, NSUnderlineColor

        case kStripped:
            [content addAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleDouble]} range:NSMakeRange(0,content.length)];
            break;
        default:
            break;
    }
    [content addAttributes:@{NSForegroundColorAttributeName: self.color}
                     range:NSMakeRange(0,content.length)];
    
    return content;
}

- (int)match:(NSArray *)otherCards{
    int score = 0;
    
    if (otherCards.count != 2){
        return score;
    }
    
    LTSetCard* card1 = otherCards[0];
    LTSetCard* card2 = otherCards[1];
    
    return  [LTSetCard isValidSetWith:[LTSetCard hexStringFromColor:self.color] andAnotherCardValue:
         [LTSetCard hexStringFromColor:card1.color] andValue:[LTSetCard hexStringFromColor:
        card2.color]]
    &&
    [LTSetCard isValidSetWith:[NSString stringWithFormat:@"%lu",self.amount] andAnotherCardValue:
     [NSString stringWithFormat:@"%lu",card1.amount] andValue:[NSString stringWithFormat:
                                                               @"%lu",card2.amount]]
    &&
        [LTSetCard isValidSetWith:self.shape andAnotherCardValue:card1.shape andValue:card2.shape]
    &&
        [LTSetCard isValidSetWith:[NSString stringWithFormat:@"%lu",self.pattern]
              andAnotherCardValue:[NSString stringWithFormat:@"%lu",card1.pattern] andValue:
         [NSString stringWithFormat:@"%lu",card2.pattern]]
    ? 1: 0;

}

+ (BOOL)isValidSetWith:(NSString*)firstValue andAnotherCardValue:(NSString*)secondValue
              andValue:(NSString*)thirdValue
{
    if ([firstValue isEqual:secondValue] && [firstValue isEqual:thirdValue]){
        return YES;
    }
    else if (![firstValue isEqual:secondValue] && ![secondValue isEqual:thirdValue] &&
            ![thirdValue isEqual:firstValue]){
        return YES;
    }
    return NO;
}

+ (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

+ (NSArray<NSNumber *>*)validPatterns{
    return @[[NSNumber numberWithInteger:kFull], [NSNumber numberWithInteger:kEmpty],
             [NSNumber numberWithInteger:kStripped]];
}

+ (NSArray *)validColors{
    return @[UIColor.purpleColor, UIColor.redColor, UIColor.greenColor];
}

+ (NSArray *)validShapes{
    return @[@"~",@"◇",@"○"];
}

+ (NSInteger)maxRank{
    return 3;
}

@end

NS_ASSUME_NONNULL_END
