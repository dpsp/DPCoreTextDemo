//
//  ViewController.m
//  DPCoreTextDemo
//
//  Created by Peng Dong on 2018/8/26.
//  Copyright © 2018 Peng Dong. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

@interface ViewController ()

@property (nonatomic, strong) NSAttributedString *content;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)dealloc {
    NSLog(@"dealloc %s", __FUNCTION__);
}

//- (void)tmp {
//    _content = [[NSAttributedString alloc] initWithString:@"jlfkaj;jfa;dkfja;dfj;akdjfajd;fadj;fjafjakldjf;adjf;ajdf;aj;fkja;dkfjakdfjadjfa;kdjfa;kkdfja;dfja;kdjf;adkfjakdfjadfjajdalkfja;djfa;jdf;akjdfakjdfajd;kfajd;fjakjdf;akjd;faj;fkja;jf;akjdfkajfk;akfja;fja;djfa;kdjfkajf;;dfkj" attributes:[ViewController attributes]];
//    
//    //创建CTFrameSetterRef实例
//    CTFramesetterRef ctFrameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_content);
//    //获取要绘制的区域信息
//    CGSize restrictSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, CGFLOAT_MAX);
//    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetterRef, CFRangeMake(0, 0), NULL, restrictSize, NULL);
//    
//    NSLog(@"%f %f", coreTextSize.width, coreTextSize.height);
//    
//    //1.获取当前设备上下文
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //2.翻转坐标系(coreText坐标系是以左下角为坐标原点，UIKit以左上角为坐标原点)
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, [[UIScreen mainScreen] bounds].size.width);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    //3.设置绘制区域
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRect(path, NULL, CGRectMake(10, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 40));
//    //4.设置文本内容
//    //5.设置CTFrame
//    CTFramesetterRef ctFrameSetting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_content);
//    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetting, CFRangeMake(0, [_content length]), path, NULL);
//    //6.在CTFrame中绘制文本关联到上下文
//    CTFrameDraw(ctFrame, context);
//    //7.释放变量
//    CFRelease(ctFrame);
//    CFRelease(ctFrameSetting);
//    CFRelease(path);
//}
//
//+ (NSMutableDictionary *)attributes {
//    //配置字体信息
//    CGFloat fontSize = 17;
//    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
//    //配置间距
//    CGFloat lineSpace = 2;
//    const CFIndex kNumberOfSettings = 3;
//    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
//        {
//            kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace
//        },
//        {
//            kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace
//        },
//        {
//            kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace
//        }
//    };
//    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
//    //配置颜色
//    UIColor *textColor = [UIColor blueColor];
//    //将配置信息加入字典
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
//    dict[(id)kCTFontAttributeName] = (__bridge id)ctFont;
//    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
//    //释放变量
//    CFRelease(theParagraphRef);
//    CFRelease(ctFont);
//    
//    return dict;
//}

@end
