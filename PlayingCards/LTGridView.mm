// Copyright (c) 2019 Lightricks. All rights reserved.
// Created by Dudo Moshe.

#import "LTGridView.h"

#import "CardView.h"

#define EDGE 2

@interface LTGridView()

@property (nonatomic) Grid* cardGrid;
@end

NS_ASSUME_NONNULL_BEGIN

@implementation LTGridView

- (void)setup{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (Grid *)cardGrid{
    if (!_cardGrid){
        _cardGrid = [[Grid alloc] init];
        _cardGrid.cellAspectRatio = (float)9/16;
        _cardGrid.minimumNumberOfCells = 20;
    }
    return _cardGrid;
}

- (void)updateGrid: (CGRect) bounds{
    NSInteger num = _cardGrid.minimumNumberOfCells;
    _cardGrid = [[Grid alloc] init];
    _cardGrid.size = bounds.size;
    _cardGrid.cellAspectRatio = (float)9/16;
    if(num > 10)
        _cardGrid.minimumNumberOfCells = num;
    else
        _cardGrid.minimumNumberOfCells = 20;
}

- (void)addToGridMinimum: (NSInteger) numCards{
    _cardGrid.minimumNumberOfCells += numCards;
    if(self.cardGrid.inputsAreValid)
        return;
}

- (void)resetMinimum{
    _cardGrid.minimumNumberOfCells = 20;
    if(self.cardGrid.inputsAreValid)
        return;
}

- (void)addTheCard: (CardView *)cardView WithIndex:(NSInteger)idx{
    CGRect frame = [self.cardGrid frameOfCellAtRow:idx / self.cardGrid.columnCount
                                          inColumn:idx % self.cardGrid.columnCount];
    cardView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width - 2,
                                frame.size.height - 2);
//    CGRectInset(<#CGRect rect#>, <#CGFloat dx#>, <#CGFloat dy#>)
    cardView.center = [self.cardGrid centerOfCellAtRow:idx / self.cardGrid.columnCount
                                              inColumn:idx % self.cardGrid.columnCount];
    [self addSubview:cardView];
}

- (void)moveCard: (CardView *)cardView toIndex:(NSInteger)idx{
    CGRect frame = [self.cardGrid frameOfCellAtRow:idx / self.cardGrid.columnCount
                                          inColumn:idx % self.cardGrid.columnCount];
    cardView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width - EDGE,
                                frame.size.height - EDGE);
    cardView.center = [self.cardGrid centerOfCellAtRow:idx / self.cardGrid.columnCount
                                              inColumn:idx % self.cardGrid.columnCount];
}

- (void)kickCardView:(CardView *)cardView withBounds:(CGRect)bounds{
    [UIView animateWithDuration:1.0 animations:^{
        int x = (arc4random()%(int)(bounds.size.width * 5)) - (int)bounds.size.width * 2;
        int y = bounds.size.height;
        cardView.center = CGPointMake(x, -y);
    } completion:^(BOOL finished) {
        [cardView removeFromSuperview];
        //[self willRemoveSubview:cardView];
    }];
}

@end

NS_ASSUME_NONNULL_END
