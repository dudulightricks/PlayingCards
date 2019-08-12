//
//  ViewController.m
//  PlayingCards
//
//  Created by Dudo Moshe on 30/07/2019.
//  Copyright © 2019 Dudo Moshe. All rights reserved.
//

#import "OldViewController.h"

#import "Model/LTPlayingCardDeck.h"
#import "LTCardMatchingGame.h"
#import "PlayingCardView.h"

@interface OldViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *CardView;

@end

@implementation OldViewController

- (void)setup:(NSInteger) numCards{ //Abstract
}

- (void)viewDidAppear:(BOOL)animated{
    [self setup:DEFAULT_GAME_TYPE];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self setup:DEFAULT_GAME_TYPE];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        [self setup:DEFAULT_GAME_TYPE];
    }
    return self;
}

- (IBAction)touchCardButton:(UIButton *)sender{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI{ //Abstract
}

- (NSAttributedString *)titleForCard:(LTCard *) card{
    return nil;
}

- (void)resetHelper: (NSUInteger)NumCards { // Abstract
}

- (IBAction)ResetButton:(UIButton *)sender {
    [self resetHelper:self.game.gameType];
}

- (UIImage *)backgroundImageForCard:(LTCard*) card {//Abstract
    return nil;
}

- (IBAction)showHistory:(UISlider *)sender {
    if (_game.history != nil){
        NSInteger history_index = sender.value * _game.history.count;
        if (history_index > 0){
            self.clickInfo.attributedText = _game.history[history_index];
        }
        else{
            self.clickInfo.attributedText = [[NSAttributedString alloc]initWithString:@""];
        }
    }
}

@end
