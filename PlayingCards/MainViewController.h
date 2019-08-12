// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LTGridView.h"
#import "LTCardMatchingGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

- (void)fixTapBackToGame;

@property UITapGestureRecognizer *recoTap;
@property (weak, nonatomic) IBOutlet LTGridView *cardsGrid;
@property (strong, nonatomic) NSMutableArray* cardViews;

@end

NS_ASSUME_NONNULL_END
