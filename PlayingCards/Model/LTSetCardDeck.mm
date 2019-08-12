// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTSetCardDeck.h"

#import <Foundation/Foundation.h>

#import "LTSetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LTSetCardDeck

- (instancetype)init
{
    if (self = [super init])
    {
        for (NSString *shape in [LTSetCard validShapes]){
            for (NSUInteger rank = 1; rank <= [LTSetCard maxRank]; rank++){
                for (UIColor *color in [LTSetCard validColors]){
                    for (NSNumber* pattern in [LTSetCard validPatterns]){
                        LTSetCard *card =
                        [[LTSetCard alloc] initWithPattern:(kPattern)pattern.intValue withColor:
                                           (UIColor *)color withShape:shape withAmount:
                                           (NSUInteger)rank];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
