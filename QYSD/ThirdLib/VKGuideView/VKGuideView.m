//
//  VKGuideView.m
//  VKDParentMineCenter
//
//  Created by vipkid on 2018/11/6.
//

#import "VKGuideView.h"
#import "UILabel+VKDFontStyle.h"
#import "UIImage+VKDImageAsset.h"

typedef NS_ENUM(NSInteger, VKGuideMaskItemRegion)
{
    VKGuideMaskItemRegionLeftTop = 0,   // 控件View 左上
    VKGuideMaskItemRegionLeftBottom,    // 控件View 左下
    VKGuideMaskItemRegionRightTop,      // 控件View 右上
    VKGuideMaskItemRegionRightBottom,   // 控件View 右下
    VKGuideMaskItemRegionHalfWidthTop      // 控件View 在上
};

@interface VKGuideView()

@property (strong, nonatomic) UIImageView *arrowImgView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIView *maskView;
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation VKGuideView {
    NSInteger _count; //记录items总数
}
#pragma mark - 懒加载
- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
    }
    return _maskLayer;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _maskView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (UIImageView *)arrowImgView {
    if (!_arrowImgView) {
        _arrowImgView = [UIImageView new];
    }
    return _arrowImgView;
}

#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.arrowSpace = self.arrowSpace ?: 10;
    
    [self addSubview:self.maskView];
    [self addSubview:self.arrowImgView];
    [self addSubview:self.textLabel];
    
    self.backgroundColor     = [UIColor clearColor];
    self.maskBackgroundColor = [UIColor blackColor];
    self.maskAlpha  = .7f;
    self.arrowImage = [UIImage vkd_kitImageName:@"VKDCommons_guideView_arrow" withBundleName:@"VKDCommonsResources"];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UILabel vkd_fontWithStyle:@"PingFangSC-Medium" andSize:18];
}


#pragma mark - Setter Method
- (void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage;
    self.arrowImgView.image = arrowImage;
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self showMask];
    [self configureItemsFrame];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(guideMaskView:index:)]) {
        [self.delegate guideMaskView:self index:currentIndex];
    }
}

- (void)setMaskBackgroundColor:(UIColor *)maskBackgroundColor
{
    _maskBackgroundColor = maskBackgroundColor;
    self.maskView.backgroundColor = maskBackgroundColor;
}

- (void)setMaskAlpha:(CGFloat)maskAlpha
{
    _maskAlpha = maskAlpha;
    self.maskView.alpha = maskAlpha;
}

#pragma mark - Privite Method

/**
 *  显示蒙板
 */
- (void)showMask
{
    CGPathRef fromPath = self.maskLayer.path;
    CGPathRetain(fromPath);
    
    /// 更新 maskLayer 的 尺寸
    self.maskLayer.frame = self.bounds;
    self.maskLayer.fillColor = [UIColor blackColor].CGColor;
    
    CGFloat maskCornerRadius = 5;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:cornerRadiusForItemAtIndex:)]) {
        maskCornerRadius = [self.dataSource guideMaskView:self cornerRadiusForItemAtIndex:self.currentIndex];
    }
    
    /// 获取可见区域的路径(开始路径)
    UIBezierPath *visualPath = [UIBezierPath bezierPathWithRoundedRect:[self obtainVisualFrame] cornerRadius:maskCornerRadius];
    
    /// 获取终点路径
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [toPath appendPath:visualPath];
    
    /// 遮罩的路径
    self.maskLayer.path = toPath.CGPath;
    self.maskLayer.fillRule = kCAFillRuleEvenOdd;
    self.layer.mask = self.maskLayer;
    
    /// 开始移动动画
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration  = 0.3;
    anim.fromValue = (__bridge id _Nullable)(fromPath);
    CGPathRelease(fromPath);
    anim.toValue   = (__bridge id _Nullable)(toPath.CGPath);
    [self.maskLayer addAnimation:anim forKey:NULL];
}

/**
 *  更新控件位置
 */
- (void)configureItemsFrame
{
    //描述文字
    NSString *desc = [self.dataSource guideMaskView:self descriptionLabelForItemAtIndex:self.currentIndex];
    self.textLabel.text = desc;
    
    //描述文字与左右边框间的距离，默认36
    CGFloat descInsetsX = 36;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:horizontalSpaceForDescriptionLabelAtIndex:)]){
        descInsetsX = [self.dataSource guideMaskView:self horizontalSpaceForDescriptionLabelAtIndex:self.currentIndex];
    }
    
    //每个 item 的子视图（当前介绍的子视图、箭头、描述文字）之间的间距
    CGFloat space = 10;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:spaceForSubviewsAtIndex:)])
    {
        space = [self.dataSource guideMaskView:self spaceForSubviewsAtIndex:self.currentIndex];
    }
    
    //每个 item 的子视图（当前介绍的子视图、箭头、描述文字）偏移距离，默认是0
    CGFloat horizontalSpace = 0;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:horizontalSpaceForArrowAndDescriptionLabelAtIndex:)])
    {
        horizontalSpace = [self.dataSource guideMaskView:self horizontalSpaceForArrowAndDescriptionLabelAtIndex:self.currentIndex];
    }
    
    //文字与箭头的位置
    CGRect textRect, arrowRect;
    CGSize imgSize   = self.arrowImgView.image.size;
    CGFloat maxWidth = self.bounds.size.width - descInsetsX * 2;
    CGSize textSize  = [desc boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName : self.textLabel.font}
                                          context:NULL].size;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    //获取要标记出的位置
    VKGuideMaskItemRegion itemRegion = [self obtainVisualRegion];
    
    switch (itemRegion)
    {
        case VKGuideMaskItemRegionLeftTop:
        {
            //控件View 左上
            arrowRect = CGRectMake(CGRectGetMaxX([self obtainVisualFrame]) + self.arrowSpace,
                                   CGRectGetMinY([self obtainVisualFrame]) + CGRectGetHeight([self obtainVisualFrame])/2,
                                   imgSize.width,
                                   imgSize.height);
            
            textRect = CGRectMake(CGRectGetMaxX(arrowRect)-textSize.width/2 -horizontalSpace,
                                  CGRectGetMaxY(arrowRect) + space,
                                  textSize.width,
                                  textSize.height);
            break;
        }
        case VKGuideMaskItemRegionRightTop:
        {
            //控件View 右上
            transform = CGAffineTransformMakeScale(-1, 1);
            arrowRect = CGRectMake(CGRectGetMinX([self obtainVisualFrame]) - imgSize.width  - self.arrowSpace,
                                   CGRectGetMinY([self obtainVisualFrame]) + CGRectGetHeight([self obtainVisualFrame])/2,
                                   imgSize.width,
                                   imgSize.height);
            
            textRect = CGRectMake(CGRectGetMinX(arrowRect)-textSize.width/2 -horizontalSpace,
                                  CGRectGetMaxY(arrowRect) + space,
                                  textSize.width,
                                  textSize.height);
            break;
        }
        case VKGuideMaskItemRegionLeftBottom:
        {
            //控件View 左下
            transform = CGAffineTransformMakeScale(1, -1);
            arrowRect = CGRectMake(CGRectGetMaxX([self obtainVisualFrame]) + self.arrowSpace,
                                   CGRectGetMinY([self obtainVisualFrame]) - CGRectGetHeight([self obtainVisualFrame])/2,
                                   imgSize.width,
                                   imgSize.height);
            
            textRect = CGRectMake(CGRectGetMaxX(arrowRect)-textSize.width/2 -horizontalSpace,
                                  CGRectGetMinY(arrowRect) - space - textSize.height,
                                  textSize.width,
                                  textSize.height);
            break;
        }
        case VKGuideMaskItemRegionRightBottom:
        {
            //控件View 右下
            transform = CGAffineTransformMakeScale(-1, -1);
            arrowRect = CGRectMake(CGRectGetMinX([self obtainVisualFrame]) - CGRectGetWidth([self obtainVisualFrame]) - self.arrowSpace,
                                   CGRectGetMaxY([self obtainVisualFrame]) - CGRectGetHeight([self obtainVisualFrame]),
                                   imgSize.width,
                                   imgSize.height);
            
            textRect = CGRectMake(CGRectGetMinX(arrowRect)-textSize.width/2 -horizontalSpace,
                                  CGRectGetMinY(arrowRect) - space - textSize.height,
                                  textSize.width,
                                  textSize.height);
            break;
        }
        case VKGuideMaskItemRegionHalfWidthTop:
        {
            //控件过半, 控件View在上
            transform = CGAffineTransformMakeScale(1, 1);
            arrowRect = CGRectMake((CGRectGetWidth([self obtainVisualFrame]) / 2) + CGRectGetMinX([self obtainVisualFrame]),
                                   CGRectGetMaxY([self obtainVisualFrame]) + self.arrowSpace,
                                   imgSize.width,
                                   imgSize.height);
            
            textRect = CGRectMake(CGRectGetMinX(arrowRect)-textSize.width/2 -horizontalSpace,
                                  CGRectGetMaxY(arrowRect) + space,
                                  textSize.width,
                                  textSize.height);
            break;
        }
            
    }
    
    //文字描述超出屏幕后做偏移
    if (CGRectGetMinX(textRect)<=0) {
        //左侧超出
        textRect = CGRectMake(descInsetsX,
                              CGRectGetMinY(textRect),
                              CGRectGetWidth(textRect),
                              CGRectGetHeight(textRect));
    }
    if (CGRectGetMaxX(textRect)>=self.bounds.size.width) {
        //右侧超出
        textRect = CGRectMake(self.bounds.size.width-descInsetsX-CGRectGetWidth(textRect),
                              CGRectGetMinY(textRect),
                              CGRectGetWidth(textRect),
                              CGRectGetHeight(textRect));
    }
    
    
    NSMutableArray *tempBtnArr = [NSMutableArray arrayWithCapacity:0];
    //  设置底部按键
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:showButtonAtIndex:)])
    {
        if ([self.dataSource guideMaskView:self showButtonAtIndex:self.currentIndex])
        {
            
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:buttonForItemAtIndex:)])
            {
                NSArray *buttons = [self.dataSource guideMaskView:self buttonForItemAtIndex:self.currentIndex];
                for (int buttonIndex = 0; buttonIndex < buttons.count; buttonIndex++) {
                    UIView *btn = [buttons objectAtIndex:buttonIndex];
                    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:buttonPositionWithButtionIndex:itemAtIndex:)]) {
                        CGPoint tempPoint = [self.dataSource guideMaskView:self buttonPositionWithButtionIndex:buttonIndex itemAtIndex:self.currentIndex];
                        btn.center = CGPointMake(CGRectGetMidX(textRect)+tempPoint.x,
                                                 CGRectGetMaxY(textRect)+btn.frame.size.height/2+tempPoint.y);
                        btn.alpha = 0;
                        [self addSubview:btn];
                        [tempBtnArr addObject:btn];
                    }
                }
            }
            
        }
        else
        {
            for (UIView *subview in self.subviews) {
                if ([subview isKindOfClass:[UIButton class]]) {
                    [subview removeFromSuperview];
                }
            }
        }
        
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:showArrowAtIndex:)])
    {
        BOOL showArrow = [self.dataSource guideMaskView:self showArrowAtIndex:self.currentIndex];
        self.arrowImgView.hidden = !showArrow;
    }
    
    //显示
    [UIView animateWithDuration:0.3 animations:^{
        self.arrowImgView.transform = transform;
        self.arrowImgView.frame = arrowRect;
        self.textLabel.frame = textRect;
        for (UIView *tempView in tempBtnArr) {
            tempView.alpha = 1;
        }
    }];
}

/**
 *  获取可见的视图的frame
 */
- (CGRect)obtainVisualFrame
{
    if (self.currentIndex >= _count) {
        return CGRectZero;
    }
    
    UIView *view = [self.dataSource guideMaskView:self viewForItemAtIndex:self.currentIndex];
    
    CGRect visualRect = [self convertRect:view.frame fromView:view.superview];
    
    /// 每个 item 的 view 与蒙板的边距
    UIEdgeInsets maskInsets = UIEdgeInsetsMake(-8, -8, -8, -8);
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(guideMaskView:insetsForItemAtIndex:)]) {
        maskInsets = [self.dataSource guideMaskView:self insetsForItemAtIndex:self.currentIndex];
    }
    
    visualRect.origin.x += maskInsets.left;
    visualRect.origin.y += maskInsets.top;
    visualRect.size.width  -= (maskInsets.left + maskInsets.right);
    visualRect.size.height -= (maskInsets.top + maskInsets.bottom);
    
    return visualRect;
}

/**
 *  判断可见区域的位置
 */
- (VKGuideMaskItemRegion)obtainVisualRegion
{
    CGPoint visualCenter = CGPointMake(CGRectGetMidX([self obtainVisualFrame]),
                                       CGRectGetMidY([self obtainVisualFrame]));
    CGPoint viewCenter   = CGPointMake(CGRectGetMidX(self.bounds),
                                       CGRectGetMidY(self.bounds));
    
    
    if ([self obtainVisualFrame].size.width > [UIScreen mainScreen].bounds.size.width / 2) {
        
        
        return VKGuideMaskItemRegionHalfWidthTop;
    } else {
        
        
        if ((visualCenter.x <= viewCenter.x)    &&
            (visualCenter.y <= viewCenter.y))
        {
            //左上角
            return VKGuideMaskItemRegionLeftTop;
        }
        
        if ((visualCenter.x > viewCenter.x)     &&
            (visualCenter.y <= viewCenter.y))
        {
            //右上角
            return VKGuideMaskItemRegionRightTop;
        }
        
        if ((visualCenter.x <= viewCenter.x)    &&
            (visualCenter.y > viewCenter.y))
        {
            //左下角
            return VKGuideMaskItemRegionLeftBottom;
        }
        
        //右下角
        return VKGuideMaskItemRegionRightBottom;
    }
}

#pragma mark - Public Method
- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [self showInView:window];
}

-(void)showInView:(UIView *)view {
    if (!view) return;
    
    if (self.dataSource) {
        _count = [self.dataSource numberOfItemsInGuideMaskView:self];
    }
    if (_count < 1) return;
    
    [view addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1;
    }];
    
    //设置起始位置
    self.currentIndex = 0;
}

-(void)showWithIndex:(NSInteger)index {
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    if (self.dataSource) {
        _count = [self.dataSource numberOfItemsInGuideMaskView:self];
    }
    if (_count < 1) return;
    
    [window addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 1;
    }];
    
    self.currentIndex = index;
}

#pragma mark - Action Method

/**
 *  隐藏
 */
- (void)hide
{
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(guideMaskViewGonnaHide:)]) {
            [self.delegate guideMaskViewGonnaHide:self];
        }
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.currentIndex < _count-1) {
        self.currentIndex ++;
    }
    else {
        if (self.lastPageAutoDismiss) [self hide];
    }
}

@end
