//
//  EvaluationModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationModel : NSObject

@property (nonatomic, strong) NSString *geval_addtime;
@property (nonatomic, strong) NSString *geval_addtime_againt;
@property (nonatomic, strong) NSString *geval_addtime_again_date;
@property (nonatomic, strong) NSString *geval_addtime_date;
@property (nonatomic, strong) NSString *geval_content;
@property (nonatomic, strong) NSString *geval_content_again;
@property (nonatomic, strong) NSString *geval_explain;
@property (nonatomic, strong) NSString *geval_explain_again;
@property (nonatomic, strong) NSString *geval_frommemberid;
@property (nonatomic, strong) NSString *geval_frommembername;
@property (nonatomic, strong) NSString *geval_scores;
@property (nonatomic, strong) NSString *member_avatar;
@property (nonatomic, strong) NSMutableArray *geval_image_1024Arr;
@property (nonatomic, strong) NSMutableArray *geval_image_240Arr;


@end
