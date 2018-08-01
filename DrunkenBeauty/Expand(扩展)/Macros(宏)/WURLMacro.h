//
//  WURLMacro.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef WURLMacro_h
#define WURLMacro_h

//所有接口以及拼接

//服务接口
#define HostUrl @ "http://www.zuimei666.top"
//"http://www.mayuanfang.top"
//"http://www.zuimei999.com"
//"http://www.mayuanfang.top"

//首页接口
#define HomeHurl HostUrl @"/mo_bile/index.php?app=index"

/*
 分类
*/

#define GoodsClassUrl HostUrl @"/mo_bile/index.php?app=goods_class"

/*
 商品类型  ---搜索界面跳转到详情界面接口
 */

#define RecommendLiatUrl HostUrl @"/mo_bile/index.php?app=brand"
/*
 销量优先接口 数据
 */
#define SalesUrl HostUrl @"/mo_bile/index.php?app=goods"


/*
 搜索界面 数据
*/
#define searchUrl HostUrl @"/mo_bile/index.php?app=index"
                            
/*
 商品收藏 数据
 */
#define favoritesUrl HostUrl @"/mo_bile/index.php?app=member_favorites"

/*
 注册页面获取codekeyURL
 */
#define seccodeUrl HostUrl @"/mo_bile/index.php?app=seccode"

/*
 获取验证码URL
 */
#define connectUrl HostUrl @"/mo_bile/index.php?app=connect"


/*
 登录接口
 */
#define loginUrl HostUrl @"/mo_bile/index.php?app=login"


/*
 我的订单
 */
#define memberOrderUrl HostUrl @"/mo_bile/index.php?app=member_order"

/*
 评价订单
 */
#define memberEvaluateUrl HostUrl @"/mo_bile/index.php?app=member_evaluate"

/*
 预存款余额
 */
#define memberIndexUrl HostUrl @"/mo_bile/index.php?app=member_index"

/*
 账户余额
 */
#define memberFundUrl HostUrl @"/mo_bile/index.php?app=member_fund"

/*
 领取代金券
 */
#define memberVoucherUrl HostUrl @"/mo_bile/index.php?app=member_voucher"

/*
 积分明细
 */
#define memberPointsUrl HostUrl @"/mo_bile/index.php?app=member_points"

/*
 地址管理
 */

#define memberAddressUrl HostUrl @"/mo_bile/index.php?app=member_address"

/*
 三级地市选择
 */
#define appAreaUrl HostUrl @"/mo_bile/index.php?app=area"

/*
 获取用户手机号
 */
#define memberAccountUrl HostUrl @"/mo_bile/index.php?app=member_account"

/*
 用户反馈
 */
#define memberFeedbackUrl HostUrl @"/mo_bile/index.php?app=member_feedback"

/*
 判断是否签到
 */
#define memberSigninUrl HostUrl @"/mo_bile/index.php?app=member_signin"

/*
 店铺街列表数据
 */
#define appStoreUrl HostUrl @"/mo_bile/index.php?app=store"

/*
 浏览记录  /mo_bile/index.php?app=member_goodsbrowse
 */
#define memberGoodsBrowseUrl HostUrl @"/mo_bile/index.php?app=member_goodsbrowse"


#endif /* WURLMacro_h */
