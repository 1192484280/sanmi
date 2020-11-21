//
//  VKGuideView.h
//  VKDParentMineCenter
//
//  Created by vipkid on 2018/11/6.
//

#import <UIKit/UIKit.h>

@class VKGuideView;

@protocol VKGuideViewDataSource <NSObject>

@required
//需要标示出的Item个数
- (NSInteger)numberOfItemsInGuideMaskView:(VKGuideView *)guideMaskView;
//要标示出的view
- (UIView *)guideMaskView:(VKGuideView *)guideMaskView viewForItemAtIndex:(NSInteger)index;
//每个标示出的view对应的描述
- (NSString *)guideMaskView:(VKGuideView *)guideMaskView descriptionLabelForItemAtIndex:(NSInteger)index;

@optional
//是否显示自定义按键
- (BOOL)guideMaskView:(VKGuideView *)guideMaskView showButtonAtIndex:(NSInteger)index;
//将每页的自定义按键放入数组即可
- (NSArray *)guideMaskView:(VKGuideView *)guideMaskView buttonForItemAtIndex:(NSInteger)index;
//每个按键的位置,返回point是相对于描述信息位置来确定,例如（10，20）是相对于描述信息center中心点横向偏移10像素，竖向相对于描述信息底部偏移20像素
- (CGPoint)guideMaskView:(VKGuideView *)guideMaskView buttonPositionWithButtionIndex:(NSInteger)btnIndex itemAtIndex:(NSInteger)index;
//每个Item的蒙版的圆角:默认为5
- (CGFloat)guideMaskView:(VKGuideView *)guideMaskView cornerRadiusForItemAtIndex:(NSInteger)index;
//每个Item与蒙版的边距
- (UIEdgeInsets)guideMaskView:(VKGuideView *)guideMaskView insetsForItemAtIndex:(NSInteger)index;
//每个Item的子视图的间距：默认为 10
- (CGFloat)guideMaskView:(VKGuideView *)guideMaskView spaceForSubviewsAtIndex:(NSInteger)index;
//每个Item的文字与左右边框的间距：默认为 36
- (CGFloat)guideMaskView:(VKGuideView *)guideMaskView horizontalSpaceForDescriptionLabelAtIndex:(NSInteger)index;
//是否显示箭头
- (BOOL)guideMaskView:(VKGuideView *)guideMaskView showArrowAtIndex:(NSInteger)index;
//箭头和文字横向偏移距离（默认箭头横向初始位置在文字中间）
- (CGFloat)guideMaskView:(VKGuideView *)guideMaskView horizontalSpaceForArrowAndDescriptionLabelAtIndex:(NSInteger)index;
@end


@protocol VKGuideViewDelegate <NSObject>

@optional
- (void)guideMaskViewGonnaHide:(VKGuideView *)guideMaskView;
//需要传递到页面处理的事件（暂无）
- (void)guideMaskView:(VKGuideView *)guideMaskView index:(NSInteger)index;

@end


@interface VKGuideView : UIView

@property (nonatomic, assign) CGFloat arrowSpace; // 箭头与view的距离
@property (nonatomic, assign) BOOL lastPageAutoDismiss; //最后一页点击蒙层是否自动关闭，默认NO
@property (nonatomic, strong) UIImage *arrowImage;
@property (nonatomic, strong) UIColor *maskBackgroundColor;
@property (nonatomic, assign) CGFloat maskAlpha;
@property (nonatomic, weak) id <VKGuideViewDataSource> dataSource;
@property (nonatomic, weak) id <VKGuideViewDelegate> delegate;

- (void)show;
- (void)showInView:(UIView *)view;
- (void)showWithIndex:(NSInteger)index; //跳转到指定页面
- (void)hide;

@end
