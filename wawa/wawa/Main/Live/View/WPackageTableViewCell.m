//
//  WPackageTableViewCell.m
//  wawa
//
//  Created by 唐竞皓 on 2017/11/7.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WPackageTableViewCell.h"
@interface WPackageTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *gameMoneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *rechargeButton;
@end

@implementation WPackageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)rechargeAction:(id)sender {
    if(self.rechargeBlock){
        self.rechargeBlock(self.package);
    }
}
- (void)setPackage:(id)package {
    _package = package;
    [self.rechargeButton setTitle:[NSString stringWithFormat:@"￥%.2f", [_package[@"price"] floatValue]] forState:UIControlStateNormal];
    [self.gameMoneyLabel setText:[NSString stringWithFormat:@"%@", _package[@"gameMoney"]]];
}
@end
