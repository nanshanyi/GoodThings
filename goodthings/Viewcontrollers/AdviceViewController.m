//
//  AdviceViewController.m
//  everyDay
//
//  Create by LiGuohuai on 15/10/10.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *adviceText;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.adviceText.layer.borderColor = kGrayColor.CGColor;
    self.adviceText.layer.cornerRadius = 5;
    self.adviceText.layer.borderWidth = 1;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sendButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

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

@end
