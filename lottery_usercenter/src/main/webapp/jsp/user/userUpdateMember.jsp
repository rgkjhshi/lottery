<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker/WdatePicker.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/index.css">
<script language="javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
<script language="javascript">
	function checkSubmit() {
			$("#sForm").submit();
	}
	
	function checkChief(){
		$("#hmemberRate").val($("#memberRate").val());
	}
	
	function checkNum(moenyCount){
		var totalCredit = $("#totalCredit").val();    //總信用額度
		var available = $("#available").val();//可用額度
		<%Integer moneyCredit = (Integer)request.getAttribute("moneyCredit"); %>
		var hiddCredit = $("#checkCredit").val();//当前總信用額度
		var tempCredit = eval(totalCredit) - eval(hiddCredit);
		if(eval(tempCredit) >(eval(moenyCount)+eval(<%=moneyCredit%>))){
			alert("信用額度-超过剩下的額度--"+<%=moneyCredit%>);
			$("#totalCredit").val(hiddCredit);
		}
	}
	
	function checkNumType(){
		var totalCredit = $("#totalCredit").val();    //總信用額度
		var available = $("#available").val();//可用額度
		var countMoney = $("#countMoney").val();//剩下多少
		if(eval(totalCredit) > eval(countMoney)){
			alert("總信用額度-不能大于-可用信用額度-可用額还剩-"+countMoney);
			$("#totalCredit").val("");
		}
	}
	
	
</script>
<script language="javascript">
$(document).ready(function() {
	 
	
	$("#judge input[type!=hidden]").keyup(function(){     
        var tmptxt=$(this).val();     
       if($(this).val() != ""){
    	   $(this).val(tmptxt.replace(/[^\d.]/g,""));
	        $(this).val($(this).val().replace(/^\./g,""));  
	       $(this).val($(this).val().replace(/\.{2,}/g,"."));  
	       $(this).val($(this).val().replace(".","$#$").replace(/\./g,"").replace("$#$",".")); 
       }
      
    }).bind("paste",function(){     
        var tmptxt=$(this).val();     
        $(this).val(tmptxt.replace(/[^\d.]/g,""));     
    }).css("ime-mode", "disabled"); 
 
 
 $("#judge input[type!=hidden]").blur(function(){     
        var tmptxt=$(this).val();     
      var newName =  $(this).attr("name");
      var subName = newName.replace(/[\[|\]|\.]/g,"");
      var nameSpilt = newName.split(".");
      if(nameSpilt[1] =="commissionA" || nameSpilt[1] =="commissionB"  || nameSpilt[1] =="commissionC" ){
    	  if(eval($('#'+subName).val())<eval($(this).val())){
			  alert("不能设置大於当前的值--"+$('#'+subName).val());
			  $(this).val($('#'+subName).val());
		  }
      }
      if(nameSpilt[1] =="itemQuotas" || nameSpilt[1] =="bettingQuotas"){
    	  if(eval($('#'+subName).val())<eval($(this).val())){
			  alert("不能设置超过当前的值--"+$('#'+subName).val());
			  $(this).val($('#'+subName).val());
		  }
      }
    });
 
	 $("#moneyTotalCredit").val(<%=moneyCredit%>); //提示还剩多少信用額度
	 <%Integer rateFlag = (Integer)request.getAttribute("rateFlag");%>
	 if(eval(<%=rateFlag%>) == 0){
		$("#memberRate").attr("disabled","true");    //代理占成
		$("#hmemberRate").val($("#memberRate").val());
	 }
});
</script>
<html xmlns="http://www.w3.org/1999/xhtml">

<div class="content">
	<s:form id="sForm" action="%{pageContext.request.contextPath}/user/updateMember.action" method="post">
		<div class="main">
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="king2 xy pw">
				<tbody>
					<tr>
						<th colspan="2">会员修改</th>
					</tr>
					<tr>
						<td class="tr">上级用户</td>
						<td class="tl"><input type="text"
							value="${memberStaffExt.managerStaff.account}" name="memberStaffExt.managerStaff.account" readonly="readonly"></input>
							</td>
					</tr>
					<tr>
						<td class="tr" width="50%">用户名</td>
						<td class="tl" width="50%"><input type="text" value="${memberStaffExt.account}"
							maxlength="20" id="account" name="memberStaffExt.account" readonly="readonly"></input> <span
							id="accountAgain" style="color: #FF0000;"></span> <s:hidden
								id="verifyName" value="" /> <s:hidden
								name="memberStaffExt.userType" value="9" />
								<s:hidden name="memberStaffExt.memberStaffID" value="%{memberStaffExt.ID}"></s:hidden>
								</td>
					</tr>
					<tr>
						<td class="tr">密碼</td>
						<td class="tl"><input id="userPassword" type="password"
							value="" name="memberStaffExt.userPwd"></input></td>
					</tr>
					<s:if test="memberStaffExt.managerStaff.flag==1">
					<tr>
						<td class="tr">用户狀態</td>
						<td class="tl">
						<s:radio name="memberStaffExt.flag" list="#{'0':'有效','2':'冻结'}" label="狀態" disabled="true">
						</s:radio>
						<s:radio name="memberStaffExt.flag" list="#{'1':'禁用'}" label="狀態" value="1">
						</s:radio>
						</td>
					</tr>
					</s:if>
					<s:elseif test="memberStaffExt.managerStaff.flag==2">
						<tr>
							<td class="tr">用户狀態</td>
							<td class="tl">
							<s:radio name="memberStaffExt.flag" list="#{'0':'有效','1':'禁用'}" label="狀態" disabled="true">
							</s:radio>
							<s:radio name="memberStaffExt.flag" list="#{'2':'冻结'}" label="狀態" value="2">
							</s:radio>
							</td>
						</tr>
					</s:elseif>
					<s:else>
						<tr>
						<td class="tr">用户狀態</td>
						<td class="tl">
						<s:radio name="memberStaffExt.flag" list="#{'0':'有效','1':'禁用','2':'冻结'}" label="狀態">
						</s:radio>
						</td>
					</tr>
					</s:else>
					<tr>
						<td class="tr">代理占成</td>
						<td class="tl">
						<s:if test="memberStaffExt.rate==0">
						<s:select id="memberRate" name="rate" list="rateCount"  headerValue="不占成" headerKey="0" onchange="javascript:checkChief();">
						</s:select>
						<s:hidden id="hmemberRate" name="hmemberRate" value="0"></s:hidden>
						</s:if>
						<s:else>
							<s:select id="memberRate" name="rate" list="rateCount"  headerValue="%{memberStaffExt.rate}%" headerKey="%{memberStaffExt.rate}%" onchange="javascript:checkChief();">
							</s:select>
							<s:hidden id="hmemberRate" name="hmemberRate" value="%{memberStaffExt.rate}%"></s:hidden>
						</s:else>
						<span>修改占成时间是02:30:00至08：30：00</span>
						</td>
					</tr>
					<tr>
						<td class="tr">中文名字</td>
						<td class="tl"><input name="memberStaffExt.chsName"
							class="w176" type="text" value="${memberStaffExt.chsName}" /></input></td>
					</tr>
					<tr>
						<td class="tr">信用額度</td>
						<td class="tl"><input  onblur="javascript:checkNum('${memberStaffExt.totalCreditLine}');" id="totalCredit"  onafterpaste="this.value=this.value.replace(/\D/g,'')" onkeyup="this.value=this.value.replace(/\D/g,'')" value="${memberStaffExt.totalCreditLine}" name="memberStaffExt.totalCreditLine"
							class="w176" type="text" /></input><span  style="color: #FF0000;">可再增加的額度<input type="text" id="moneyTotalCredit" value="" readonly="readonly" style="border:none"></span></td>
						<s:hidden value="%{memberStaffExt.totalCreditLine}" id="checkCredit" ></s:hidden>
					</tr>
					<tr style="display: none">
						<td class="tr">可用信用額度</td>
						<td class="tl">
							<input id="available" name="memberStaffExt.availableCreditLine"
								class="w176" type="text" value="${memberStaffExt.availableCreditLine}" readonly="readonly"/></input>
						</td>
					</tr>
					<tr>
						<td class="tr">盘口</td>
						<td class="tl">
						<s:radio name="memberStaffExt.plate" list="#{'A':'A盘','B':'B盘','C':'C盘'}" label="盘口" >
						</s:radio>
						</td>
					</tr>
					<tr>
						<td class="tr">注册时间</td>
						<td class="tl"><s:date name="memberStaffExt.createDate"  format="yyyy-MM-dd HH:mm:ss" />
						<s:hidden name="memberStaffExt.createDate" value="%{memberStaffExt.createDate}"></s:hidden>
						</td>
					</tr>
				</tbody>
			</table>
			<table id="judge" class="king2 xy pw">
			<tr>
				<th align="center"  colspan="6">廣東快樂十分</th>
			</tr>
			<tr>
				<td width="254" height="23"  align="center"><span
					class="STYLE2">類型</span></td>
				<td width="254" height="23"  align="center">佣金%A</td>
				<td width="254" height="23"  align="center">佣金%B</td>
				<td width="254" height="23"  align="center">佣金%C</td>
				<td width="254" height="23"  align="center">單注限額</td>
				<td width="254" height="23"  align="center">單项(号)限額</td>
			</tr>
			<s:iterator value="commissions" status="sta">
			<s:if test="playType==1">
				<tr>
					<td height="20" align="center" >${playFinalTypeName} <input
						name="commissions[${sta.index}].playFinalType" type="hidden" id=""
						value="${playFinalType}"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionA" class="input1" id=""
						value='${commissionA}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionB" class="input1" id=""
						value='${commissionB}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionC" class="input1" id=""
						value='${commissionC}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].bettingQuotas" class="input1" id=""
						value='${bettingQuotas}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].itemQuotas" class="input1" id=""
						value='${itemQuotas}' size="10"></input>
						<input type="hidden" name="commissions[${sta.index}].playType" value="${playType }"></input>
					<input type="hidden" name="commissions[${sta.index}].createTime" value="${createTime}"></input>
					<input type="hidden" name="commissions[${sta.index}].ID" value="${ID}"></input>
					<input type="hidden" name="commissions[${sta.index}].userType" value="${userType}"></input>
					<input type="hidden" name="commissions[${sta.index}].userId" value="${userId}"></input>
					</td>
				</tr>
			</s:if>
				</s:iterator>
				
			<tr>
				<th align="center"  colspan="6">重慶時時彩</th>
			</tr>
			<s:iterator value="commissions" status="sta">
			<s:if test="playType==2">
				<tr>
					<td height="20" align="center" >${playFinalTypeName} <input
						name="commissions[${sta.index}].playFinalType" type="hidden" id=""
						value="${playFinalType}"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionA" class="input1" id=""
						value='${commissionA}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionB" class="input1" id=""
						value='${commissionB}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionC" class="input1" id=""
						value='${commissionC}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].bettingQuotas" class="input1" id=""
						value='${bettingQuotas}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].itemQuotas" class="input1" id=""
						value='${itemQuotas}' size="10"></input>
						<input type="hidden" name="commissions[${sta.index}].playType" value="${playType }"></input>
					<input type="hidden" name="commissions[${sta.index}].createTime" value="${createTime}"></input>
					<input type="hidden" name="commissions[${sta.index}].ID" value="${ID}"></input>
					<input type="hidden" name="commissions[${sta.index}].userType" value="${userType}"></input>
					<input type="hidden" name="commissions[${sta.index}].userId" value="${userId}"></input>
					</td>
					
				</tr>
			</s:if>
				</s:iterator>
				
			<tr>
				<th align="center"  colspan="6">北京賽車(PK10)</th>
			</tr>
			<s:iterator value="commissions" status="sta">
			<s:if test="playType==4">
				<tr>
					<td height="20" align="center" >${playFinalTypeName} <input
						name="commissions[${sta.index}].playFinalType" type="hidden" id=""
						value="${playFinalType}"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionA" class="input1" id=""
						value='${commissionA}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionB" class="input1" id=""
						value='${commissionB}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionC" class="input1" id=""
						value='${commissionC}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].bettingQuotas" class="input1" id=""
						value='${bettingQuotas}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].itemQuotas" class="input1" id=""
						value='${itemQuotas}' size="10"></input>
						<input type="hidden" name="commissions[${sta.index}].playType" value="${playType }"></input>
					<input type="hidden" name="commissions[${sta.index}].createTime" value="${createTime}"></input>
					<input type="hidden" name="commissions[${sta.index}].ID" value="${ID}"></input>
					<input type="hidden" name="commissions[${sta.index}].userType" value="${userType}"></input>
					<input type="hidden" name="commissions[${sta.index}].userId" value="${userId}"></input>
					</td>
					
				</tr>
			</s:if>
				</s:iterator>

			<tr>
				<th align="center"  colspan="6">香港六合彩</th>
			</tr>
			<s:iterator value="commissions" status="sta">
						<s:if test="playType==3">
				<tr>
					<td height="20" align="center" >${playFinalTypeName} <input
						name="commissions[${sta.index}].playFinalType" type="hidden" id=""
						value="${playFinalType}"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionA" class="input1" id=""
						value='${commissionA}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionB" class="input1" id=""
						value='${commissionB}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].commissionC" class="input1" id=""
						value='${commissionC}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].bettingQuotas" class="input1" id=""
						value='${bettingQuotas}' size="10"></input>
					</td>
					<td align="center" ><input
						name="commissions[${sta.index}].itemQuotas" class="input1" id=""
						value='${itemQuotas}' size="10"></input>
						<input type="hidden" name="commissions[${sta.index}].playType" value="${playType }"></input>
					<input type="hidden" name="commissions[${sta.index}].createTime" value="${createTime}"></input>
					<input type="hidden" name="commissions[${sta.index}].ID" value="${ID}"></input>
					<input type="hidden" name="commissions[${sta.index}].userType" value="${userType}"></input>
					<input type="hidden" name="commissions[${sta.index}].userId" value="${userId}"></input>
					</td>
					
				</tr>
			</s:if>
				</s:iterator>
			
			
			
			
			<s:iterator value="commissionsList" status="sta">
			<s:if test="playType==1">
				<tr style="display:none">
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionA" id="commissions${sta.index}commissionA" value="${commissionA}"></input>	
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionB" id="commissions${sta.index}commissionB" value="${commissionB}"></input>		
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionC" id="commissions${sta.index}commissionC" value="${commissionC}"></input>			
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}bettingQuotas" id="commissions${sta.index}bettingQuotas" value="${bettingQuotas}"></input>				
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}itemQuotas" id="commissions${sta.index}itemQuotas" value="${itemQuotas}"></input>	
					</td>
				</tr>
			</s:if>
				</s:iterator>
			<s:iterator value="commissionsList" status="sta">
			<s:if test="playType==2">
				<tr style="display:none"> 
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionA" id="commissions${sta.index}commissionA" value="${commissionA}"></input>	
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionB" id="commissions${sta.index}commissionB" value="${commissionB}"></input>		
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionC" id="commissions${sta.index}commissionC" value="${commissionC}"></input>			
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}bettingQuotas" id="commissions${sta.index}bettingQuotas" value="${bettingQuotas}"></input>				
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}itemQuotas" id="commissions${sta.index}itemQuotas" value="${itemQuotas}"></input>	
					</td>
				</tr>
			</s:if>
				</s:iterator>
				
			<s:iterator value="commissionsList" status="sta">
			<s:if test="playType==4">
				<tr style="display:none"> 
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionA" id="commissions${sta.index}commissionA" value="${commissionA}"></input>	
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionB" id="commissions${sta.index}commissionB" value="${commissionB}"></input>		
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionC" id="commissions${sta.index}commissionC" value="${commissionC}"></input>			
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}bettingQuotas" id="commissions${sta.index}bettingQuotas" value="${bettingQuotas}"></input>				
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}itemQuotas" id="commissions${sta.index}itemQuotas" value="${itemQuotas}"></input>	
					</td>
				</tr>
			</s:if>
				</s:iterator>

			<s:iterator value="commissionsList" status="sta">
						<s:if test="playType==3">
				<tr style="display:none">
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionA" id="commissions${sta.index}commissionA" value="${commissionA}"></input>	
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionB" id="commissions${sta.index}commissionB" value="${commissionB}"></input>		
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}commissionC" id="commissions${sta.index}commissionC" value="${commissionC}"></input>			
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}bettingQuotas" id="commissions${sta.index}bettingQuotas" value="${bettingQuotas}"></input>				
					</td>
					<td align="center" >
					<input type="hidden" name="commissions${sta.index}itemQuotas" id="commissions${sta.index}itemQuotas" value="${itemQuotas}"></input>	
					</td>
				</tr>
			</s:if>
				</s:iterator>	

			</table>    
			<div class="tj">
				<input type="button" value="確認" class="btn_4" name=""
					onclick="checkSubmit();"></input>
			</div>
		</div>
	</s:form>
</div>
</html>
