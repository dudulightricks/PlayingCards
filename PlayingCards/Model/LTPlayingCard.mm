// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTPlayingCard.h"

#import <Foundation/Foundation.h>

#import "LTCard.h"


#define RANK_SCORE 4
#define SUIT_SCORE 1

NS_ASSUME_NONNULL_BEGIN

@implementation LTPlayingCard
@synthesize suit = _suit;

- (NSAttributedString *)contents{
    NSArray *rankStrings = [LTPlayingCard rankStrings];
    return [[NSAttributedString alloc] initWithString:
            [rankStrings[self.rank] stringByAppendingString:self.suit]];
}

+ (NSArray *)validSuits{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit{
    if([[LTPlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank{
    return [self rankStrings].count - 1;
}

-(void)setRank:(NSUInteger) rank{
   if (rank <= [LTPlayingCard maxRank])
   {
       _rank = rank;
   }
}

- (int)match:(NSArray *)otherCards{
    int score_suit = 0, score_rank = 0;
    
    for(LTPlayingCard *card in otherCards){
        if ([card.suit isEqualToString:self.suit]){
            score_suit += SUIT_SCORE;
        }
        else if (card.rank == self.rank){
            score_rank += RANK_SCORE;
        }
    }
    if (score_rank > score_suit){
        return score_rank;
    }
    return score_suit;
}
@end

NS_ASSUME_NONNULL_END
