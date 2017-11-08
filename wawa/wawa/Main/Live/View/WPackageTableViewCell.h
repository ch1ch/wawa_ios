//
//  WPackageTableViewCell.h
//  wawa
//
//  Created by 唐竞皓 on 2017/11/7.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPackageTableViewCell : UITableViewCell

@property (weak, nonatomic) id package;
@property (copy, nonatomic) void(^rechargeBlock)(id package);

@end
