// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "SetNewViewController.h"

#import "SetCardView.h"
#import "LTSetCardDeck.h"
#import "LTSetCard.h"
#import "LTCardMatchingGame.h"
#import "LTGridView.h"

#define NUM_CARDS 20
#define MAX_CARDS 50

NS_ASSUME_NONNULL_BEGIN

@interface SetNewViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) LTSetCardDeck *deck;
@property (strong, nonatomic) LTCardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickInfo;
@end

@implementation SetNewViewController

- (LTCardMatchingGame *)game{
    if (!_game){
        self.game = [[LTCardMatchingGame alloc] initWithCardCount:NUM_CARDS
                                                        usingDeck:self.deck withType:3];
    }
    return _game;
}

- (LTDeck *)deck{
    if (!_deck) _deck = [[LTSetCardDeck alloc] init];
    return _deck;
}

- (NSMutableArray *)cardViews{
    if (!super.cardViews) super.cardViews = [[NSMutableArray alloc] init];
    return super.cardViews;
}

- (void)viewDidLayoutSubviews{
    [super.cardsGrid updateGrid:self.cardsGrid.bounds];
    [super fixTapBackToGame];
    
    int i = 0;
    for (SetCardView *cardView in self.cardViews){
        [self.cardsGrid moveCard:cardView toIndex:i];
        i++;
    }
    [self.view layoutSubviews];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)tapOnCard:(UITapGestureRecognizer *)gesture{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        SetCardView* card = (SetCardView *) gesture.view;
        card.chosen = !card.chosen;
        int index = 0;
        for (int i = 0; i < super.cardViews.count; i++){
            if (card == self.cardViews[i]){
                index = i;
            }
        }

        [_game chooseCardAtIndex:index];
        [self updateUpToGameState];
    }
}

- (IBAction)AddCards:(UIButton *)sender {
    if (self.game.cards.count > MAX_CARDS){
        return;
    }
    NSMutableArray* cardsAdded = [self.game addCards];
    __weak SetNewViewController* weakSelf = self;
    [self.cardsGrid addToGridMinimum:3];
    
    for (int i = 0; i < cardsAdded.count; i++){
        LTSetCard *card = cardsAdded[i];
        SetCardView *cardViewToAdd = [[SetCardView alloc] init];
        
        cardViewToAdd.chosen = card.chosen;
        cardViewToAdd.pattern = card.pattern;
        cardViewToAdd.amount = card.amount;
        cardViewToAdd.color = card.color;
        cardViewToAdd.shape = card.shape;
        
        [self.cardViews addObject: cardViewToAdd];
        
        [UIView animateWithDuration:1.0 delay:i *0.05 options:UIViewAnimationCurveEaseIn animations:
         ^{
             [cardViewToAdd addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(tapOnCard:)]];
             [self.cardsGrid addTheCard:cardViewToAdd WithIndex:self.game.cards.count - 3 + i];
         } completion:nil];
    }
    
    [self orginizeCards];
}

- (void)updateUpToGameState{
    BOOL resizeGrid = YES;
    for (NSInteger i = 0; i < self.game.cards.count; i++){
        LTSetCard *card = (LTSetCard*)[self.game cardAtIndex:i];
        if (card.matched){
            [super.cardsGrid kickCardView: self.cardViews[i] withBounds:self.view.bounds];
            [_game removeCardAtIndex:i];
            [super.cardViews removeObject:self.cardViews[i]];
            if (resizeGrid){
                [self.cardsGrid addToGridMinimum:-3];
                resizeGrid = NO;
            }
            [self orginizeCards];
            i--;
        }
        else if (card.chosen){
            SetCardView *cardView = self.cardViews[i];
            cardView.chosen = YES;
        }
        else{
            SetCardView *cardView = self.cardViews[i];
            cardView.chosen = NO;
        }

        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", self.game.score];
        self.clickInfo.attributedText = self.game.lastStepInfo;
    }
}

- (void)orginizeCards{
    __weak LTGridView *weakCardsGrid = self.cardsGrid;
    for(NSInteger i = 0; i < self.game.cards.count; i++){
        [UIView animateWithDuration:1.0 animations:^{
            [weakCardsGrid moveCard:self.cardViews[i] toIndex:i];
        }];
    }
}

- (void)setup
{
    __weak SetNewViewController* weakSelf = self;
    for (NSInteger i = 0; i < self.game.cards.count; i++){
        [UIView animateWithDuration:1.0 delay:i *0.05 options:UIViewAnimationCurveEaseIn animations:
         ^{
             LTSetCard *card = (LTSetCard *)[self.game cardAtIndex:i];
             SetCardView *cardViewToAdd = [[SetCardView alloc] init];

             cardViewToAdd.chosen = card.chosen;
             cardViewToAdd.pattern = card.pattern;
             cardViewToAdd.amount = card.amount;
             cardViewToAdd.color = card.color;
             cardViewToAdd.shape = card.shape;

             [weakSelf.cardViews addObject: cardViewToAdd];
             [weakSelf.cardsGrid addTheCard:cardViewToAdd WithIndex:i];
             
             super.recoTap = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(tapOnCard:)];
             [cardViewToAdd addGestureRecognizer:self.recoTap];
         } completion:nil];
    }
}
- (IBAction)Redeal:(UIButton *)sender {
    self.deck = nil;
    self.game = [[LTCardMatchingGame alloc] initWithCardCount:NUM_CARDS
                                                    usingDeck:self.deck withType:3];
    
    self.scoreLabel.text = @"Score: 0";
    self.clickInfo.attributedText = [[NSAttributedString alloc] initWithString:@""];
    [self.cardsGrid resetMinimum];
    
    for (SetCardView *cardView in self.cardViews){
        [self.cardsGrid kickCardView:cardView withBounds:self.view.bounds];
    }
    
    self.cardViews = [[NSMutableArray alloc] init];
    [self setup];
}

@end

NS_ASSUME_NONNULL_END
