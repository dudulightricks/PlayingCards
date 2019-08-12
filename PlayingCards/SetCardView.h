// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LTSetCard.h"
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : CardView

@property (nonatomic) NSUInteger amount;
@property (nonatomic) UIColor *color;
@property (nonatomic) NSString *shape;
@property (nonatomic) kPattern pattern; //strip, full or empty
@property (nonatomic) BOOL chosen;

@end

NS_ASSUME_NONNULL_END
