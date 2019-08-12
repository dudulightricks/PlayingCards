// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>

#import "LTCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTSetCard : LTCard

typedef NS_ENUM(NSInteger, kPattern) {
    kFull, kEmpty, kStripped
};

- (instancetype)initWithPattern: (kPattern)chosenPattern withColor: (UIColor *)chosenColor
                      withShape: (NSString*)chosenShape
                     withAmount:(NSUInteger)chosenAmount NS_DESIGNATED_INITIALIZER;
- (NSAttributedString *)contents;
- (int)match:(NSArray *)otherCards;

+ (NSArray *)validPatterns;
+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSInteger)maxRank;

@property (nonatomic, readonly) NSUInteger amount;
@property (nonatomic, readonly) UIColor *color;
@property (nonatomic, readonly) NSString *shape;
@property (nonatomic, readonly) kPattern pattern; //strip, full or empty

@end

NS_ASSUME_NONNULL_END
