/********* alipay.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "Product.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AlipayPlugin : CDVPlugin 
@property(nonatomic,strong)NSString *partner;
@property(nonatomic,strong)NSString *seller;
@property(nonatomic,strong)NSString *privateKey;
@property(nonatomic,strong)NSString *currentCallbackId;


- (void) pay:(CDVInvokedUrlCommand*)command;
@end

@implementation AlipayPlugin
-(void)pluginInitialize{
    CDVViewController *viewController = (CDVViewController *)self.viewController;
    self.partner = [viewController.settings objectForKey:@"partner"];
    self.seller = [viewController.settings objectForKey:@"seller"];
    self.privateKey = [viewController.settings objectForKey:@"private_key"];
}
- (void) pay:(CDVInvokedUrlCommand*)command
{    
    //partner和seller获取失败,提示
    if ([self.partner length] == 0 ||
        [self.seller length] == 0 ||
        [self.privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSMutableDictionary *args = [command argumentAtIndex:0];
    NSString   *tradeId  = [args objectForKey:@"tradeNo"];
    NSString   *subject  = [args objectForKey:@"subject"];
    NSString   *body     = [args objectForKey:@"body"];
    NSString   *price    = [args objectForKey:@"price"];
    NSString   *notifyUrl    = [args objectForKey:@"notifyUrl"];
    NSString   *appScheme    = [args objectForKey:@"appScheme"];
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = self.partner;
    order.seller = self.seller;
    
    order.tradeNO = tradeId; //订单ID（由商家自行制定）
    order.productName = subject; //商品标题
    order.productDescription = body; //商品描述
    order.amount = price; //商品价格
    order.notifyURL = notifyUrl; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    // NSString *appScheme = appScheme;

    
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(self.privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            
            NSString * result = [resultDic objectForKey:@"result"];
            
            if([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"] && [result containsString:@"&success=\"true\"&"]){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"付款成功"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                return;
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"付款失败"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil];
                [alert show];
                return;
                
            }
            
        }];
    }
    
}

@end
