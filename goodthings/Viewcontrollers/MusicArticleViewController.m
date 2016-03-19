//
//  MusicArticleViewController.m
//  goodthings
//
//  Create by  on 15/10/14.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "MusicArticleViewController.h"
#import "MusicPlayerViewController.h"
@interface MusicArticleViewController ()<UIWebViewDelegate>
{
    NSInteger _index;
    NSString *_musicId;
}
@property (nonatomic,strong)NSDictionary *musicDic;

@end

@implementation MusicArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatWebView];
    // Do any additional setup after loading the view.
}

- (void)musicPlayer{
    [self presentViewController:[MusicPlayerViewController shareInstance] animated:YES completion:nil];
}
- (void)creatWebView{
        NSURL *url = [NSURL URLWithString:self.musicPageUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [NSString stringWithFormat:@"%@",request];
    NSString *str = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    if ([url rangeOfString:@"content"].length > 0) {
        return YES;
    }else if([url containsString:@"skipCon"]&&(url.length > 9)){
        NSArray * array = [url componentsSeparatedByString:@"skipCon/:"];
        NSString *str =[array lastObject];
        NSString *string = [str substringToIndex:str.length-1];
        NSString *articleId = [string substringFromIndex:4];
        MusicArticleViewController *viewController = [[MusicArticleViewController alloc]init];
        viewController.musicPageUrl = [NSString stringWithFormat:kMusicDetailUrl,[articleId integerValue    ]];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (([url rangeOfString:@"setCon"].length > 0) &&(url.length > 9)){
        NSArray * array = [str componentsSeparatedByString:@"setCon/:"];
        NSString *string  = [array lastObject];
        NSString *str =[string substringWithRange:NSMakeRange(0, string.length-1)];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        self.musicDic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.title = self.musicDic[@"title"];
        return YES;
      
    }else if ([url rangeOfString:@"skinMusic"].length > 0){

        [[MusicPlayerViewController shareInstance] playMusicWithMusicId:self.musicDic];
        [MusicPlayerViewController shareInstance].isPlaying = YES;
  
    }else{
        return NO;
    }
    return NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.loadingView removeLoadingView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingView removeLoadingView];
    
    NSMutableString *js0 = [NSMutableString string];
    [js0 appendString:@"var ad = document.getElementsByClassName('desc fcolor3')[0];"];
    [js0 appendString:@"ad.parentNode.removeChild(ad);"];
    [webView stringByEvaluatingJavaScriptFromString:js0];
    
    NSMutableString *js = [NSMutableString string];
    [js appendString:@"var ad = document.getElementsByClassName('good_info blowimg')[0];"];
    [js appendString:@"ad.parentNode.removeChild(ad);"];
    [webView stringByEvaluatingJavaScriptFromString:js];
    
    NSMutableString *js1 = [NSMutableString string];
    [js1 appendString:@"var user = document.getElementById('btn');"];
    [js1 appendString:@"user.parentNode.removeChild(user);"];
    [webView stringByEvaluatingJavaScriptFromString:js1];
    
    NSMutableString *js2 = [NSMutableString string];
    [js2 appendString:@"var user = document.getElementById('command');"];
    [js2 appendString:@"user.parentNode.removeChild(user);"];
    [webView stringByEvaluatingJavaScriptFromString:js2];
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
