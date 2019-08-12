// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTPlayingCardController.h"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation LTPlayingCardController

- (void)setup:(NSInteger) numCards{
    super.my_deck = [[LTPlayingCardDeck alloc] init];
    super.game = [[LTCardMatchingGame alloc] initWithCardCount:NUM_OF_CARDS
                            usingDeck:self.my_deck withType:2];
}

- (UIImage *)backgroundImageForCard:(LTCard*) card{
    return [UIImage imageNamed: card.chosen ? @"cardfront" : @"cardback"];
}

- (void)resetHelper: (NSUInteger)NumCards{
    [self setup:NumCards];
    for(UIButton *cardButton in self.cardButtons){
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:(UIControlStateNormal)];
        NSAttributedString* str = [[NSAttributedString alloc] initWithString:@""];
        [cardButton setAttributedTitle:str forState:UIControlStateNormal];
        self.scoreLabel.text = @"Score: 0";
        self.clickInfo.text = @"";
        
        cardButton.enabled = YES;
    }
}

- (void)updateUI{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        LTCard *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setAttributedTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:(UIControlStateNormal)];
        cardButton.enabled = !card.matched;
        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", self.game.score];
        self.clickInfo.attributedText = self.game.lastStepInfo;
    }
}

- (NSAttributedString *)titleForCard:(LTCard *) card{
    return card.chosen ? card.contents :[[NSAttributedString alloc] initWithString:@"" attributes:nil];
}

@end



NS_ASSUME_NONNULL_END
