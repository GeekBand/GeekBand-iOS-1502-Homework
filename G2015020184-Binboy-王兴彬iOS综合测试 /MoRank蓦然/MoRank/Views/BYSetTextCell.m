//
//  BYSetTextCell.m
//  MoRank
//
//  Created by binglogo on 15/10/16.
//  Copyright © 2015年 Binboy. All rights reserved.
//

#import "BYSetTextCell.h"

@interface BYSetTextCell ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *textValue;
@property (nonatomic, copy) void(^textChangeBlock)(NSString *textValue);

@end

@implementation BYSetTextCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setTextValue:(NSString *)textValue andTextChangeBlock:(void (^)(NSString *))block {
    [_textField becomeFirstResponder];
    _textValue = textValue;
    _textField.text = _textValue;
    _textChangeBlock = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)textValueChanged:(UITextField *)sender {
    _textValue = sender.text;
    if (_textChangeBlock) {
        _textChangeBlock(_textValue);
    }
}

@end
