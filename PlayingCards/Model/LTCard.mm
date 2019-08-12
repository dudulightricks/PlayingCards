// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTCard()

@end

@implementation LTCard

- (int)match:(NSArray *)otherCards{
    int score = 0;
    
    for (LTCard *card in otherCards){
        if ([card.contents isEqualToAttributedString:self.contents]){
            score = 1;
        }
    }
    return score;
}

@end

NS_ASSUME_NONNULL_END
