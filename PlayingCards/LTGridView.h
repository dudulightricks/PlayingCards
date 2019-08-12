// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Grid.h"

@class CardView;

@class PlayingCardView;

NS_ASSUME_NONNULL_BEGIN

@interface LTGridView : UIView
- (void)addTheCard: (CardView *) cardView WithIndex:(NSInteger)idx;
- (void)moveCard: (CardView *)cardView toIndex:(NSInteger)idx;
- (void)kickCardView:(CardView *)cardView withBounds:(CGRect)bounds;

- (void)updateGrid: (CGRect) bounds;
- (void)removeFromSuperview:(CardView*) cardView;
- (void)addToGridMinimum: (NSInteger) numCards;
- (void)resetMinimum;
@end

NS_ASSUME_NONNULL_END
