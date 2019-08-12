// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTPlayingCardDeck.h"

#import <Foundation/Foundation.h>

#import "LTPlayingCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LTPlayingCardDeck

- (instancetype)init
{
    if (self = [super init]){
        for (NSString *suit in [LTPlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [LTPlayingCard maxRank]; rank++){
                LTPlayingCard *card = [[LTPlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
