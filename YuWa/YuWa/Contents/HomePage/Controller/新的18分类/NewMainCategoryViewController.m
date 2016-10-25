//
//  NewMainCategoryViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "NewMainCategoryViewController.h"

#import "JSDropDownMenu.h"

@interface NewMainCategoryViewController ()<UITableViewDataSource,UITableViewDelegate,JSDropDownMenuDataSource,JSDropDownMenuDelegate>{
    NSMutableArray *_data1;
    NSMutableArray *_data2;
    NSMutableArray *_data3;
 
    
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;

    
    NSInteger _currentData1SelectedIndex;
    NSInteger _currentData2SelectedIndex;
    JSDropDownMenu *menu;
}

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableViewDatas;
//吊接口的三个参数
@property(nonatomic,strong)NSString*Pcategory;
@property(nonatomic,strong)NSString*Pplace;
@property(nonatomic,strong)NSString*Psort;


@end

@implementation NewMainCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUpTableView];
    [self initDropMenu];

}

#pragma mark --  UI
-(void)initDropMenu{
    //决定了 初始选择的位置
    _currentData1Index=2;
    _currentData2Index=2;
    _currentData3Index=0;
   
    
    _currentData1SelectedIndex=2;
    _currentData2SelectedIndex=2;
    
    
     menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:40];
    menu.indicatorColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:175.0f/255.0f alpha:1.0];
    menu.separatorColor = [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0];
    menu.textColor = [UIColor colorWithRed:83.f/255.0f green:83.f/255.0f blue:83.f/255.0f alpha:1.0f];
    menu.dataSource = self;
    menu.delegate = self;
    
    [self.view addSubview:menu];

    
    
}

-(void)setUpTableView{
    [self.view addSubview:self.tableView];
    
}




#pragma mark  -- tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    
    cell.selectionStyle=NO;
    cell.textLabel.text=@"666";
    return cell;
    
}


#pragma mark --   menu
//下拉Menu
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return YES;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0||column==1) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0||column==1) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    

        return _currentData3Index;
    
}


- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    
    if (column==0) {
        if (leftOrRight==0) {
            
            return _data1.count;
        } else{
            
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
        }
    } else if (column==1){
        if (leftOrRight==0) {
            return _data2.count;
        }else{
            NSDictionary*menuDic=[_data2 objectAtIndex:leftRow];
            return [[menuDic objectForKey:@"data"] count];
            
        }
       
        
    } else if (column==2){
        
        return _data3.count;
    }
    
    return 0;
}

//选中了哪一个
- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            self.Pcategory=[[_data1[_currentData1Index] objectForKey:@"data"] objectAtIndex:_currentData1SelectedIndex];
            return [[_data1[_currentData1Index] objectForKey:@"data"] objectAtIndex:_currentData1SelectedIndex];
            break;
        case 1:
            self.Pplace=[[_data2[_currentData2Index] objectForKey:@"data"] objectAtIndex:_currentData2SelectedIndex];
            return [[_data2[_currentData2Index] objectForKey:@"data"] objectAtIndex:_currentData2SelectedIndex];
            break;
        case 2:
            self.Psort=_data3[_currentData3Index];
            return _data3[_currentData3Index];
            break;
        default:
            return nil;
            break;
    }
}

//变标题
- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    NSInteger whichCategory;    //哪一类
    NSString*resultStr;       //返回的字符串
     whichCategory=indexPath.column;
    
    
    if (indexPath.column==0) {
       
        
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.row];
            resultStr= [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data1 objectAtIndex:leftRow];
            
            if (indexPath.row==0) {
                resultStr= [menuDic objectForKey:@"title"];
            }else{
            resultStr= [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
            }
        }
    } else if (indexPath.column==1) {
        
        if (indexPath.leftOrRight==0) {
            NSDictionary *menuDic = [_data2 objectAtIndex:indexPath.row];
            resultStr= [menuDic objectForKey:@"title"];
        } else{
            NSInteger leftRow = indexPath.leftRow;
            NSDictionary *menuDic = [_data2 objectAtIndex:leftRow];
            
            if (indexPath.row==0) {
                resultStr= [menuDic objectForKey:@"title"];
            }else{

            resultStr= [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
            }
        }

        
    } else {
        
        resultStr= _data3[indexPath.row];
    }
    
    
    return resultStr;
}


- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    NSString*nameString;
    
    //这里写接口   这里
    switch (indexPath.column) {
        case 0:{
            //第一个选项
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.leftRow];
           nameString= [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
            
            
            break;}
        case 1:{
            //第二个选项
            NSDictionary *menuDic = [_data2 objectAtIndex:indexPath.leftRow];
            nameString= [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];

            break;}
        case 2:{
            //第三个选项
            nameString = [_data3 objectAtIndex:indexPath.row];
            

            break;}
            
        default:
            break;
    }

    
    MyLog(@"11xx  %@",nameString);
    
    
    
    if (indexPath.column == 0) {
        
        if(indexPath.leftOrRight==0){
            
            _currentData1Index = indexPath.leftRow;
            
            
            return;
        }else{
            //这里吊接口的
            NSDictionary *menuDic = [_data1 objectAtIndex:indexPath.leftRow];
            self.Pcategory= [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];

            [self getTableViewDatasWithSection0:self.Pcategory andSection1:self.Pplace andSort:self.Psort];
            
        }
        
    } else if(indexPath.column == 1){
        if (indexPath.leftOrRight==0) {
            _currentData2Index = indexPath.leftRow;

        }else{
            //这里吊接口的
            NSDictionary *menuDic = [_data2 objectAtIndex:indexPath.leftRow];
            self.Pplace= [[menuDic objectForKey:@"data"] objectAtIndex:indexPath.row];
            [self getTableViewDatasWithSection0:self.Pcategory andSection1:self.Pplace andSort:self.Psort];
        }
        
    } else{
        
        _currentData3Index = indexPath.leftRow;
        //这里吊接口的
        //第三个选项
        self.Pplace = [_data3 objectAtIndex:indexPath.row];
     [self getTableViewDatasWithSection0:self.Pcategory andSection1:self.Pplace andSort:self.Psort];
        
    }
    
    
    
    
}



#pragma mark  --  Datas
//接口： 用于获得数据 吊接口
-(void)getTableViewDatasWithSection0:(NSString*)str andSection1:(NSString*)place andSort:(NSString*)sort{
    MyLog(@" %@,%@,%@",str,place,sort);
    
    
}



-(void)initData{
    NSArray*subArray1=@[@"全部",@"火锅",@"生日蛋糕",@"甜点饮品",@"自助餐",@"小吃快餐",@"日韩料理",@"西餐",@"聚餐宴请",@"闽菜",@"烧烤烤肉",@"川湘菜",@"香锅烤鱼",@"江浙菜",@"粤菜",@"中式烧烤/烤串",@"咖啡酒吧",@"西北菜",@"东北菜",@"生鲜蔬果",@"京菜鲁菜",@"云贵菜",@"东南亚菜",@"海鲜",@"素食",@"台湾/客家菜",@"创意菜",@"汤/粥/炖菜",@"蒙餐",@"新疆菜",@"其他美食"];
    NSArray*subArray2=@[@"全部",@"热映电影",@"主题电影"];
    NSArray*subArray3=@[@"全部",@"经济型酒店",@"快捷连锁",@"主题酒店",@"商务酒店",@"公寓",@"豪华酒店",@"客栈",@"青年旅社",@"度假酒店",@"别墅",@"其他酒店"];
    NSArray*subArray4=@[@"全部",@"温泉",@"景点",@"主题公园",@"儿童乐园",@"水上乐园",@"动植物园",@"海洋馆",@"短途游",@"直通车",@"展览馆",@"游船",@"酒景套餐",@"滑雪",@"高空观景",@"攀登运动",@"真人CS",@"农家乐",@"密室逃脱",@"滑冰",@"骑马",@"漂流",@"单车出租",@"其他游玩"];
    NSArray*subArray5=@[@"全部",@"足疗按摩",@"洗浴/汗蒸",@"KTV",@"酒吧",@"桌游/电玩",@"DIY手工",@"密室逃脱",@"点播电影",@"台球",@"真人CS",@"演出赛事",@"主题影院",@"其他娱乐"];
    NSArray*subArray6=@[@"全部",@"衣物/皮具洗护",@"家政服务",@"家政洗衣",@"证件照",@"照片冲印",@"搬家",@"宠物服务",@"体检/齿科",@"健康服务",@"体检",@"鲜花",@"配镜",@"充值服务",@"服饰鞋包",@"开锁",@"商场购物卡",@"电器数码",@"摄影写真",@"婚庆",@"其他生活"];
    NSArray*subArray7=@[@"全部",@"跟团游",@"自由行",@"当地游",@"国内游",@"境外游",@"机票/火车票",@"景点门票"];
    NSArray*subArray8=@[@"全部",@"一站式婚礼馆",@"酒店宴会厅",@"特色餐饮"];
    NSArray*subArray9=@[@"全部",@"本地购物",@"服饰鞋包",@"配镜",@"鲜花",@"数码家电",@"超市/便利店"];
    NSArray*subArray10=@[@"全部",@"美发",@"美容美体",@"美甲没睫",@"瑜伽舞蹈",@"瘦身纤体",@"韩式定妆",@"祛痘",@"纹身",@"整形"];
    NSArray*subArray11=@[@"全部",@"游泳/水上运动",@"健身房/体操房",@"羽毛球",@"台球",@"武术",@"保龄球",@"高尔夫",@"篮球",@"滑冰",@"射箭",@"网球",@"骑马",@"足球",@"乒乓球",@"壁球",@"舞蹈",@"瑜伽",@"综合体育场馆",@"其他运动"];
    NSArray*subArray12=@[@"全部",@"儿童乐园",@"婴儿游泳",@"儿童摄影",@"孕妇写真",@"母婴护理",@"月子会所",@"幼儿教育",@"亲子购物",@"手工DIY",@"儿童话剧",@"科普场馆",@"采摘/农家乐",@"主题公园",@"更多亲子服务",];
    NSArray*subArray13=@[@"全部",@"宠物店",@"宠物医院"];
    NSArray*subArray14=@[@"全部",@"洗车",@"汽车美容",@"汽车改装",@"维修保养",@"打蜡",@"镀晶镀膜",@"小保养",@"玻璃贴膜",@"内饰清洁",@"租车",@"汽车陪练",@"4S汽车店",@"汽车用品",@"停车场",@"更多汽车服务"];
    NSArray*subArray15=@[@"全部",@"婚纱摄影",@"亲子摄影",@"个性写真",@"其他摄影"];
    NSArray*subArray16=@[@"全部",@"婚纱摄影",@"婚纱礼服",@"成衣定制",@"婚庆服务",@"个性写真",@"婚戒首饰",@"婚礼小成品",@"婚车租凭",@"彩妆造型",@"司仪主持",@"婚礼跟拍",@"婚宴",@"旅游婚纱照",@"婚房装修",@"更多婚礼服务"];
    NSArray*subArray17=@[@"全部",@"女装",@"男装",@"内衣", @"鞋靴",@"食品",@"家居日用",@"美妆",@"箱包",@"运动户外",@"配饰手表",@"母婴玩具",@"家纺",@"数码电器",@"家具家装",@"汽车用品",@"本地购物"];
    NSArray*subArray18=@[@"全部",@"装修设计",@"厨房卫浴",@"家用电器",@"家装卖场",@"装修建材"];
    NSArray*subArray19=@[@"全部",@"外语培训",@"音乐培训",@"美术培训",@"书法培训",@"驾校",@"教育院校",@"职业技术",@"升学辅导",@"留学",@"兴趣生活",@"更多教育培训"];
    NSArray*subArray20=@[@"全部",@"医院",@"齿科口腔",@"骨科", @"中医保健",@"体检中心",@"药店"];
    
    NSArray *array=@[@{@"title":@"美食",@"data":subArray1},@{@"title":@"电影",@"data":subArray2},@{@"title":@"酒店",@"data":subArray3},@{@"title":@"周边游",@"data":subArray4},@{@"title":@"休闲娱乐",@"data":subArray5},@{@"title":@"生活服务",@"data":subArray6},@{@"title":@"旅游",@"data":subArray7},@{@"title":@"宴会",@"data":subArray8},@{@"title":@"时尚购",@"data":subArray9},@{@"title":@"丽人",@"data":subArray10},@{@"title":@"运动健身",@"data":subArray11},@{@"title":@"母婴亲子",@"data":subArray12},@{@"title":@"宠物",@"data":subArray13},@{@"title":@"汽车服务",@"data":subArray14},@{@"title":@"摄影写真",@"data":subArray15},@{@"title":@"结婚",@"data":subArray16},@{@"title":@"购物",@"data":subArray17},@{@"title":@"家装",@"data":subArray18},@{@"title":@"学习培训",@"data":subArray19},@{@"title":@"医疗",@"data":subArray20}];
    
    
    _data1=[NSMutableArray arrayWithArray:array];
    
    
      NSArray*placeArray1=@[@"附近",@"1km",@"3km",@"5km",@"10km",@"全城"];
    NSArray*placeArray2=@[@"全部",@"丰泽广场/丰泽街",@"大洋百货周边",@"星光不夜城及周边",@"浦西万达广场",@"泉州客运中心周边",@"永辉/现代家居广场",@"后埔浔埔/丰海路",@"美食街",@"侨乡体育馆/东湖",@"中骏世界城",@"润柏香港城",@"东海湾新华都广场",@"东海大街/宝山/宝珊",@"六灌路",@"领SHOW天地",@"华侨大学周边",@"宝洲路",@"灵山墓/郑成功公园",@"清源山180医院",@"津淮街"];
    NSArray*placeArray3=@[@"全部",@"泉州酒店周边",@"涂门街",@"T淘园",@"凯德广场",@"浮桥",@"西湖公园周边",@"东街/第一医院",@"西街",@"九一路/文化宫",@"南俊路",@"北门街/中山公园"];
    NSArray*placeArray4=@[@"全部",@"时代广场",@"池店",@"万达广场",@"SM广场",@"阳光广场",@"泉安中路",@"安海",@"清濛开发区",@"宝龙广场",@"市标",@"东石镇",@"金井镇",@"国际机场",@"晋江市医院",@"五店市",@"英林"];
    NSArray*placeArray5=@[@"全部",@"德辉广场",@"泰禾广场",@"灵狮中路",@"步行街",@"龟湖公园",@"星期Yi",@"闽南理工学院",@"金汇花园",@"石城广场",@"世茂摩天城"];
    NSArray*placeArray6=@[@"全部",@"市区",@"南安水头镇",@"官桥镇",@"梅山镇",@"洪濑镇",@"石井镇",@"霞美镇",@"康美镇"];
    NSArray*placeArray7=@[@"全部",@"中新花园",@"大红铺",@"东南大街",@"天山广场",@"大润发",@"东园镇",@"崇武镇",@"惠兴街",@"洛阳镇"];
    NSArray*placeArray8=@[@"全部",@"洛江",@"双阳"];
    NSArray*placeArray9=@[@"全部",@"宝龙城市广场",@"县政府",@"海峡茗城",@"龙湖",@"北石光德"];
    NSArray*placeArray10=@[@"全部",@"新民街",@"山腰",@"植物园",@"生活区",@"金山街",@"万星城市广场",@"中心工业区"];
    NSArray*placeArray11=@[@"全部",@"万星文化广场",@"环城路"];
    NSArray*placeArray12=@[@"全部",@"德化中医院",@"德化县医院"];
    NSArray*placeArray13=@[@"全部"];
    
    
    
    NSArray*place=@[@{@"title":@"附近",@"data":placeArray1},@{@"title":@"丰泽区",@"data":placeArray2},@{@"title":@"鲤城区",@"data":placeArray3},@{@"title":@"晋江市",@"data":placeArray4},@{@"title":@"石狮市",@"data":placeArray5},@{@"title":@"南安市",@"data":placeArray6},@{@"title":@"惠安县",@"data":placeArray7},@{@"title":@"洛江区",@"data":placeArray8},@{@"title":@"安溪县",@"data":placeArray9},@{@"title":@"泉港区",@"data":placeArray10},@{@"title":@"永春县",@"data":placeArray11},@{@"title":@"德化县",@"data":placeArray12},@{@"title":@"金门县",@"data":placeArray13}];
    _data2=[NSMutableArray arrayWithArray:place];
    
    _data3=[NSMutableArray arrayWithObjects:@"智能排序",@"离我最近",@"好评优先",@"人气最高", nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, kScreen_Width, kScreen_Height-64-40) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    
    return _tableView;
}

-(NSMutableArray *)tableViewDatas{
    if (!_tableViewDatas) {
        _tableViewDatas=[NSMutableArray array];
    }
    
    return _tableViewDatas;
    
}

@end
