//
//  BYTextView.m
//  HelloNote
//
//  Created by binglogo on 15/9/17.
//  Copyright (c) 2015年 Binboy. All rights reserved.
//

#import "BYTextView.h"

@implementation BYTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.hasText) {
        return;
    }
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = rect.size.width - 2 * x;
    CGFloat height = rect.size.height - 2 * y;
    CGRect placeHolderRect = CGRectMake(x, y, width, height);
    
    NSMutableDictionary *attrsDict = [NSMutableDictionary dictionary];
    attrsDict[NSFontAttributeName] = self.font;
    attrsDict[NSForegroundColorAttributeName] = self.placeHolderColor;
    
    [self.placeHolder drawInRect:placeHolderRect withAttributes:attrsDict];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textViewDidChange {
    [self setNeedsDisplay];
}
// 重写各个setter，以便刷新界面
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

@end
