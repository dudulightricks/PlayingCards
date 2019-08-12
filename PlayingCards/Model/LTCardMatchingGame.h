// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>

#import "LTDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTCardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(LTDeck *)deck withType:
(NSUInteger)type NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (LTCard *)cardAtIndex:(NSUInteger)index;
- (void)removeCardAtIndex:(NSUInteger)index;
- (NSMutableArray *)cards;
- (NSMutableArray *)addCards;

@property (readonly, nonatomic) NSInteger score;
@property (readonly, nonatomic) NSMutableAttributedString *lastStepInfo;
@property (readonly, nonatomic) NSMutableArray *history;
@property (nonatomic) NSInteger gameType; //num of cards

@end

NS_ASSUME_NONNULL_END
