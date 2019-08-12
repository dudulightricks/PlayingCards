//
//  ViewController.h
//  PlayingCards
//
//  Created by Dudo Moshe on 30/07/2019.
//  Copyright © 2019 Dudo Moshe. All rights reserved.
//
#import "ViewController.h"

#import <UIKit/UIKit.h>

#import "Model/LTPlayingCardDeck.h"
#import "LTCardMatchingGame.h"

#define DEFAULT_GAME_TYPE 2
#define NUM_OF_CARDS 25

@interface OldViewController : UIViewController

- (NSAttributedString *)titleForCard:(LTCard*) card;
- (void)resetHelper: (NSUInteger)NumCards; // Abstract
- (UIImage *)backgroundImageForCard:(LTCard*) card; //Abstrack

//@property (nonatomic) int flipCount;
@property (nonatomic, strong) LTDeck *my_deck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) LTCardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *clickInfo;
@property (weak, nonatomic) IBOutlet UISlider *actionsHistory;

@end

