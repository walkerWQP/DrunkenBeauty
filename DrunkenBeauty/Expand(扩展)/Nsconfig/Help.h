//
//  Help.h
//  JMT
//
//  Created by walker on 2017/4/20.
//  Copyright © 2017年 walker. All rights reserved.
//

//#import "OpenUDID.h"
//#import "IPAddress.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVBase.h>
#import <Foundation/Foundation.h>
#import <CoreMedia/CMTime.h>
#import <CoreMedia/CMTimeRange.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import <AdSupport/AdSupport.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudioKit/CoreAudioKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVBase.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioFile.h>
#import <Availability.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


enum{
    ACTIONSHEET_SEX,
    ACTIONSHEET_BIRTHDAY,
    ACTIONSHHET_PHOTO
};
/**
 *  @brief 简单的方法
 */

@interface Help : NSObject

/**
 过滤字符串中的html标签
 
 @param htmlString 字符串
 @return 过滤后的字符串
 */
- (NSString *)flateHtmlString:(NSString *)htmlString;


+(Help *)sharedInstance;
/**
 *  简单警告提示,手动消失,不在响应其他事件
 */
+(void)showAlertTitle:(NSString *)Title message:(NSString *)message cancel:(NSString *)cancel;
/**
 *  简单警告提示,自动消失
 */
+(void)showAlertTitle:(NSString *)text forView:(UIView *)view;
//+ (void)addCancelBtn:(NSString *)content Cancel:(void(^)(NSString *rr))CancelClick;
+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;


/**
 *  获得当前系统时间 返回时间的字符串
 */

/**
 *  返回当前时间
 *
 *   返回时间的格TimeStyle例如:@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 当前时间的字符串
 */
+(NSString *)getCurrentTime:(NSString *)TimeStyle;
//1970以来的毫秒数
+(NSString *)getCurrentTime;

FOUNDATION_EXPORT NSString *DocumentsPath();

+ (NSString *)NSHomeDirectoryPath;
/**
 * 获得Documents路径
 */
+(NSString *)getDocumentsPath ;
/**
 * 获得Caches缓存文件路径
 */
+(NSString *)getCachesPath;
/**
 * 获得Librarys缓存文件路径
 */
+(NSString *)getLibrarysPath;
/**
 *  程序退出后此路径下的东西消失
 */
+(NSString *)getTempPath;
/**
 *  返回一个路径，如果没有的话创建这个路径
 *
 */
+ (NSString *)CreateFileAtPath:(NSString *)filePath
                       Success:(void(^)())Success
                         Error:(void(^)(int error))error;
/**
 *  @brief 获得指定目录下的，指定后缀名称的文件列表 2015.2.25
 *
 *  @param type    文件后缀名称 如: png
 *  @param dirPath 指定目录
 *
 *  @return 文件名称列表
 */
+(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath;

/**
 * 判断文件或者路径是否存在
 */
+ (BOOL)isFileExists:(NSString *)filepath;
/**
 *  播放提示音 传入提示声文件名称(不加后缀名) wav格式 提示声时长建议不超过30秒
 */
+ (void)PlayBeep:(NSString *)Soundfilename;
/**
 *  保存图片到doucment
 */
+ (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName;
+ (NSString *) getUploadFileBasePath;

/**
 *  返回Documents下指定文件名称 路径
 */
+ (NSString *) readDocumentsWithFileName:(NSString *)fileName;
/**
 *  获取文件大小，不是文件夹
 */
+ (float)fileSizeAtPath:(NSString*) filePath;

/**
 *  压缩视频，效率有点儿慢
 */
//+ (void)videoCompressQualityWithInputUrl:(NSURL *)inputUrl
//                               outputUrl:(NSURL *)outputUrl
//                            blockHandler:(void(^)(AVAssetExportSession *session))handler;

#pragma mark camera utility
+ (BOOL) isCameraAvailable;

+ (BOOL) isRearCameraAvailable;

+ (BOOL) isFrontCameraAvailable ;

+ (BOOL) doesCameraSupportTakingPhotos ;

+ (BOOL) isPhotoLibraryAvailable;
+ (BOOL) canUserPickVideosFromPhotoLibrary;
+ (BOOL) canUserPickPhotosFromPhotoLibrary;

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;

// 应用在app store上的ID
#define kAppIDInAppStore    @"" // 发布以后才有APP ID
#define kAppStoreVersionKey @"AppStoreVersionKey"

/*!
 * @brief 通用辅助扩展类
 * @author huangyibiao
 */

// 把对象转换成JSON格式数据，如果转换失败，返回nil
+ (NSMutableData *)JSONDataWithObject:(id)object;

//! 保存应用在AppStore上版本到本地
+ (void)saveAppStoreVersionToUserDefaults;

//! 是否需要连网更新
+ (BOOL)isAppNeedToUpdate:(BOOL)needNetwork;

// 参数是要判断的应用的URLSchemes
+ (BOOL)hadInstallApp:(NSString *)urlSchemes;
// 能否打开应用
+ (BOOL)canOpenApp:(NSString *)itunesUrlString;
// 打开自己开发的应用
+ (void)openApp:(NSString *)urlSchemes;
//! 进入AppStore
+ (void)goToAppStoreWithURLString:(NSString *)itunesUrlString;



#pragma mark - [唯一标示]

/**
 *  获得的这个CFUUID值系统并没有存储。每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。
 */
+(NSString *)getCFUUID;
/**
 *  NSUUID在iOS 6中才出现，这跟CFUUID几乎完全一样，只不过它是Objective-C接口。+ (id)UUID 是一个类方法，调用该方法可以获得一个UUID。通过下面的代码可以获得一个UUID字符串：
 */
+(NSString *)getNSUUID;
/**
 *  广告标识符   跟CFUUID和NSUUID不一样，广告标示符是由系统存储着的。不过即使这是由系统存储的，但是有几种情况下，会重新生成广告标示符。如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成。另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成。关于广告标示符的还原，有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。之所以会这样，我猜测是由于ASIdentifierManager是一个单例。
 */
//导入AdSupport.framework
+(NSString *)getADID;
/**
 *  供应商标识符，当CFBundleIdentifier（反转DNS格式）的前两部分。例如，com.apple.app1 和 com.apple.app2 得到的identifierForVendor是相同的，因为它们的CFBundleIdentifier 前两部分是相同的.当重新安装此供应商的应用时 标识符会被重置
 */
+(NSString *)getVDID;
/**
 *  开放标识符  OpenUDID利用了一个非常巧妙的方法在不同程序间存储标示符 — 在粘贴板中用了一个特殊的名称来存储标示符。通过这种方法，别的程序（同样使用了OpenUDID）知道去什么地方获取已经生成的标示符（而不用再生成一个新的）。
 */
//+(NSString *)getOpenUDID;


#pragma mark - [获得--IP]
/**
 *  获得设备IP，如果在内网中，获得的就是内网IP.
 */
//+(NSString *)getDeviceIPAdress;

#pragma mark - [获得-Mac地址]
+ (NSString *)getMacAddress;
@end

@interface NSData(AES256)
/**
 *  加密
 */
-(NSData *) aes256_encrypt:(NSString *)key;
/**
 *  解密
 */
-(NSData *) aes256_decrypt:(NSString *)key;
@end



//{"app_key":"123456","app_version":23,"crc":"9aaed55c4fb11a6fe1e8e4889cf4255d","imei":"866479025834515","os":"android","os_version":"5.0.2","time_stamp":"20150724151823","uid":"-1","ver":"0.9"}

#pragma mark - [获得设备基本信息]
@interface DeviceInformation : NSObject
/**手机的别名 如: 依文*/
@property (nonatomic, copy) NSString *Name;
/**系统版本号*/
@property (nonatomic, copy) NSString *os_version;
/**系统名称 iPhone os */
@property (nonatomic, copy) NSString *os;
/**当前软件的版本号*/
@property (nonatomic, copy) NSString *app_version;
/**返回设备类型 iPhone ipad*/
@property (nonatomic, copy) NSString *DeviceModel;
/**返回系统名称 以及系统版本号 iPhone os 8.2 */
@property (nonatomic, copy) NSString *OS_Version;
+(instancetype)sharedInstance;
@end


@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end


@interface UITextField (exc)


@end
@interface NSString (exc)
/**
 *  校验车牌号 后五位
 */
- (BOOL) isValidateCarNo;


-(BOOL)isNullOrEmpty;
/**
 *  判断字符串是否空
 */
+(BOOL)isNullOrEmpty:(NSString *)string;

//! 是否是合法有效的18位身份证号码
- (BOOL)isValidPersonID;

/**
 *  判断字符串是否有空格
 *
 *  @return 有空格返回yes，否则返回NO
 */
-(BOOL)isSpacesExists;
/**
 *  判断字符串是否含有除字母下划线数字以外的字符
 *
 *  @return 有返回yes，否则返回NO
 */
-(BOOL)isSpecialCharacters;
/**
 *  判断是否为合法的手机号
 *
 *
 *  @return 是返回YES,否则返回NO
 */
+ (BOOL)isMobileNumber:(NSString *)string;

+(BOOL)isName:(NSString*)str;

//根据图片的大小限定在limitToSize的宽高内，进行等比例压缩返回图片
+(UIImage *)imageCompress:(UIImage *)image limitToSize:(CGSize)lsize;
+ (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName;
/**
 *  根据身份证判断性别
 */
+ (NSString *)sexStrFromIdentityCard: (NSString *)numberStr;


@end
