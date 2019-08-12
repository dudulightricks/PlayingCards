// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>

#import "LTCard.h"

NS_ASSUME_NONNULL_BEGIN


@interface LTPlayingCard : LTCard

+ (NSArray *)validSuits;
+ (NSInteger)maxRank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end

NS_ASSUME_NONNULL_END
