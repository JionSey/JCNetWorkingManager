//
//  ViewController.m
//  JCNetWokingManager
//
//  Created by Jackie on 18/2/12.
//  Copyright © 2018年 Jackie. All rights reserved.
//

#import "ViewController.h"
#import "JCHomeService.h"

@interface ViewController ()

@property (nonatomic, strong) JCHomeService *homeService;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self requestStarPage];
}

- (void)requestStarPage {
    
    [self.homeService requestStartUpWithParameter:[JCHomeStarPageParameterModel new] Success:^(JCHomeStarPageResponseModel * responseModel, BOOL isCache) {
        NSLog(@"%@", responseModel);
    } failure:^(JCNetWorkingErrorResponseModel *responseModel) {
        NSLog(@"%@", responseModel);
    }];
}

- (JCHomeService *)homeService{
    if (!_homeService){
        _homeService = [JCHomeService new];
    }
    return _homeService;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
