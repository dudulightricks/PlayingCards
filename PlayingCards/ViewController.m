//
//  ViewController.m
//  SuperCard
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "ViewController.h"

#import "PlayingCardView.h"
#import "LTPlayingCardDeck.h"
#import "LTPlayingCard.h"
#import "LTCardMatchingGame.h"
#import "LTGridView.h"

#define NUM_CARDS 20

@interface ViewController () <UIDynamicAnimatorDelegate>
@property (strong, nonatomic) LTPlayingCardDeck *deck;
@property (strong, nonatomic) LTCardMatchingGame* game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickInfo;
@end

@implementation ViewController

- (LTCardMatchingGame *)game{
    if (!_game){
        self.game = [[LTCardMatchingGame alloc] initWithCardCount:NUM_CARDS
                                                        usingDeck:self.deck withType:2];
    }
    return _game;
}

- (LTDeck *)deck{
    if (!_deck) _deck = [[LTPlayingCardDeck alloc] init];
    return _deck;
}

- (NSMutableArray *)cardViews{
    if (!super.cardViews) super.cardViews = [[NSMutableArray alloc] init];
    return super.cardViews;
}

- (void)viewDidLayoutSubviews
{
    [super.cardsGrid updateGrid:self.cardsGrid.bounds];
    [super fixTapBackToGame];
    
    int i = 0;
    for (PlayingCardView* cardView in self.cardViews){
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

        PlayingCardView* card = (PlayingCardView *) gesture.view;
        card.faceUp = !card.faceUp;
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

- (void)updateUpToGameState{
    for (NSInteger i = 0; i < self.game.cards.count; i++){
        LTPlayingCard* card = (LTPlayingCard*)[self.game cardAtIndex:i];
        if (card.matched){
            [super.cardsGrid kickCardView: self.cardViews[i] withBounds:self.view.bounds];
            [_game removeCardAtIndex:i];
            [super.cardViews removeObject:self.cardViews[i]];
            [self orginizeCards];
            i--;
        }
        else if (card.chosen){
            PlayingCardView* cardView = self.cardViews[i];
            cardView.faceUp = YES;
        }
        else{
            PlayingCardView* cardView = self.cardViews[i];
            cardView.faceUp = NO;
        }
        
        self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", self.game.score];
        self.clickInfo.attributedText = self.game.lastStepInfo;
    }
}

- (void)orginizeCards{
    __weak LTGridView* weakCardsGrid = self.cardsGrid;
    for(NSInteger i = 0; i < self.game.cards.count; i++){
        [UIView animateWithDuration:1.0 animations:^{
            [weakCardsGrid moveCard:self.cardViews[i] toIndex:i];
        }];
    }
}

- (void)setup
{
    __weak ViewController* weakSelf = self;
    for (NSInteger i = 0; i < self.game.cards.count; i++){
        [UIView animateWithDuration:1.0 delay:i *0.05 options:UIViewAnimationCurveEaseIn animations:
         ^{
            LTPlayingCard *card = (LTPlayingCard *)[self.game cardAtIndex:i];
            PlayingCardView *cardViewToAdd = [[PlayingCardView alloc] init];
            cardViewToAdd.suit = card.suit;
            cardViewToAdd.rank = card.rank;
            [weakSelf.cardViews addObject: cardViewToAdd];
            [weakSelf.cardsGrid addTheCard:cardViewToAdd WithIndex:i];
             
             super.recoTap = [[UITapGestureRecognizer alloc]
                              initWithTarget:self action:@selector(tapOnCard:)];
             
            [cardViewToAdd addGestureRecognizer:self.recoTap];
        } completion:nil];
    }
}
- (IBAction)Redeal:(UIButton *)sender {
    self.game = nil;
    self.deck = nil;
    self.scoreLabel.text = @"Score: 0";
    self.clickInfo.attributedText = [[NSAttributedString alloc] initWithString:@""];
    
    for (PlayingCardView *cardView in self.cardViews){
        [self.cardsGrid kickCardView:cardView withBounds:self.view.bounds];
    }
   
    self.cardViews = [[NSMutableArray alloc] init];
    [self setup];
}

@end
