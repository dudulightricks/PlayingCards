// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Card Game object in the playing cards game.
@interface LTCard : NSObject

// Card content.
@property (strong, nonatomic) NSAttributedString *contents;

// Did the card chosen.
@property (nonatomic) BOOL chosen;

// Is the card match.
@property (nonatomic) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end

NS_ASSUME_NONNULL_END
