// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTSetGameController.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LTSetCardDeck.h"
#import "LTCard.h"
#import "LTSetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation LTSetGameController

- (void)setup:(NSInteger) numCards{
    super.my_deck = [[LTSetCardDeck alloc] init];
    super.game = [[LTCardMatchingGame alloc] initWithCardCount:NUM_OF_CARDS
        usingDeck:self.my_deck withType:3];
    
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        LTCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle: [self titleForCard:card] forState:UIControlStateNormal];
    }
}

- (UIImage *)backgroundImageForCard:(LTCard*) card{
    return [UIImage imageNamed: @"cardfront"];
}

- (void)resetHelper: (NSUInteger)NumCards{
    [self setup:NumCards];
    for (UIButton *cardButton in self.cardButtons){
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:(UIControlStateNormal)];
        self.scoreLabel.text = @"Score: 0";
        self.clickInfo.text = @"";
        cardButton.enabled = YES;
    }
}

- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        LTCard *card = [self.game cardAtIndex:cardButtonIndex];
        
        cardButton.enabled = !card.matched;
        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", self.game.score];
        self.clickInfo.attributedText = self.game.lastStepInfo;
    }
}

- (NSAttributedString *)titleForCard:(LTCard *) card{
    return card.contents;
}

@end

NS_ASSUME_NONNULL_END
