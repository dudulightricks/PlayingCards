// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTDeck.h"

#import "LTCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTDeck()
@property (strong, nonatomic) NSMutableArray<LTCard *> *cards;
@end

@implementation LTDeck

- (instancetype)init{
    if (self = [super init]){
        self.cards = [[NSMutableArray<LTCard *> alloc] init];
    }
    return self;
}

- (void)addCard:(LTCard *)card atTop:(BOOL)atTop{
    if (atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}

- (void)addCard:(LTCard *)card{
    [self addCard:card atTop:NO];
}

- (LTCard *)drawRandomCard{
    LTCard *randomCard = nil;
    if ([self.cards count]){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
        
    }
    return randomCard;
}
@end

NS_ASSUME_NONNULL_END
