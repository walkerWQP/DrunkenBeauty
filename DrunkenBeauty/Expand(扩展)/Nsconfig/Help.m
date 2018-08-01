//
//  Help.m
//  JMT
//
//  Created by walker on 2017/4/20.
//  Copyright © 2017年 walker. All rights reserved.
//

#import "Help.h"

@interface Help()<UIAlertViewDelegate>

@end


@implementation Help
+(Help *)sharedInstance
{
    static Help *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[super allocWithZone:nil] init];
    });
    return instance;
}
//allocWithZone是创建对象分配内存的源头，alloc也会调用该接口来分配内存创建对象。
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedInstance];
}


- (NSString *)flateHtmlString:(NSString *)htmlString
{
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:htmlString];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        htmlString = [htmlString stringByReplacingOccurrencesOfString:
                      [ NSString stringWithFormat:@"%@>", text]
                                                           withString:@" "];
        
    } // while //
    
    return htmlString;
}


#pragma mark - [简单提示]
+(void)showAlertTitle:(NSString *)Title message:(NSString *)message cancel:(NSString *)cancel{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:Title
                                                   message:message
                                                  delegate:nil
                                         cancelButtonTitle:cancel
                                         otherButtonTitles:nil];
    [alert show];
}

+(void)showAlertTitle:(NSString *)text forView:(UIView *)view
{
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 50)];
    lab.backgroundColor = [UIColor colorWithWhite:0.185 alpha:1.000];
    lab.numberOfLines=0;
    CGPoint point = view.center;
    lab.center = point;
    lab.layer.masksToBounds = YES;
    lab.layer.cornerRadius = 10;
    lab.alpha = 0;
    lab.text = text;
    lab.font = [UIFont systemFontOfSize:14.0f];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    
    [UIView animateWithDuration:1.5 animations:^{
        lab.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            lab.alpha = 0;
        }completion:^(BOOL finished) {
            [lab removeFromSuperview];
        }];
    }];
}
#pragma mark - [播放提示音]
+ (void)PlayBeep:(NSString *)Soundfilename
{
    //声音
    //需要导入框架#import <AudioToolbox/AudioToolbox.h>
    NSString *path = [[NSBundle mainBundle] pathForResource:Soundfilename ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //加载音效文件，创建音效ID（SoundID,一个ID对应一个音效文件）
    SystemSoundID soundId=0;
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundId);
    if (err) {
        NSLog(@"Error occurred assigning system sound!");
        return ;
    }
    /*添加音频结束时的回调*/
    AudioServicesAddSystemSoundCompletion(soundId, NULL, NULL, SoundFinished,(__bridge void *)(url));
    //    SoundFinished(soundId, (__bridge void *)(url));
    /*开始播放,下面的两个函数都可以用来播放音效文件，第一个函数伴随有震动效果*/
    //AudioServicesPlayAlertSound(soundID);
    AudioServicesPlaySystemSound(soundId);
    CFRunLoopRun();
}
//当音频播放完毕会调用这个函数
static void SoundFinished(SystemSoundID soundID,void* sample){
    /*播放全部结束，因此释放所有资源 */
    AudioServicesDisposeSystemSoundID((UInt32)sample);
    NSLog(@"AudioServicesDisposeSystemSoundID");
    CFRelease(sample);
    CFRunLoopStop(CFRunLoopGetCurrent());
}

+(NSString *)getCurrentTime:(NSString *)TimeStyle
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:TimeStyle];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}
+(NSString *)getCurrentTime
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue]; // 将double转为long long型
    return [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型
    
}
NSString *DocumentsPath(){
    return [Help getDocumentsPath];
}
#pragma mark - [获得--IP]
//+(NSString *)getDeviceIPAdress {
//    InitAddresses();
//    GetIPAddresses();
//    GetHWAddresses();
//    return [NSString stringWithFormat:@"%s", ip_names[1]];
//}

#pragma mark - [获得-Mac地址]
+ (NSString *) getMacAddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

#pragma mark - [唯一标示]

/**
 *  获得的这个CFUUID值系统并没有存储。每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。
 */
+(NSString *)getCFUUID
{
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    return cfuuidString;
    //    //    方法一：
    //    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    //    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    //    NSString * result =(__bridge  NSString *)string;
    //    CFRelease(theUUID);
    //    CFRelease(string);
}
/**
 *  NSUUID在iOS 6中才出现，这跟CFUUID几乎完全一样，只不过它是Objective-C接口。+ (id)UUID 是一个类方法，调用该方法可以获得一个UUID。通过下面的代码可以获得一个UUID字符串：
 */
+(NSString *)getNSUUID
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}
/**
 *  广告标识符   跟CFUUID和NSUUID不一样，广告标示符是由系统存储着的。不过即使这是由系统存储的，但是有几种情况下，会重新生成广告标示符。如果用户完全重置系统（(设置程序 -> 通用 -> 还原 -> 还原位置与隐私) ，这个广告标示符会重新生成。另外如果用户明确的还原广告(设置程序-> 通用 -> 关于本机 -> 广告 -> 还原广告标示符) ，那么广告标示符也会重新生成。关于广告标示符的还原，有一点需要注意：如果程序在后台运行，此时用户“还原广告标示符”，然后再回到程序中，此时获取广告标示符并不会立即获得还原后的标示符。必须要终止程序，然后再重新启动程序，才能获得还原后的广告标示符。之所以会这样，我猜测是由于ASIdentifierManager是一个单例。
 */
//导入AdSupport.framework
+(NSString *)getADID
{
    NSString *adid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return adid;
}
/**
 *  供应商标识符，当CFBundleIdentifier（反转DNS格式）的前两部分。例如，com.apple.app1 和 com.apple.app2 得到的identifierForVendor是相同的，因为它们的CFBundleIdentifier 前两部分是相同的.当重新安装此供应商的应用时 标识符会被重置
 */
+(NSString *)getVDID
{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return idfv;
}
/**
 *  开放标识符  OpenUDID利用了一个非常巧妙的方法在不同程序间存储标示符 — 在粘贴板中用了一个特殊的名称来存储标示符。通过这种方法，别的程序（同样使用了OpenUDID）知道去什么地方获取已经生成的标示符（而不用再生成一个新的）。
 */
//+(NSString *)getOpenUDID
//{
//    return [OpenUDID value];
//}

+(NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{
    
    NSArray *fileList = [[[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil]
                         
                         pathsMatchingExtensions:[NSArray arrayWithObject:type]];
    
    
    return fileList;
    
}

/**
 *  获得此Directory下所有文件名
 */
+ (NSArray *)getAllFileAtPath:(NSString *)filePath
{
    NSFileManager *fileManage = [NSFileManager defaultManager];
    //    NSArray *file = [fileManage subpathsOfDirectoryAtPath:filePath error:nil];//作用同下
    NSArray *files = [fileManage subpathsAtPath:filePath];
    return files;
}
/**
 * 判断文件是否存在
 */
+ (BOOL)isFileExists:(NSString *)filepath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filepath];
}

+ (NSString *)CreateFileAtPath:(NSString *)filePath Success:(void(^)())Success Error:(void(^)(int error))error{
    //查找文件，如果不存在，就创建一个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![self isFileExists:filePath]){
        if ([fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil]){
            Success();
            return filePath;
        }
        else{
            //失败
            error(0);
        }
    }
    return filePath;
}

#pragma mark - [获取文件大小]
+ (float) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/(1024.0*1024);;
    }
    return 0;
}

#pragma mark - [延时回调]
+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
}
+ (void)fireBlockAfterDelay:(void (^)(void))block
{
    block();
}
//-(IBAction) CreateFile
//{
//    //对于错误信息
//    NSError *error;
//    // 创建文件管理器
////    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    NSFileManager *fileManager = [[NSFileManager alloc]init];
//
//    //指向文件目录
//
//    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    //创建一个目录
//    [[NSFileManager defaultManager] createDirectoryAtPath: [NSString stringWithFormat:@"%@/myFolder", NSHomeDirectory()] attributes:nil];
//    // File we want to create in the documents directory我们想要创建的文件将会出现在文件目录中
//    // Result is: /Documents/file1.txt结果为：/Documents/file1.txt
//
//    NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"file2.txt"];
//    //需要写入的字符串
//    NSString *str= @"iPhoneDeveloper Tips\nhttps://iPhoneDevelopTips,com";
//    //写入文件
//    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
//    //显示文件目录的内容
//    NSLog(@"Documentsdirectory: %@",[fileManager contentsOfDirectoryAtPath:documentsDirectory error:&error]);
//}

/**
 *  压缩视频
 *
 *  @param inputUrl  视频输入地址
 *  @param outputUrl 视频输出地址
 *  @param handler   压缩完毕回调
 */
+ (void)videoCompressQualityWithInputUrl:(NSURL *)inputUrl
                               outputUrl:(NSURL *)outputUrl
                            blockHandler:(void(^)(AVAssetExportSession *session))handler
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputUrl options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    //    [[NSFileManager defaultManager] removeItemAtURL:outputUrl error:nil];
    session.outputURL = outputUrl;
    session.outputFileType = AVFileTypeMPEG4;
    
    [session exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (session.status) {
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             default:
                 break;
         }
         handler(session);
     }];
    
}

#pragma mark - [获得路径]

+ (NSString *)NSHomeDirectoryPath
{
    NSString *path = NSHomeDirectory();
    return path;
}
/**
 * 获得Documents路径
 */
+(NSString *)getDocumentsPath {
    NSString *DocumentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return DocumentPath;
}
/**
 * 获得Caches缓存文件路径
 */
+(NSString *)getCachesPath{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return path;
}
/**
 * 获得Librarys缓存文件路径
 */
+(NSString *)getLibrarysPath{
    NSArray *LibrarysPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path=[LibrarysPaths objectAtIndex:0];
    return path;
}

//程序退出后此路径下的东西消失
+(NSString *)getTempPath{
    NSString *path = NSTemporaryDirectory();
    return path;
}

#pragma mark - /*****************************ui******************[分割线]*****************************************************/

+(NSString *)CreateFileAtPath:(NSString *)filePath fileName:(NSString *)name
{
    
    NSString *testPath = [filePath stringByAppendingPathComponent:name];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *string = @"写入内容，write String";
    [fileManager createFileAtPath:testPath contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    return nil;
}
#pragma mark - 获取JSON数据
// 把对象转换成JSON格式数据，如果转换失败，返回nil
+ (NSMutableData *)JSONDataWithObject:(id)object {
    NSMutableData *postBodyData = nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        NSError *error = nil;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:object
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        if (error) {
            NSLog(@"error: %@", error.description);
        } else {
            postBodyData = [[NSMutableData alloc] initWithData:postData];
        }
    }
    return postBodyData;
}

#pragma mark - 获取最新版本
+ (NSString *)obtainLatestAppVersion {
    // NSString *urlPath = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", kAppIDInAppStore];
    NSString *latestVersion = nil;
    NSDictionary *jsonData = nil; // 这里需要从网络请求到，这里只是写成nil，在发布后再实现
    NSArray *infoArray = [jsonData objectForKey:@"results"];
    if([infoArray count] > 0) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        latestVersion = [releaseInfo objectForKey:@"version"];
        
        // 在以前返回的值是如下格式："4.0"，后来变成了："V4.0",所以需要去掉非数值字符。
        latestVersion = [latestVersion stringByTrimmingCharactersInSet:[NSCharacterSet letterCharacterSet]];
    }
    
    return latestVersion;
}

#pragma mark - 保存应用在AppStore上的版本号到本地
+ (void)saveAppStoreVersionToUserDefaults {
    NSString *storeVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kAppStoreVersionKey];
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    // 应用当前的version，应该小于等于store上的version。如果不是，则说明应用升级后，
    // UserDefault中保存的store version未更新，需重新设。
    if(nil == storeVersion || [self version:bundleVersion isBiggerThan:storeVersion])
    {
        storeVersion = [self obtainLatestAppVersion]; // 获取最新的版本
        if (storeVersion) {
            [[NSUserDefaults standardUserDefaults] setObject:storeVersion forKey:kAppStoreVersionKey];
        }
    }
    return;
    
}

#pragma mark - 是否需要更新应用
+ (BOOL)isAppNeedToUpdate:(BOOL)needNetwork {
    NSString *version = nil;
    if (needNetwork) { // 获取应用在appStore上的版本
        version = [self obtainLatestAppVersion];
        if (version) { // 保存到本地
            [[NSUserDefaults standardUserDefaults] setObject:version forKey:kAppStoreVersionKey];
        }
    } else { // 直接从本地获取
        version = [[NSUserDefaults standardUserDefaults] stringForKey:kAppStoreVersionKey];
    }
    
    if (!version) {
        return NO;
    }
    
    NSString *bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if ([self version:version isBiggerThan:bundleVersion]) {
        return YES;
    }
    return NO;
}

+ (BOOL)version:(NSString *)versionA isBiggerThan:(NSString *)versionB {
    NSArray *a = [versionA componentsSeparatedByString:@"."];
    NSArray *b = [versionB componentsSeparatedByString:@"."];
    
    unsigned aa = [[a objectAtIndex:0] intValue];
    unsigned ab = [a count] > 1 ? [[a objectAtIndex:1] intValue] : 0;
    unsigned cc = [a count] > 2 ? [[a objectAtIndex:2] intValue] : 0;
    
    unsigned ba = [[b objectAtIndex:0] intValue];
    unsigned bb = [b count] > 1 ? [[b objectAtIndex:1] intValue] : 0;
    unsigned bc = [b count] > 2 ? [[b objectAtIndex:2] intValue] : 0;
    
    return ((aa > ba) || (aa == ba && ab > bb) || (aa == ba && ab == bb && cc > bc));
}

// 参数是要判断的应用的URLSchemes
+ (BOOL)hadInstallApp:(NSString *)urlSchemes {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]]) {
        return YES;
    }
    return NO;
}

// 能否打开应用
+ (BOOL)canOpenApp:(NSString *)itunesUrlString {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:itunesUrlString]]) {
        return YES;
    }
    return NO;
}

+ (void)openApp:(NSString *)urlSchemes {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlSchemes]];
    return;
}

#pragma mark - 进入AppStore应用
+ (void)goToAppStoreWithURLString:(NSString *)itunesUrlString {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"虚拟机不支持APP Store.打开iTunes不会有效果。");
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesUrlString]];
#endif
    return;
}

#pragma mark - - [读取文件]

//读取工程文件
+(NSString *) ProductPath:(NSString*)filename{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@""];
    return  path;
}

#pragma mark camera utility
+ (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

+ (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
+ (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}


#pragma mark - [写入文件]

#pragma mark 保存图片至沙盒
+ (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

+ (NSString *) getUploadFileBasePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath=[paths objectAtIndex:0];
    basePath=[basePath stringByAppendingPathComponent:@"uploadfile"];
    if(![NSFileManager.defaultManager fileExistsAtPath:basePath])
    {
        [NSFileManager.defaultManager createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return basePath;
}


/**
 *  返回Documents下指定文件名称 路径
 */
+ (NSString *) readDocumentsWithFileName:(NSString *)fileName
{
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
    return fullPath;
}

//写入文件存放到工程位置NSDictionary
+(void)saveNSDictionaryForProduct:(NSDictionary *)list  FileUrl:(NSString*) FileUrl{
    NSString *ProductPath =[[NSBundle mainBundle]  resourcePath];
    NSString *f=[ProductPath stringByAppendingPathComponent:FileUrl];
    [list writeToFile:f atomically:YES];
}

@end


@implementation NSData (AES256)
/**
 *  //加密
 *
 */
- (NSData *)aes256_encrypt:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

/**
 *  //解密
 *
 */
- (NSData *)aes256_decrypt:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}
@end



@implementation DeviceInformation
- (NSString *)Name
{
    return [[UIDevice currentDevice] name];
}
- (NSString *)SysVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
- (NSString *)SysName
{
    return [[UIDevice currentDevice] systemName];
}
- (NSString *)OS_Version
{
    UIDevice *Device=[UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@ %@",[Device systemName],[Device systemVersion]];
}
- (NSString *)DeviceModel
{
    return [[UIDevice currentDevice] model];
}
- (NSString *)ThisSoftVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+(instancetype)sharedInstance
{
    static DeviceInformation *instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance =[[super allocWithZone:nil] init];
    });
    return instance;
}
//allocWithZone是创建对象分配内存的源头，alloc也会调用该接口来分配内存创建对象。
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedInstance];
}
@end

@implementation UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [[self class] imageWithColor:color size:CGSizeMake(30.0f, 30.0f)]; ;
}
///< 根据颜色、图片大小 生成图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // 画图开始
    UIGraphicsBeginImageContext(rect.size);
    // 获取图形设备上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    // 用所设置的填充颜色填充
    CGContextFillRect(context, rect);
    // 得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 画图结束，解释资源
    UIGraphicsEndImageContext();
    
    return image;
}
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end

@implementation UITextField (exc)

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender

{
    
    if ([UIMenuController sharedMenuController]) {
        
        [UIMenuController sharedMenuController].menuVisible = NO;
        
    }
    
    return YES;
    
    //    if (action == @selector(paste:))
    //        return NO;
    //    return [super canPerformAction:action withSender:sender];
    
    
}

@end

@implementation NSString (ex)

- (BOOL) isValidateCarNo
{
    NSString *carRegex = @"[a-zA-Z0-9]{5}";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",self);
    return [carTest evaluateWithObject:self];
}

-(BOOL)isNullOrEmpty
{
    NSLog(@"%@",self);
    NSLog(@"%p",self);
    return [NSString isNullOrEmpty:self];
}
/**
 *  判断字符串是否空
 */
+(BOOL)isNullOrEmpty:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    if (string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

/**
 * 功能:验证身份证是否合法
 * 参数:输入的身份证号
 */
- (BOOL)isValidPersonID {
    // 判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    // 将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }
    
    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始小标
 * 参数:字符串的结束下标
 */
- (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}


-(BOOL)isSpacesExists
{
    //    NSString *_string = [NSString stringWithFormat:@"123 456"];
    NSRange _range = [self rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    }else
    {        //没有空格
        return NO;
    }
}


-(BOOL)isSpecialCharacters
{
    NSCharacterSet *ValidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    NSRange Range = [self rangeOfCharacterFromSet:ValidCharacters];
    if (Range.location != NSNotFound)
    {
        NSLog(@"包含特殊字符");
    }
    return Range.location!=NSNotFound;
}
//验证手机号
+ (BOOL)isMobileNumber:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (string.length != 11)
        
    {
        
        return NO;
        
    }else{
        
        /**
         
         * 移动号段正则表达式
         
         */
        
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        /**
         
         * 联通号段正则表达式
         
         */
        
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        /**
         
         * 电信号段正则表达式
         
         */
        
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:string];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        
        BOOL isMatch2 = [pred2 evaluateWithObject:string];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:string];
        
        
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{
            
            return NO;
            
        }
    }
}

//验证姓名
+(BOOL)isName:(NSString*)str{
    
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (str.length < 4){
        
        return YES;
    }
    
    if (str.length > 64) {
        return NO;
    }
    
    //    NSString * reStr = @"^(([\u4e00-\u9fa5][00B7][258C]){2,32})$";
    
    NSString * reStr = [[NSString alloc]initWithFormat: @"^[\x00-\xff]{2,32}[00B7]$"];
    //    NSString * reStr = @"^[\x00-\xff]{2,32}(?:[00B7][\x00-\xff]){2,32}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reStr];
    
    BOOL isCon = [pre evaluateWithObject:str];
    
    if (isCon) {
        return YES;
    }else {
        return NO;
    }
    
}
//根据图片的大小限定在limitToSize的宽高内，进行等比例压缩返回图片
+(UIImage *)imageCompress:(UIImage *)image limitToSize:(CGSize)lsize
{
    if (nil == image)
    {
        return nil;
    }
    if (image.size.width<lsize.width && image.size.height<lsize.height)
    {
        return image;
    }
    CGSize size = [self fitsize:image.size limitToSize:lsize];
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newing = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newing;
}

+ (CGSize)fitsize:(CGSize)thisSize limitToSize:(CGSize)lsize
{
    if(thisSize.width == 0 && thisSize.height ==0)
        return CGSizeMake(0, 0);
    CGFloat wscale = thisSize.width/lsize.width;
    CGFloat hscale = thisSize.height/lsize.height;
    CGFloat scale = (wscale>hscale)?wscale:hscale;
    CGSize newSize = CGSizeMake(thisSize.width/scale, thisSize.height/scale);
    return newSize;
}
#pragma mark 保存图片至沙盒
+ (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    // 获取沙盒目录
    NSString *fullPath = [[Help getUploadFileBasePath] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

//手机号码验证
- (BOOL) isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
//根据身份证判断性别
+ (NSString *)sexStrFromIdentityCard:(NSString *)numberStr
{
    NSString * result = nil;
    BOOL isAllNumber = YES;
    if ([numberStr length] < 17) {
        NSString * fontNumber = [numberStr substringFromIndex:numberStr.length];
        //检测是否是数字
        const char *str = [fontNumber UTF8String];
        const char *p = str;
        while (*p != '\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        if (! isAllNumber) {
            return result;
        }
        int sexNumber = [fontNumber intValue];
        if (sexNumber%2 == 1) {
            result = @"男";
        }else if (sexNumber%2 == 0) {
            result = @"女";
        }
        return result;
    }else {
        NSString * fontNumber = [numberStr substringWithRange:NSMakeRange(16, 1)];
        int sexNumber = [fontNumber intValue];
        if (sexNumber%2 == 1) {
            result = @"男";
        }else if (sexNumber%2 == 0) {
            result = @"女";
        }
        return result;
    }
    
}

@end
