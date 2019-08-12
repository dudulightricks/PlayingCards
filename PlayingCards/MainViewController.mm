// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "MainViewController.h"
#import "LTGridView.h"
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController()
@property UIPinchGestureRecognizer *recoPinch;
@property UIPanGestureRecognizer *recoPan;
@end

@implementation MainViewController

- (void)setup{ // Abstract

}

- (void)orginizeCards{//Abstract
}

- (void)tapOnCard:(UITapGestureRecognizer *)gesture{//Abstract
}

- (void)panCards:(UIPanGestureRecognizer *)gesture{//Abstract
    CGPoint translatedPoint = [gesture translationInView:self.view];
    
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        [UIView animateWithDuration:0.15 animations:^{
            for (UIView *card in self.cardViews) {
                card.center =
                CGPointMake(card.center.x + translatedPoint.x,
                            card.center.y + translatedPoint.y);
            }
        }];
    [gesture setTranslation:CGPointZero inView:gesture.view];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [_cardsGrid updateGrid:self.cardsGrid.bounds];
    
    self.recoPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(onPinch:)];
    [self.view addGestureRecognizer:self.recoPinch];
    [self setup];
}

- (void)onPinch:(UITapGestureRecognizer *)gesture{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationCurveEaseIn animations:
         ^{
             for (CardView* card in self.cardViews){
                 card.center = CGPointMake(self.view.bounds.size.width / 2,
                                       self.view.bounds.size.height / 2);
             }
         } completion:nil];
        
        self.recoPan = [[UIPanGestureRecognizer alloc]
                        initWithTarget:self action:@selector(panCards:)];
        self.recoTap =[[UITapGestureRecognizer alloc]
                       initWithTarget:self action:@selector(tapToSplit:)];
        for (CardView* card in self.cardViews){
            [card removeGestureRecognizer:self.recoTap];
            [card addGestureRecognizer:self.recoTap];
            [card addGestureRecognizer:self.recoPan];
        }
    }
}

- (void)tapToSplit:(UITapGestureRecognizer *)gesture{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        
        [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationCurveEaseIn animations:
         ^{
             [self orginizeCards];
         } completion:^(BOOL finished)
         {
             [self fixTapBackToGame];
         }];
    }
}

- (void)fixTapBackToGame{
    self.recoTap = [[UITapGestureRecognizer alloc]
                    initWithTarget:self action:@selector(tapOnCard:)];
    for (CardView* card in self.cardViews){
        [card removeGestureRecognizer:self.recoPan];
        [card removeGestureRecognizer:self.recoTap];
        [card addGestureRecognizer:self.recoTap];
    }
}

@end

NS_ASSUME_NONNULL_END
