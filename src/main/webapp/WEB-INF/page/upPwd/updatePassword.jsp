<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-form layuimini-form">
            <div class="layui-form-item">
                <label class="layui-form-label required">旧密码</label>
                <div class="layui-input-block">
                    <input type="password" name="oldPassword" id="oldPassword" lay-verify="required|pass" lay-reqtext="旧密码不能为空" placeholder="请输入旧密码" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">新密码</label>
                <div class="layui-input-block">
                    <input type="password" name="newPassword" id="newPassword" lay-verify="required|pass" lay-reqtext="新密码不能为空" placeholder="请输入新密码" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">再次输入新密码</label>
                <div class="layui-input-block">
                    <input type="password" name="newPassword1" id="newPassword1" lay-verify="required|pass" lay-reqtext="新密码不能为空" placeholder="请再次输入新密码" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">立即修改</button>
                </div>
            </div>

        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form','miniTab'], function () {
        const form = layui.form,
            layer = layui.layer,
            miniTab = layui.miniTab,
            $ = layui.$;

        //自定义验证规则
        form.verify({
            pass: [
                /^[\S]{6,16}$/, '密码必须6-16位字符，且不能出现空格'
            ]
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            const datas = data.field;
            if (datas.newPassword != datas.newPassword1){
                layer.msg("两次输入的新密码不一致,请重新输入",{
                   icon: 2,
                   time: 1500
                });
            }else{
                $.ajax({
                    url:"updatePassword",
                    type:"POST",
                    data: {oldPassword:datas.oldPassword,newPassword1:datas.newPassword1},
                    success:function(data){
                        if(data.code === 1){
                            var index = layer.msg('修改成功!', {
                                icon: 6,
                                time: 1500
                            }, function() {
                                layer.close(index);
                                miniTab.deleteCurrentByIframe();
                            });
                        }else{
                            layer.msg(data.msg);
                            $("#oldPassword").val("");
                            $("#newPassword").val("");
                            $("#newPassword1").val("");
                        }
                    }
                });
            }
            return false;
        });

    });
</script>
</body>
</html>