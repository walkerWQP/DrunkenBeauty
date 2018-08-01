//
//  classModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface classModel : NSObject

//获取酱香型/纯酿酱香型

//gc_id
@property (nonatomic, strong) NSString *gcID;

//gc_name
@property (nonatomic, strong) NSString *gcName;

//child 数组
@property (nonatomic, strong) NSMutableArray *childArr;


@end
