//
//  QYBaseTabBarViewController.m
//  QYSD
//
//  Created by 鹿蒙蒙 on 2019/8/5.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "QYBaseTabBarViewController.h"
#import "HeaderViewController.h"
#import "CircleViewController.h"
//#import "TopViewController.h"
//#import "TypeViewController.h"
#import "MineViewController.h"
#import "SouQuanViewController.h"
#import "QYBaseNavigationViewController.h"
#import "TaoBaoViewController.h"
#import "CommonStore.h"

@interface QYBaseTabBarViewController ()<UITabBarControllerDelegate>

@property (copy, nonatomic) NSArray *titleArr;
@property (copy, nonatomic) NSArray *vcArr;
@property (copy, nonatomic) NSArray *normalImArr;
@property (copy, nonatomic) NSArray *selectedImArr;
@property (nonatomic, assign) NSInteger indexFlag;
@end

@implementation QYBaseTabBarViewController

- (NSArray *)titleArr{
    
    if (!_titleArr) {
        
        _titleArr = @[@"首页", @"搜券",  @"", @"蜜粉圈", @"我的"];
    }
    
    return _titleArr;
}

- (NSArray *)vcArr{
    
    if (!_vcArr) {
        
        HeaderViewController *vc1 = [[HeaderViewController alloc] init];
        SouQuanViewController *vc2 = [[SouQuanViewController alloc] init];
        TaoBaoViewController *vc3 = [[TaoBaoViewController alloc] init];
        CircleViewController *vc4 = [[CircleViewController alloc]init];
        MineViewController *vc5 = [[MineViewController alloc]init];
        
        _vcArr = @[vc1, vc2, vc3, vc4, vc5];
    }
    return _vcArr;
}

- (NSArray *)normalImArr{
    
    if (!_normalImArr) {
        
        _normalImArr = @[@"首页-未选中",@"分类-未选中",@"榜-未点击",@"蜜粉圈-未选中",@"我的-未选中"];
    }
    return _normalImArr;
}

- (NSArray *)selectedImArr{
    
    if (!_selectedImArr) {
        
        _selectedImArr = @[@"首页-选中",@"分类-选中",@"榜-点击后",@"蜜粉圈-选中",@"我的-选中"];
    }
    return _selectedImArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CommonStore getAPPVersionSucess:^(NSString *version) {
        
        if ([version isEqualToString:@"1.0"]) {
        
            [self superSet];
        }else{
            
            [self nonamalSet];
        }
        
    } Failure:^(NSError *error) {
         [self superSet];
    }];
    
    
}

- (void)superSet{
    
    HeaderViewController *vc1 = [[HeaderViewController alloc] init];
    SouQuanViewController *vc2 = [[SouQuanViewController alloc] init];
    TaoBaoViewController *vc3 = [[TaoBaoViewController alloc] init];
    self.vcArr = @[vc1,vc3,vc2];
    
    _titleArr = @[@"首页", @"",@"搜券"];
    
    _normalImArr = @[@"首页-未选中",@"榜-未点击",@"分类-未选中"];
    
     _selectedImArr = @[@"首页-选中",@"榜-点击后",@"分类-选中"];
    
    [self nonamalSet];
    
}
- (void)nonamalSet{
    
    NSMutableArray *navArr = [NSMutableArray array];
    [self.vcArr enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        QYBaseNavigationViewController *nav = [[QYBaseNavigationViewController alloc] initWithRootViewController:obj];
        obj.title = self.titleArr[idx];
        nav.tabBarItem.image = [[UIImage imageNamed:self.normalImArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:self.selectedImArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBar.tintColor = UIColor.blackColor;
//        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.blackColor} forState:UIControlStateSelected];
        
        if ([obj.title isEqualToString:@""]) {
            //tabBar图片居中显示，显示文字的坐标
            
            CGFloat offset = 5.0;
            
            //tabBar图片居中显示，不显示文字
            nav.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
            
        }
        [navArr addObject:nav];
    }];
    self.viewControllers = navArr;
    self.tabBar.translucent = NO;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"aaaaa");
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        //添加动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        //速度控制函数，控制动画运行的节奏
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.15;       //执行时间
        animation.repeatCount = 1;      //执行次数
        animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
        animation.fromValue = [NSNumber numberWithFloat:0.8];   //初始伸缩倍数
        animation.toValue = [NSNumber numberWithFloat:1.1];     //结束伸缩倍数
        [[arry[index] layer] addAnimation:animation forKey:nil];
        self.indexFlag = index;
    }
}
@end
