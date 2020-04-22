---
layout: post
title: "AppCenter MSCrashes"
subtitle: ""
author: "Genie"
header-img: "img/ef.jpg"
header-mask: 0.5
tags:
  - AppCenter
  - MSCrashes for iOS
---

[appcenter.ms](https://appcenter.ms/)

# MSCrashes

` pod 'AppCenter' `

```
@import AppCenter;
@import AppCenterAnalytics;
@import AppCenterCrashes;
```

```
#if DEBUG
    [MSAppCenter start:@"cd7b7975-741c-4b4d-b595-5670035db133" withServices:@[
         [MSAnalytics class],
         [MSCrashes class]
    ]];
    #else
    [MSAppCenter start:@"f942ab9b-96b2-405a-a27a-d9b4ce7048b1" withServices:@[
         [MSAnalytics class],
         [MSCrashes class],
    ]];
    #endif

    [MSCrashes setEnabled:YES];
    [MSCrashes setDelegate:self];
    [MSAppCenter setLogLevel:MSLogLevelVerbose];
```
### MSCrashesDelegate

* 发生crash 可以上传附件，一般是log文件，我的是xlog。太大一般超过8M会失败。

```
- (NSArray<MSErrorAttachmentLog *> *)attachmentsWithCrashes:(MSCrashes *)crashes
                                             forErrorReport:(MSErrorReport *)errorReport {
    MSErrorAttachmentLog *attachment1 = [MSErrorAttachmentLog attachmentWithText:errorReport.yy_modelToJSONString filename:@"crash.txt"];
    NSString *logPath = [[LKLFilePathManager docPath] stringByAppendingString:@"/log"];
    NSLog(@"logPath: %@", logPath);
    NSString *currentTime = [LKLTimeFormat date:[LKLTimeFormat getTimeStamp] format:LKLTimeFormatSimpleYMD];
    NSString *fileName = [NSString stringWithFormat:@"LKLEdu_%@", currentTime];
    NSData *crashData = [LKLFilePathManager readFileData:[NSString stringWithFormat:@"%@/%@.xlog", logPath, fileName]];
    if (crashData) {
        MSErrorAttachmentLog *attachment2 = [MSErrorAttachmentLog attachmentWithBinary:crashData filename:fileName contentType:@"xlog"];
        return @[ attachment1, attachment2 ];
    }
    return @[ attachment1 ];
}

```

![Issues](/img/AppCenter/Issues/WechatIMG160.png)

