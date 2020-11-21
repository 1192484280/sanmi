//
//  OpinionViewController.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/9/3.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "OpinionViewController.h"
#import "HXPhotoView.h"
#import "PopoverView.h"
#import "MyFeedbackViewController.h"
#import "OpinionStore.h"
#import "OpinionTypeModel.h"
#import "CommonStore.h"
#import "UploadfilesModel.h"

#define MAX_STARWORDS_LENGTH 1000

@interface OpinionViewController ()<ZJScrollPageViewChildVcDelegate,HXPhotoViewDelegate>
{
    NSInteger typeId;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (nonatomic, strong) HXPhotoManager *manager;
@property (weak, nonatomic) IBOutlet UIView *twBgView;
@property (weak, nonatomic) IBOutlet UIButton *postBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;

@property (nonatomic, weak) YYTextView *textView;
@property (nonatomic, copy) NSArray *typeArr;

@property (nonatomic, weak) HXPhotoView *hxPhotoView;
@property (nonatomic, strong) NSMutableArray *imgArr;
@end

@implementation OpinionViewController

// 懒加载 照片管理类
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.configuration.photoMaxNum = 3;
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarWithTitle:@"意见反馈"];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"反馈记录" style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn)];
    self.navigationItem.rightBarButtonItem = item;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self.postBtn az_setGradientBackgroundWithColors:@[[UIColor colorWithHexString:@"FF9330"],[UIColor colorWithHexString:@"F64923"]] locations:nil startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
    
    self.imgArr = [NSMutableArray array];
    
    [self setUI];
    
    [self getProblemType];
    
}

- (void)setUI{
    
    YYTextView *textView = [YYTextView  new];
    self.textView = textView;
    textView.placeholderText = @"请输入内容";
    textView.showsHorizontalScrollIndicator = NO;
    textView.placeholderFont = [UIFont systemFontOfSize:14];
    [textView setBackgroundColor:[UIColor whiteColor]];
    textView.font  = [UIFont systemFontOfSize:14];
    textView.contentSize = CGSizeMake(self.twBgView.width, self.twBgView.height);
    textView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    textView.frame = CGRectMake(0, 0, self.twBgView.width, self.twBgView.height);
    [self.twBgView addSubview:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeNotification:) name:YYTextViewTextDidChangeNotification object:textView];
    
    
    HXPhotoView *hxPhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(0, 0, self.photoView.width, self.photoView.height) manager:self.manager];
    self.hxPhotoView = hxPhotoView;
    hxPhotoView.delegate = self;
    hxPhotoView.backgroundColor = [UIColor whiteColor];
    [self.photoView addSubview:hxPhotoView];
}

#pragma mark - 获取问题分类
- (void)getProblemType{
    
    MJWeakSelf
    [OpinionStore getFeedbacktypeSucess:^(NSArray *theArr) {
        
        if (theArr.count > 0) {
            
            OpinionTypeModel *model = theArr.firstObject;
            
            [weakSelf.typeBtn setTitle:model.DictName forState:UIControlStateNormal];
            
            self->typeId = model.DictID;
            
            weakSelf.typeArr = theArr;
        }
        
        
    } Failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 点击反馈记录
-(void)onRightBtn{
    
    [self.view endEditing:YES];
    [self pushTargetVCWithClassString:@"MyFeedbackViewController"];
}

#pragma mark 关键方法
#pragma mark 方法来源   https://www.jianshu.com/p/2d1c06f2dfa4
-(void)textViewDidChangeNotification:(NSNotification*)obj{
    
    YYTextView *textView = (YYTextView *)obj.object;
    NSString *toBeString = textView.text;
    //获取高亮部分
    YYTextRange *selectedRange = [textView valueForKey:@"_markedTextRange"];
    SEL selName = NSSelectorFromString(@"positionFromPosition:offset:");
    YYTextPosition *position = ((YYTextPosition *(*)(id,SEL,id,int))objc_msgSend)(textView,selName,selectedRange.start,0);
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > MAX_STARWORDS_LENGTH)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1)
            {
                textView.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark - 选择问题
- (IBAction)onProBlemsBtn:(UIButton *)sender {
    
   PopoverView *popoverView = [PopoverView popoverView];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (OpinionTypeModel *model in self.typeArr) {
        
//        MJWeakSelf
        PopoverAction *action = [PopoverAction actionWithTitle:model.DictName handler:^(PopoverAction *action) {
            // 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
            self->typeId = model.DictID;
            [sender setTitle:model.DictName forState:UIControlStateNormal];
        }];
        
        [arr addObject:action];
    }
    
    //    popoverView.style = PopoverViewStyleDark;
    [popoverView showToView:sender withActions:arr];
}

#pragma mark - 点击提交
- (IBAction)onPostBtn:(UIButton *)sender {
    
    if (![self.textView.text isValid]) {
        
        [self showFailMsg:@"请输入您的反馈意见"];
        return;
    }
    
    [SVProgressHUD show];
    if (_manager.afterSelectedPhotoArray.count <=0) {
        
        //直接提交
        [self postComment:nil];
    }else{
        
        //上传图片
        [CommonStore getUploadfilesListWithBusstype:self->typeId imags:self.imgArr Sucess:^(NSArray *theArr) {
            
            //提交建议
            [self postComment:theArr];
            
        } Failure:^(NSError *error) {
            
            [self showToastWithError:error];
            [SVProgressHUD dismiss];
        }];
    }
}

#pragma mark - 提交建议
- (void)postComment:(NSArray *)theArr{
    
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < theArr.count; i ++) {
        
        UploadfilesModel *model = theArr[i];
        if (i == 0) {
            
            [str appendFormat:@"%@", model.RelativePath];
        }else{
            
            [str appendFormat:@",%@",model.RelativePath];
        }
    }
    
    MJWeakSelf
    [OpinionStore feedbackWithUserguid:SMUserGuid feedbacktypeid:[NSString stringWithFormat:@"%ld",(long)self->typeId] feedbackcontent:self.textView.text imgurls:str Sucess:^{
        
        [SVProgressHUD dismiss];
        [weakSelf showSuccessMsg:@"提交成功"];
        
        weakSelf.textView.text = @"";
        [weakSelf.imgArr removeAllObjects];
        [weakSelf.manager clearSelectedList];
        [weakSelf.hxPhotoView refreshView];
        
        [self pushTargetVCWithClassString:@"MyFeedbackViewController"];
        
    } Failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        [weakSelf showToastWithError:error];
    }];
    
}


#pragma mark - HXPhotoViewDelegate
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal{
    
    self.imgArr = [NSMutableArray array];
    
    for (HXPhotoModel *model in photos) {
        
        [model requestPreviewImageWithSize:PHImageManagerMaximumSize startRequestICloud:^(PHImageRequestID iCloudRequestId, HXPhotoModel *model) {
            // 如果照片在iCloud上会去下载,此回调代表开始下载iCloud上的照片
            // 如果照片在本地存在此回调则不会走
            NSLog(@"================1");
        } progressHandler:^(double progress, HXPhotoModel *model) {
            // iCloud下载进度
            // 如果为网络图片,则是网络图片的下载进度
            NSLog(@"================2");
        } success:^(UIImage *image, HXPhotoModel *model, NSDictionary *info) {
            // 获取成功
            NSLog(@"================3");
            [self.imgArr addObject:image];
            
        } failed:^(NSDictionary *info, HXPhotoModel *model) {
            // 获取失败
            NSLog(@"================4");
        }];
    }
}

#pragma mark - 点此区域，键盘消失
- (IBAction)onOutView:(id)sender {
    
    [self.view endEditing:YES];
}

@end
