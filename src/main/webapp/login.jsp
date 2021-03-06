<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title></title>
    <link href="favicon.ico" mce_href="favicon.ico" rel="icon" type="image/x-icon" />
    <link href="favicon.ico" mce_href="favicon.ico" rel="bookmark" type="image/x-icon" /> 
	<link href="favicon.ico" mce_href="favicon.ico" rel="shortcut icon" type="image/x-icon" />
    
	<link rel="stylesheet" type="text/css" href="Ext/build/classic/theme-neptune/resources/theme-neptune-all.css">
	
	<script language="javascript" type="text/javascript" src="Ext/build/ext-all.js"></script>
    <script language="javascript" type="text/javascript" src="Ext/build/classic/locale/locale-zh_CN.js"></script>
	
  </head>
  
  <body>
	  <script language="javascript" type="text/javascript">  
	  	Ext.onReady(function(){
			Ext.create('Ext.window.Window',{
				viewModel:Ext.create("app.view.ViewModel",{url:"configAction/getConfig.action"}),
				header:{hidden:true},
				width:450,
				height:250,
				modal:true,
				titleAlign:"center",
				closable:false,
				resizable:false,
				autoShow:true,
				buttonAlign:"center",
				border:false,
				defaults:{border:false},
				buttons:[{
					text:'登录',
					name:"submitButton",
					listeners:{
						click:function(button){
							var formPanel=button.up("window").down("form");
							if(formPanel.getForm().isValid()){
								formPanel.submit();
							}else{
								button.up("window").down("panel[name='errMsgPanel']").update('请填写用户名和密码');
							}
						}	
					}
				}],
				items:[{
					height:60,
					bodyStyle:{"background":"url(images/main/banner.jpg)","background-size":"100% 100%"},
					items:[{
						xtype:"image",
						src:'images/main/logo.png',
						height:50,
						margin:5,
						style:"display:block;float:left"
					},{
						xtype:"label",
						bind: {text:"{systemName}登录"},
						style:"font-size:20px;line-height: 50px;display:block;float:left;height:50px;margin:5px;font-weight:bold;color:#fff;"
					}]
				},{
					xtype:"form",
					standardSubmit:true,
					bodyPadding:"30 0 0 40",
					url:"login",
					bodyStyle:{"background":"none"},
					items:[{
						xtype:"hidden",
						name:"${_csrf.parameterName}",
						value:"${_csrf.token}"
					},{
						xtype:"textfield",
						labelAlign:"right",
						fieldLabel:"用户名",
						name:"username",
						allowBlank:false,
						labelWidth:60,
						width:320,
						labelStyle:"font-weight:bold",
						emptyText:'请输入用户名'
					},{
						xtype:"textfield",
						inputType:'password',
						style:"margin-top:15px",
						labelAlign:"right",
						fieldLabel:"密码",
						name:"password",
						allowBlank:false,
						labelWidth:60,
						width:320,
						labelStyle:"font-weight:bold",
						emptyText:'请输入密码',
						enableKeyEvents:true,
						listeners:{
							keyup:function(cmp,e,obj){
								var button=cmp.up("window").down("button[name='submitButton']");
								if(e.getKey()==Ext.EventObject.ENTER)button.fireEvent("click",button);
							}	
						}
					}]
				},{
						xtype:"panel",
						name:"errMsgPanel",
						border:false,
						padding:"5",
						bodyStyle:{"background":"none","color":"red","text-align":"center","font-weight":"bold","font-size":"14px"},
						html:"${SPRING_SECURITY_LAST_EXCEPTION}"
				}],
				listeners:{
					show:function(cmp,e){
						cmp.down("textfield[name='username']").focus();
					}	
				}
			});
	  	});
	  </script>
  </body>
</html>