//
//  DetailViewController.m
//  goodthings
//
//  Create by  on 15/10/13.
//  Copyright (c) 2015年 LiGuohuai. All rights reserved.
//

#import "DetailViewController.h"
#import "NetEngine.h"
@interface DetailViewController ()

@property (nonatomic,strong)UIView *webBrowserView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIImageView *backHeadImageView;

@end
int a = 0;
@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.backgroundColor = [UIColor clearColor];
    [self creatWebView];
    if (self.dataUrl) {
        [self fetchData];
    }
    // Do any additional setup after loading the view.
}

- (void)fetchData{
    
    [[NetEngine sharedInstance] requestNewsListFrom:_dataUrl success:^(id responsData) {
        NSString *str = responsData[@"data"][@"content"];
        self.giftDetailUrl = str;
        self.introduction = responsData[@"data"][@"introduction"];
        self.title = responsData[@"data"][@"title"];
        [self webViewAddHeadViewWithType:1];
       [self.webView loadHTMLString:self.giftDetailUrl baseURL:nil];
    } falied:^(NSError *error) {
    
    }];
}
- (void)creatWebView{
    if (self.detailUrl) {
        NSURL *url = [NSURL URLWithString:self.detailUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
         [self.webView loadRequest:request];
        [self webViewAddHeadViewWithType:0];
    }else if (self.giftDetailUrl){
        [self webViewAddHeadViewWithType:1];
//        [self.webView loadHTMLString:self.giftDetailUrl baseURL:nil];
    }
 
    
}
- (void)webViewAddHeadViewWithType:(NSInteger)Type{
    self.webBrowserView = self.webView.scrollView.subviews[0];
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    self.backHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/3.0)];
    [_backHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [self.webView insertSubview:_backHeadImageView belowSubview:self.webView.scrollView];
    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/3.0);
    if (Type == 1) {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 25, 10, kScreenWidth*1/5.0-30)];
        lineView.backgroundColor = [UIColor blackColor];
        [view addSubview:lineView];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, kScreenWidth-50, kScreenWidth*1/5.0)];
        lable.text = _introduction;
        lable.numberOfLines = 0;
        lable.font = [UIFont boldSystemFontOfSize:24];
        [view addSubview:lable];
        view.frame = CGRectMake(0, kScreenWidth*2/3.0, kScreenWidth, CGRectGetMaxY(lable.frame));
        view.backgroundColor = [UIColor whiteColor];
    }
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(view.frame);
    self.webBrowserView.frame = frame;
    [self.webView.scrollView addSubview:view];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = [NSString stringWithFormat:@"%@",request];
    NSLog(@"<%d>%@",a++,request);
    NSString *str = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    if (self.giftDetailUrl) {
        return YES;
    }
    if ([url rangeOfString:@"content"].length > 0) {
        return YES;
    }else if([url containsString:@"skipCon"]&&(url.length > 9)){
        NSArray * array = [url componentsSeparatedByString:@"skipCon/:"];
        NSString *str =[array lastObject];
        NSString *articleId = [str substringWithRange:NSMakeRange(4, str.length-6)];
        DetailViewController *viewController = [[DetailViewController alloc]init];
        viewController.detailUrl = [NSString stringWithFormat:kArticleDetailUrl,articleId];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (([url rangeOfString:@"setCon"].length > 0) &&(url.length > 9)){
        NSArray * array = [str componentsSeparatedByString:@"setCon/:"];
        NSString *string  = [array lastObject];
        NSString *str =[string substringWithRange:NSMakeRange(0, string.length-1)];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
          NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [_backHeadImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        self.title = dic[@"title"];
        return YES;
    }else{
        return NO;
    }
    return YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.loadingView removeLoadingView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    CGPoint offSet = scrollView.contentOffset;
    CGFloat change = offSet.y;
    if (offSet.y < 0) {
//        NSLog(@"%f",self.backHeadImageView.frame.origin.y);
        CGSize size = CGSizeMake(kScreenWidth-change, kScreenWidth*2/3.f-change);
        self.backHeadImageView.frame = CGRectMake(0, 0, size.width , size.height);
        self.backHeadImageView.center = CGPointMake(kScreenWidth/2.f, size.height/2.f);
    }else{
        self.backHeadImageView.center = CGPointMake(kScreenWidth/2.f, (kScreenWidth*2/3.f)/2.f-change);
    }
    NSLog(@"%f",offSet.y);
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
