//
//  ChangeUrlModelHeaderView.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/6.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ChangeUrlModelHeaderView.h"
#import "ChangeUrlModelCell.h"
#import "ChangUrlModel.h"

@interface ChangeUrlModelHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *coBgView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *listArr;
@property (weak, nonatomic) IBOutlet UITextView *tw;
@property (nonatomic, strong) NSMutableString *copyStr;

@property (nonatomic, strong) UIView *xibView;

@end

@implementation ChangeUrlModelHeaderView

- (UIView *)xibView{
    
    if (!_xibView) {
        
        _xibView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeUrlModelHeaderView" owner:self options:nil]lastObject];
    }
    return _xibView;
}

- (NSMutableString *)copyStr{
    
    if (!_copyStr) {
        
        _copyStr = [[NSMutableString alloc] initWithString:@"【商品】{商品名}\n【密券】{券金额}元\n【在售价】{在售价}元\n【券后价】{券后价}元\n【优惠地址】{短链接}\n-------------\n【小编推荐】{商品文案}\n【长按图片识别二维码查看详情】\n【下单方式】长按复制这条信息,打开手机淘宝,领券并下单"];
    }
    return _copyStr;
}

- (NSArray *)listArr{
    
    if (!_listArr) {
        
        ChangUrlModel *model1 = [[ChangUrlModel alloc] init];
        model1.name = @"商品名";
        model1.selected = YES;
        
        ChangUrlModel *model2 = [[ChangUrlModel alloc] init];
        model2.name = @"商品文案";
        model2.selected = YES;
        
        ChangUrlModel *model3 = [[ChangUrlModel alloc] init];
        model3.name = @"在售价";
        model3.selected = YES;
        
        ChangUrlModel *model4= [[ChangUrlModel alloc] init];
        model4.name = @"券金额";
        model4.selected = YES;
        
        ChangUrlModel *model5 = [[ChangUrlModel alloc] init];
        model5.name = @"券后价";
        model5.selected = YES;
        
        ChangUrlModel *model6 = [[ChangUrlModel alloc] init];
        model6.name = @"淘口令";
        model6.selected = NO;
        
        ChangUrlModel *model7 = [[ChangUrlModel alloc] init];
        model7.name = @"短链接";
        model7.selected = YES;
        
        ChangUrlModel *model8 = [[ChangUrlModel alloc] init];
        model8.name = @"分享赚";
        model8.selected = NO;
        
        ChangUrlModel *model9 = [[ChangUrlModel alloc] init];
        model9.name = @"APP下载地址";
        model9.selected = NO;
        
        ChangUrlModel *model10 = [[ChangUrlModel alloc] init];
        model10.name = @"换行";
        model10.selected = NO;
        
        _listArr = @[model1,model2,model3,model4,model5,model6,model7,model8,model9,model10];
    }
    return _listArr;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        if (!_collectionView) {
            
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            CGFloat itemW = (KScreenWidth - 20 - 20) / 3;
            CGFloat itemH = 30;
            layout.itemSize = CGSizeMake(itemW, itemH);
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            layout.minimumLineSpacing = 10;
            layout.minimumInteritemSpacing = 0;
            
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerNib:[UINib nibWithNibName:@"ChangeUrlModelCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CELL"];
            
        }
        return _collectionView;
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.xibView];
        self.xibView.frame = frame;
        
        self.tw.text = self.copyStr;
        
        [self.saveBtn az_setGradientBackgroundWithColors:@[LeftColor,RightColor] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
        
        [self.coBgView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangUrlModel *model = self.listArr[indexPath.row];
    
    ChangeUrlModelCell *cell = (ChangeUrlModelCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ChangUrlModel *model = self.listArr[indexPath.row];
    model.selected = !model.selected;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    if ([model.name isEqualToString:@"换行"]) {
        
        NSUInteger location = self.tw.selectedRange.location;
        
        NSString *content = self.copyStr;
        NSString *result = [NSString stringWithFormat:@"%@%@%@",[content substringToIndex:location],@"\n",[content substringFromIndex:location]];
        self.copyStr = [NSMutableString stringWithString:result];
        self.tw.text =self.copyStr;
        
        [self changeTwLocation:location];
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@"{%@}",model.name];
    
    if (!model.selected) {
        
        NSRange range= [self.copyStr rangeOfString:str];
        [self.copyStr deleteCharactersInRange:range];
        self.tw.text =self.copyStr;
    }else{
        
        NSUInteger location = self.tw.selectedRange.location;
        
        NSString *content = self.copyStr;
        NSString *result = [NSString stringWithFormat:@"%@%@%@",[content substringToIndex:location],str,[content substringFromIndex:location]];
        self.copyStr = [NSMutableString stringWithString:result];
        self.tw.text = self.copyStr;
        
        [self changeTwLocation:location+str.length];
    }
    
    
}

#pragma mark - 清空
- (IBAction)onCleanBtn:(UIButton *)sender {
    
    self.copyStr = [[NSMutableString alloc] init];
    self.tw.text = self.copyStr;
    
    for (ChangUrlModel *model in self.listArr) {
        
        model.selected = NO;
    }
    [self.collectionView reloadData];
}

#pragma mark - 恢复默认
- (IBAction)onReSetBtn:(UIButton *)sender {
    
    self.copyStr = [[NSMutableString alloc] initWithString:@"【商品】{商品名}\n【密券】{券金额}元\n【在售价】{在售价}元\n【券后价】{券后价}元\n【优惠地址】{短链接}\n-------------\n【小编推荐】{商品文案}\n【长按图片识别二维码查看详情】\n【下单方式】长按复制这条信息,打开手机淘宝,领券并下单"];
    self.tw.text = self.copyStr;
    
    for (ChangUrlModel *model in self.listArr) {
        
        model.selected = YES;
        if ([model.name isEqualToString:@"淘口令"] || [model.name isEqualToString:@"分享赚"] || [model.name isEqualToString:@"APP下载地址"] ) {
            
            model.selected = NO;
        }
    }
    [self.collectionView reloadData];
}


#pragma mark - 保存
- (IBAction)onSaveBtn:(UIButton *)sender {
    
    [self.viewController.view makeToast:@"保存成功" duration:2.0 position:CSToastPositionCenter];
}


- (void)changeTwLocation:(NSInteger)location{
    
    [self.tw becomeFirstResponder];
    
    NSRange range =NSMakeRange(location,0);
    
    UITextPosition*start = [self.tw positionFromPosition:[self.tw beginningOfDocument] offset:range.location];
    
    UITextPosition*end = [self.tw positionFromPosition:start offset:range.length];
    
    [self.tw setSelectedTextRange:[self.tw textRangeFromPosition:start toPosition:end]];
}
@end
