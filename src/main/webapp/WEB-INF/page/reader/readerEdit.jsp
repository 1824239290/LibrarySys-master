<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑读者</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div class="layui-form layuimini-form">

    <input type="hidden" name="id" value="${user.id}">

    <div class="layui-form-item">
        <label class="layui-form-label required">用户名</label>
        <div class="layui-input-block">
            <input type="text" name="username" id="username" minlength="1" maxlength="6" lay-verify="required"
                   lay-reqtext="用户名不能为空"
                   placeholder="用户名1-6字符，不能有空格" class="layui-input" value="${user.username}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">真实姓名</label>
        <div class="layui-input-block">
            <input type="text" name="realName" minlength="2" maxlength="4" placeholder="真实姓名只能为2-4个汉字"
                   class="layui-input"
                   lay-verify="required|name" lay-reqtext="真实姓名不能为空" value="${user.realName}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">性别</label>
        <div class="layui-input-block">
            <input type="radio" name="sex"  value="男" title="男"  ${"男" eq user.sex ?"checked='checked'":''}>
            <input type="radio" name="sex"  value="女" title="女"  ${"女" eq user.sex ?"checked='checked'":''}>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">出生日期</label>
        <div class="layui-input-block">
            <input type="text" name="birthday" id="date" placeholder="请选择出生日期(可为空)" class="layui-input" value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/>" lay-verify="required" lay-reqtext="出生日期不能为空">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">地址</label>
        <div class="layui-input-block">
            <input type="text" name="address" maxlength="50" placeholder="请输入地址(可为空)" class="layui-input" value="${user.address}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">手机号</label>
        <div class="layui-input-block">
            <input type="tel" name="tel" lay-verify="tel" maxlength="11" placeholder="请输入手机号(可为空)"
                   class="layui-input" value="${user.tel}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">邮箱</label>
        <div class="layui-input-block">
            <input type="text" name="email" lay-verify="emails" maxlength="30" placeholder="请输入邮箱(可为空)"
                   class="layui-input" value="${user.email}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">用户状态</label>
        <div class="layui-input-block">
            <input type="radio" name="userStatus" value="1" title="正常" ${"1" eq user.userStatus ?"checked='checked'":''}>
            <input type="radio" name="userStatus" value="0" title="冻结" ${"0" eq user.userStatus ?"checked='checked'":''}>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">立即修改</button>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form','laydate'], function () {
        const form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            $ = layui.$;

        //墨绿主题日期选择器
        laydate.render({
            elem: '#date',
            theme: 'molv'
        });

        //查询用户是否重名
        $("#username").on("mouseleave", function () {
            const username = $("#username").val();
            if (/^[\S]{1,6}$/.test(username) === false) {
                layer.tips('用户名必须1-6位字符，且不能出现空格', '#username', {
                    tips: 1,
                    time: 1500
                });
                $("#username").val("");
            } else {
                if (username != null && username != '') {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/userExist",
                        type: "POST",
                        data: JSON.stringify(username),
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            if (data.code === 0) {
                                layer.tips('用户名已存在,请重新输入!', '#username', {
                                    tips: 1,
                                    time: 1500
                                });
                                $("#username").val("");
                            }
                        }
                    });
                }
            }
        });

        //自定义验证规则
        form.verify({
            tel: function (value) {
                if (value != null && value != '') {
                    if (/^1\d{10}$/.test(value) === false) {
                        return "请输入正确的手机号";
                    }
                }
            },
            emails: function (value) {
                if (value != null && value != '') {
                    if (/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value) === false) {
                        return "邮箱格式不正确";
                    }
                }
            },
            name: [
                /^[\u4e00-\u9fa5]{2,4}$/, '真实姓名只能为2-4个汉字'
            ]
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            const datas = data.field;
            $.ajax({
                url: "${pageContext.request.contextPath}/reader/editReader",
                type: "POST",
                data: JSON.stringify(datas),
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('更新成功！', {
                            icon: 6,
                            time: 1500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                }
            });
            return false;
        });

    });
</script>
</body>
</html>