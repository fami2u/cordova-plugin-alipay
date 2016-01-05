module.exports = {
    pay: function (paymentInfo, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Alipay", "pay", [paymentInfo]);
    }
};