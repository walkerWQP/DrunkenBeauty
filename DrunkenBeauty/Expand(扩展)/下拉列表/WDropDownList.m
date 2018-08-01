//
//  WDropDownList.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "WDropDownList.h"

@interface WDropDownList ()<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,assign)CGFloat rowHeight;   // 行高
@property(nonatomic,strong)UIButton *button;    //从Controller传过来的控制器
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,assign)NSInteger index;    //记录选中行

@end


@implementation WDropDownList

-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v {
    self = [super initWithFrame:CGRectMake(0, 0, WWidth, WHeight)];
    if (self) {
        self.arr = array;
        self.rowHeight = rowHeight;
        self.button = (UIButton *)v;
    }
    return self;
}
-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WWidth, WHeight)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _bgView;
}
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WWidth, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSArray *)arr {
    if (!_arr) {
        _arr = [[NSArray alloc]init];
    }
    return _arr;
}
-(UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 20, 20)];
        _arrow.image = [UIImage imageNamed:@"选中"];
    }
    return _arrow;
}
/**
 *   显示下拉列表
 */
-(void)showList {
    [self addSubview:self.bgView];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 1;
        self.tableView.frame = CGRectMake(0, 0, WWidth, self.rowHeight * self.arr.count);
    }];
}
/**
 *  隐藏
 */
-(void)hiddenList {
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 0;
        self.tableView.frame = CGRectMake(0, 0, WWidth, 0);
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
    }];
}
#pragma mark - UITableViewDelegateAndUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.arr[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    
    if (self.index == indexPath.row) {
        if ([cell.textLabel.text isEqualToString:self.button.titleLabel.text]) {
            [cell addSubview:self.arrow];
        }
    }
    
    return cell;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark ----------------UITableView  表的选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenList];
    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(dropDownListParame:)]) {
        [self.delegate dropDownListParame:self.arr[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}



@end
