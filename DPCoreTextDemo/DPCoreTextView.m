//
//  DPCoreTextView.m
//  DPCoreTextDemo
//
//  Created by Peng Dong on 2018/8/26.
//  Copyright © 2018 Peng Dong. All rights reserved.
//

#import "DPCoreTextView.h"

#import <CoreText/CoreText.h>

@implementation DPCoreTextView


- (void)drawRect:(CGRect)rect {
    if (self) {
        [self setGestureEvent];
    }
    
    [self baseCoreTextUsingMethod];
}

- (void)setGestureEvent {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClickedEvent:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGestureClickedEvent:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:self];
    
    NSLog(@"%f, %f", point.x, point.y);
    
    
    
//    for (CoreTextImageData *data in self.data.imageArray) {
//        //翻转坐标系imageArray中所存坐标的坐标系为CoreText坐标系
//        CGRect imageRect = data.imagePosition;
//        CGPoint imagePositon = imageRect.origin;
//        imagePositon.y = self.bounds.size.height - imageRect.size.height - imageRect.origin.y;
//        imageRect = CGRectMake(imagePositon.x, imagePositon.y, imageRect.size.width, imageRect.size.height);
//        //判断点击点是否在Rect当中
//        if (CGRectContainsPoint(imageRect, point)) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:data.name delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            return;
//        }
//    }
//    CoreTextLinkData *linkData = [CoreTextLinkData touchLinkInView:self atPoint:point data:self.data];
//    if (linkData != nil) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:linkData.urlString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
}



- (void)baseCoreTextUsingMethod {
    //1.获取当前设备上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.翻转坐标系(coreText坐标系是以左下角为坐标原点，UIKit以左上角为坐标原点)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //3.设置绘制区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(10, 20, self.bounds.size.width - 20, self.bounds.size.height - 40));
    //4.设置文本内容
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"jlfkaj;jfa;dkfja;dfj;akdjfajd;fadj;fjafjakldjf;adjf;ajdf;aj;fkja;dkfjakdfjadjfa;kdjfa;kkdfja;dfja;kdjf;adkfjakdfjadfjajdalkfja;djfa;jdf;akjdfakjdfajd;kfajd;fjakjdf;akjd;faj;fkja;jf;akjdfkajfk;akfja;fja;djfa;kdjfkajf;;dfkj" attributes:[DPCoreTextView attributes]];
    
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
//    NSDictionary * attributes = [self attributesWithConfig:config];
    
    
    [attString appendAttributedString: [[self class] parseImageDataFromNSDictionary]];
    
    [attString appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"jlfkaj;jfa;dkfja;dfj;akdjfajd;fadj;fjafjakldjf;adjf;ajdf;aj;fkja;dkfjakdfjadjfa;kdjfa;kkdfja;dfja;kdjf;adkfjakdfjadfjajdalkfja;djfa;jdf;akjdfakjdfajd;kfajd;fjakjdf;akjd;faj;fkja;jf;akjdfkajfk;akfja;fja;djfa;kdjfkajf;;dfkj" attributes:[DPCoreTextView attributes]]];
    
    
    CTFramesetterRef ctFrameSetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    //获取要绘制的区域信息
    CGSize restrictSize = CGSizeMake(self.bounds.size.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(ctFrameSetterRef, CFRangeMake(0, 0), NULL, restrictSize, NULL);
    NSLog(@"size %f %f", coreTextSize.width, coreTextSize.height);
    
    CGMutablePathRef crFramepath = CGPathCreateMutable();
    CGPathAddRect(crFramepath, NULL, CGRectMake(0, 0, self.bounds.size.width, coreTextSize.height));
    CTFrameRef ctframeRef = CTFramesetterCreateFrame(ctFrameSetterRef, CFRangeMake(0, 0), path, NULL);
    NSLog(@"%@", ctframeRef);
    CFRelease(crFramepath);
    
    //5.设置CTFrame
    CTFramesetterRef ctFrameSetting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFrameSetting, CFRangeMake(0, [attString length]), path, NULL);
    //6.在CTFrame中绘制文本关联到上下文
    CTFrameDraw(ctFrame, context);
    //7.释放变量
    CFRelease(path);
    CFRelease(ctFrameSetting);
    CFRelease(ctFrame);
}

+ (NSMutableDictionary *)attributes {
    //配置字体信息
    CGFloat fontSize = 17;
    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    
    //配置间距
    CGFloat lineSpace = 2;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {
            kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace
        },
        {
            kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpace
        },
        {
            kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpace
        }
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    //配置颜色
    UIColor *textColor = [UIColor blueColor];
    //将配置信息加入字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)ctFont;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    //释放变量
    CFRelease(theParagraphRef);
    CFRelease(ctFont);
    
    return dict;
}

+ (NSAttributedString *)parseImageDataFromNSDictionary {
    //配置CTRun代理回调函数
    CTRunDelegateCallbacks callbacks;
    //为callbacks开辟内存空间
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    //设置代理版本
    callbacks.version = kCTRunDelegateVersion1;
    //配置代理回调函数
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    //根据配置的代理信息创建代理
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, nil);
    //使用0xFFFC作为空白占位符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary * attributes = [self attributes];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content attributes:attributes];
    //为属性文字设置代理
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}

/**
 *  上升高度回调函数
 */
static CGFloat ascentCallback(void *ref) {
//    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
    
    return 200;
}

/**
 *  下降高度回调函数
 */
static CGFloat descentCallback(void *ref) {
    return 0;
}

/**
 *  文本宽度回调函数
 */
static CGFloat widthCallback(void *ref) {
//    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
    
    return 100;
}


@end
