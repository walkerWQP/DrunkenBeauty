//
//  WContentView.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "WContentView.h"

@implementation WContentView

-(instancetype) initWithFrame:(CGRect)frame dataArr:(NSArray *)array{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        for (int i = 0; i < array.count; i ++)
        {
            //        Area *are = cell_Array[i];
            
            NSString *name = array[i];
            static UIButton *recordBtn =nil;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            
            CGRect rect = [name boundingRectWithSize:CGSizeMake(self.frame.size.width -20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
            
            CGFloat BtnW = rect.size.width + 20;
            CGFloat BtnH = rect.size.height + 10;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = BtnH/2;
            if (i == 0) {
                NSLog(@"%f",BtnW);
                NSLog(@"%f",BtnH);
                btn.frame =CGRectMake(10, 10, BtnW, BtnH);
            }
            else{
                
                CGFloat yuWidth = self.frame.size.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
                
                if (yuWidth >= rect.size.width) {
                    
                    btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
                }else{
                    
                    btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
                }
                
            }
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:name forState:UIControlStateNormal];
            [self addSubview:btn];
            
            NSLog(@"btn.frame.origin.y  %f", btn.frame.origin.y);
            self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 20,CGRectGetMaxY(btn.frame)+10);
            recordBtn = btn;
            
            btn.tag = 100 + i;
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    return self;
    
}

-(void) BtnClick:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.btnBlock) {
        
        weakSelf.btnBlock(sender.tag);
    }
    
}

-(void) btnClickBlock:(BtnBlock)btnBlock{
    
    self.btnBlock = btnBlock;
    
}

@end
