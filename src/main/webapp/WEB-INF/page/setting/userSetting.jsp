<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>基本资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {
            width: auto;
            padding-right: 10px;
            line-height: 38px;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <input type="hidden" name="id" value="${user.id}">

        <div class="layui-form layuimini-form">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="username" value="${user.username}" class="layui-input" readonly="true">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">真实姓名</label>
                <div class="layui-input-block">
                    <input type="text" name="realName" id="realName" minlength="2" maxlength="4" placeholder="真实姓名只能为2-4个汉字"
                           class="layui-input" lay-verify="required|name" lay-reqtext="真实姓名不能为空" value="${user.realName}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">性别</label>
                <div class="layui-input-block">
                    <input type="text" name="sex" id="sex" maxlength="1" lay-verify="required|sex" lay-reqtext="性别不能为空"
                           placeholder="性别只能为男或女" class="layui-input" value="${user.sex}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-block">
                    <input type="text" name="birthday" id="date" placeholder="请选择出生日期" class="layui-input"
                           value="<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/>" lay-verify="required" lay-reqtext="出生日期不能为空">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-block">
                    <input type="text" name="address" id="address" maxlength="50" placeholder="请输入地址(可为空)" class="layui-input"
                           value="${user.address}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">手机号</label>
                <div class="layui-input-block">
                    <input type="tel" name="tel" id="tel" lay-verify="tel" maxlength="11" placeholder="请输入手机号(可为空)"
                           class="layui-input" value="${user.tel}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-block">
                    <input type="text" name="email" id="email" lay-verify="emails" maxlength="30" placeholder="请输入邮箱(可为空)"
                           class="layui-input" value="${user.email}">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">借书卡号</label>
                <div class="layui-input-block">
                    <input type="text" name="libraryCard" class="layui-input" value="${user.libraryCard}" readonly="true">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
                </div>
            </div>

        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form', 'miniTab','laydate'], function () {
        const $ = layui.jquery,
            form = layui.form,
            layer = layui.layer,
            laydate = layui.laydate,
            miniTab = layui.miniTab;

        //墨绿主题日期选择器
        laydate.render({
            elem: '#date',
            theme: 'molv'
        });

        //自定义验证规则
        form.verify({
            sex: function (value) {
                if (value.indexOf("男") === -1 && value.indexOf("女") === -1) {
                    return "性别只能为男或女";
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
                url: "userSetting",
                type: "POST",
                data: JSON.stringify(datas),
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.code === 1) {
                        var index = layer.msg('保存成功!', {
                            icon: 6,
                            time: 2000
                        }, function() {
                            layer.close(index);
                            miniTab.deleteCurrentByIframe();
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
