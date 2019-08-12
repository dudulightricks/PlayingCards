// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTCardMatchingGame.h"

#import "LTCard.h"

#define MATCH_BONUS 4
#define MISTAKE_PENALTY 2
#define COST_TO_CHOOSE 1
#define CARDS_TO_ADD 3

NS_ASSUME_NONNULL_BEGIN

@interface LTCardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (readwrite, nonatomic) NSMutableAttributedString *lastStepInfo;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic) NSMutableArray *cardsFounded;
@property (readwrite, nonatomic) NSMutableArray *history;
@property (nonatomic) LTDeck* deck;
@end

@implementation LTCardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(LTDeck*)deck withType:
(NSUInteger)type{
    if (self = [super init]){
        _deck = deck;
        _gameType = type - 1;
        _history = [[NSMutableArray alloc] init];
        self.cards = [[NSMutableArray alloc] init];
        
        for (int i = 0; i <count; i++){
            LTCard* card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSMutableArray *)cards{
    return _cards;
}
- (LTCard *)cardAtIndex:(NSUInteger)index{
    if (index < self.cards.count){
        return self.cards[index];
    }
    return nil;
}

- (NSMutableArray *)addCards
{
    NSMutableArray * addedCards = [[NSMutableArray alloc] init];
    for(int i = 0; i < CARDS_TO_ADD; i++)
    {
        LTCard* card = [self.deck drawRandomCard];
        [addedCards addObject:card];
        [self.cards addObject:card];
    }
    return addedCards;
}

- (void)removeCardAtIndex:(NSUInteger)index{
    if (index < self.cards.count){
        [self.cards removeObject:self.cards[index]];
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    LTCard *card = [self cardAtIndex:index];
    if (card == nil){
        return;
    }
    if (card.matched){
        return;
    }
    if (card.chosen){
        card.chosen = NO;
        return;
    }

    self.lastStepInfo = [[NSMutableAttributedString alloc] initWithString:@""];
    [_lastStepInfo appendAttributedString:[[NSAttributedString alloc] initWithAttributedString:
                                           card.contents]];
                         
    [_lastStepInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
    
    self.cardsFounded = [[NSMutableArray alloc] init];
    for (LTCard *otherCard in self.cards){
        if (otherCard.chosen && !otherCard.matched){
            [self.cardsFounded addObject:otherCard];
 	           [_lastStepInfo appendAttributedString:[[NSAttributedString alloc] initWithAttributedString:otherCard.contents]];
            [_lastStepInfo appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
        
        if (self.cardsFounded.count == self.gameType){
            [self UpdateScoreByMatchingCard: card toCard: otherCard];
            break;
        }
    }
    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (void)UpdateScoreByMatchingCard: (LTCard*)card toCard:(LTCard*) otherCard{
    int matchScore = [card match:self.cardsFounded];
    if (matchScore){
        self.score += matchScore * MATCH_BONUS;
        for(LTCard *cardFounded in self.cardsFounded){
            cardFounded.matched = YES;
        }
        card.matched = YES;
        
        [_lastStepInfo appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" Matched! earned %d points", matchScore * MATCH_BONUS -
                                                                                COST_TO_CHOOSE]]];
    }
    else {
        self.score -= MISTAKE_PENALTY;
        for (LTCard *cardFounded in self.cardsFounded){
            cardFounded.chosen = NO;
        }
        
        [_lastStepInfo appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" Didnt Matched! lost %d points", MISTAKE_PENALTY + COST_TO_CHOOSE]]];
    }
    [self.history addObject:_lastStepInfo];
}

@end

NS_ASSUME_NONNULL_END
