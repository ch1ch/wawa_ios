//
//  WRechargeView.m
//  wawa
//
//  Created by 唐竞皓 on 2017/11/7.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WRechargeView.h"
#import "WPackageTableViewCell.h"
#import "UIColor+Category.h"

#define kScale(x)       (x*SCREEN_WIDTH/375.0f)

@interface WRechargeView()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation WRechargeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    [self setFrame:[UIScreen mainScreen].bounds];
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WechatIMG211"]];
    [containerView setUserInteractionEnabled:YES];
    CGFloat width = 320;
    CGFloat height = 368;
    
    [containerView setFrame:CGRectMake(0, 0, width, height)];
    [containerView setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
    [self addSubview:containerView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 40, containerView.frame.size.width-30, 650.0f*containerView.frame.size.height/800.0f-50)];
//    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRowHeight:60];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    [self.tableView registerNib:[UINib nibWithNibName:@"WPackageTableViewCell" bundle:nil] forCellReuseIdentifier:@"WPackageTableViewCell"];
    [containerView addSubview:self.tableView];
    
    CGFloat y = (containerView.frame.size.height-650.0f*containerView.frame.size.height/800.0f)/2-11.5+650.0f*containerView.frame.size.height/800.0f;
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, y, 51, 23)];
    [cancel setImage:[UIImage imageNamed:@"cancal"] forState:UIControlStateNormal];
    [cancel setCenter:CGPointMake(containerView.frame.size.width/2.0f, cancel.center.y)];
    [containerView addSubview:cancel];
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (void)dismiss {
    [self removeFromSuperview];
}

- (void)setResult:(NSArray *)result {
    _result = result;
    if(_result.count>0){
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
        [header setBackgroundColor:[UIColor clearColor]];
        UIView *sep1 = [[UIView alloc] initWithFrame:CGRectMake(0, header.frame.size.height, header.frame.size.width, 1)];
        [sep1 setBackgroundColor:[UIColor customColorWithString:@"da4859"]];
        [header addSubview:sep1];
        UIView *sep2 = [[UIView alloc] initWithFrame:CGRectMake(0, header.frame.size.height-3, header.frame.size.width, 2)];
        [sep2 setBackgroundColor:[UIColor customColorWithString:@"da4859"]];
        [header addSubview:sep2];
        [self.tableView setTableHeaderView:header];
    }
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.result.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WPackageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WPackageTableViewCell" forIndexPath:indexPath];
    [cell setPackage:self.result[indexPath.row]];
    [cell setRechargeBlock:self.rechargeActionBlock];
    return cell;
}

@end
