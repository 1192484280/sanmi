//
//  SetHeaderView.h
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/26.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetHeaderView : UIView

/*
 
 - (NSArray *)listArr{
 
 if (!_listArr) {
 
 _listArr = @[@[@"昵称",@"手机号码"],@[@"消息通知"],@[@"淘宝授权"],@[@"关于闪蜜"],@[@"清除缓存"],@[@"退出登录"]];
 }
 return _listArr;
 }
 
 - (NSArray *)vcArr{
 
 if (!_vcArr) {
 
 _vcArr = @[@[@"ChangeNickNameViewController",@"ChangePhoneViewController"],@[@"RelationAlipayViewController",@"",@"ChangePassWordViewController"],@[@"ChangeUrlModelViewController",@"",@"",@""],@[@""],@[@""],@[@""]];
 }
 return _vcArr;
 }
 
 - (SetHeaderView *)headerView{
 
 if (!_headerView) {
 
 _headerView = [[SetHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 150)];
 }
 return _headerView;
 }
 
 - (UITableView *)tableView{
 
 if (!_tableView) {
 
 _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
 _tableView.delegate = self;
 _tableView.dataSource = self;
 _tableView.sectionHeaderHeight = 9.5;
 _tableView.sectionFooterHeight = 0.5;
 _tableView.tableHeaderView = self.headerView;
 _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
 [self.view addSubview:_tableView];
 [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.edges.mas_equalTo(0);
 }];
 }
 return _tableView;
 }
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 [self setNavBarWithTitle:@"设置"];
 [self.tableView reloadData];
 }
 
 #pragma mark - UITableViewDelegate,UITableViewDataSource
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
 return self.listArr.count;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 NSArray *arr = self.listArr[section];
 return arr.count;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 SetCell *cell = [SetCell tempWithTableView:tableView indexPath:indexPath];
 [cell setTitle:self.listArr[indexPath.section][indexPath.row] indexPath:indexPath];
 return cell;
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
 if (indexPath.section == 2 && (indexPath.row ==1  || (indexPath.row ==2 ) || (indexPath.row ==3 ))) {
 
 return;
 }
 
 if (indexPath.section == 3 || indexPath.section == 4) {
 
 return;
 }
 
 if (indexPath.section == 1 && indexPath.row == 1) {
 
 return;
 }
 
 if ([self.listArr[indexPath.section][indexPath.row] isEqualToString:@"清除缓存"]) {
 
 [CacheManager removeCache];
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
 SetCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
 cell.cellThree_desLa.text = @"0.0B";
 });
 
 return;
 }
 
 [self pushTargetVCWithClassString:self.vcArr[indexPath.section][indexPath.row]];
 
 }
 */

@end

NS_ASSUME_NONNULL_END
