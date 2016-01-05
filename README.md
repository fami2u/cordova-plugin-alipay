# cordova-plugin-alipay
  支付宝cordova插件

## 贡献者
[贡献者](https://github.com/fami2u/cordova-plugin-alipay/graphs/contributors)
- [@qintengfei]()集成及js部分
- [@lirubing]()ios部分
- [@suiyueanhao]()Android部分

## Usage

```
Alipay.pay(
        {
                tradeNo: "145188769195998",
                subject: "测试标题",
                body: "我是测试内容",
                price: 0.02,
                notifyUrl: "notifyUrl",
                appScheme:'appScheme'
            },
            function(errorMsg) {
                alert(errorMsg);
            },
            function(errorMsg) {
                alert(errorMsg);
  });
  ```
## 依赖

##appScheme 解决方案

参照：https://github.com/EddyVerbruggen/Custom-URL-scheme

`cordova plugin add https://github.com/EddyVerbruggen/LaunchMyApp-PhoneGap-Plugin.git --variable URL_SCHEME=appScheme`

## Developer Resources
- [cordova插件开发规范](http://cordova.apache.org/docs/en/latest/guide/hybrid/plugins/index.html)
- [支付宝sdk](https://openhome.alipay.com/doc/docIndex.htm?url=https://openhome.alipay.com/doc/viewKbDoc.htm?key=236698_261849&type=info)
- [example](https://github.com/apache/cordova-plugin-splashscreen)

## 协议

[MIT](http://opensource.org/licenses/MIT)

