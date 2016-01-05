package com.fami2u.plugin.alipay;

/**
 * 支付结果
 * 
 * @author yy
 * 
 */
public class PayResult {
	
	/**
	 * 返回状态
	 */
	private String resultStatus;
	
	/**
	 * 结果 
	 */
	private String result;
	
	/**
	 * 备忘录
	 */
	private String memo;

	public PayResult(String rawResult) {
		
		String[] resultParams = rawResult.split(";");
		
		for (String resultParam : resultParams) {
		
			if (resultParam.startsWith("resultStatus")) {
			
				resultStatus = gatValue(resultParam, "resultStatus");
				
				continue;
				
			}
			
			if (resultParam.startsWith("result")) {

				result = gatValue(resultParam, "result");
			
				continue;
				
			}
			
			if (resultParam.startsWith("memo")) {
			
				memo = gatValue(resultParam, "memo");
				
				continue;
				
			}
		}
	}
	
	@Override
	public String toString() {
		if(resultStatus=="9000"){
			return String.format("支付成功");
		}else{
			return String.format("支付失败");
		}
	
	}

	private String gatValue(String content, String key) {
		
		String prefix = key + "={";
		
		return content.substring(content.indexOf(prefix) + prefix.length() , content.lastIndexOf("}"));
	}
	
}
