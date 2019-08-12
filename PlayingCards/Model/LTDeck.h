// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTCard.h"

#import<Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface LTDeck : NSObject

- (void)addCard:(LTCard *)card atTop:(BOOL)atTop;
- (void)addCard:(LTCard *)card;
- (LTCard *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
