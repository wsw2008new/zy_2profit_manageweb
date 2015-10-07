<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../common/common.jsp" %>

<%@ include file="../common/common_html_validator.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>付款编辑</title>

<link rel="stylesheet" href="${ctx }/static/css/lgl.css"  type="text/css">

<script type="text/javascript">

$(function(){
	
	var type = '${type}';
	
	$('#myForm').validator({
		fields : {
			tradeId : 'required',
			account : 'required',
			amount : 'required;integer[+]',
			payType : 'required',
			curType : 'required',
			applierId : 'required'
		},
		valid : function(form){
			layer.load();
			$(form).ajaxSubmit({
				url : '${ctx }/fund/ajax/pay/submit',
				async : false,
				success : function(result){
					layer.closeAll('loading');
					if(result.success){
						if(type == 'add'){
							layer.alert('添加成功', function(){
								window.location.href = '${ctx}/fund/pay/list';
							});
						}else if(type == 'update'){
							layer.alert('修改成功', function(){
								window.location.href = '${ctx}/fund/pay/list';
							});
						}
						
					}else{
						layer.alert(result.msg);
					}
				}
			});
		}
	});
	
});

function mySubmit(){
	$('#myForm').submit();
}

</script>

</head>
<body>

	<div class="l_main">
		<div class="l_titleBar">
			<div class="l_text">
				添加付款
			</div>
		</div>
		<form id="myForm" method="post">
		<div class="l_form mgt20">
			<input type="hidden" name="type" value="${type }"/>
			<input type="hidden" name="id" value=""/>
			<table>
				<tbody>
					<c:if test="${type ne 'add' }">
						<tr>
							<td class="f_title wd200">提案号：</td>
							<td class="f_content">
								<label>123</label>
							</td>
						</tr>
					</c:if>
					<tr>
						<td class="f_title wd200">交易号：</td>
						<td class="f_content">
							<input type="text" name="tradeId"/>
						</td>
					</tr>
					<tr>
						<td class="f_title">账号：</td>
						<td class="f_content">
							<input type="text" name="account">
						</td>
					</tr>
					<tr>
						<td class="f_title">存款金额：</td>
						<td class="f_content">
							<input type="text" name="amount"/>
						</td>
					</tr>
					<tr>
						<td class="f_title">存款途经：</td>
						<td class="f_content">
							<select name="payType">
								<option value="3">人工添加</option>
								<option value="0">支付宝</option>
								<option value="1">微信</option>
								<option value="2">银行</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="f_title">账号货币：</td>
						<td class="f_content">
							<select name="curType">
								<option value="">请选择</option>
								<option value="0">虚拟币</option>
								<option value="1">真实币</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="f_title">提案人：</td>
						<td class="f_content">
							<select name="applierId">
								<option value="">请选择</option>
								<c:forEach items="${users }" var="u">
									<option value="${u.id }">${u.realName }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</form>
		
		<div class="l_btnGrounp mgt20">
			<a class="b_btn" href="javascript:mySubmit();">保存</a>
			<a class="b_btn gray" href="${ctx }/fund/pay/list">返回</a>
		</div>
		
	</div>

</body>
</html>