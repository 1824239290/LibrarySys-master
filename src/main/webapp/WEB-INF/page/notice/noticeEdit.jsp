<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>编辑公告</title>
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

    <input type="hidden" name="id" value="${notice.id}">

    <div class="layui-form-item">
        <label class="layui-form-label required">公告标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="title" minlength="1" maxlength="50" lay-verify="required"
                   lay-reqtext="公告标题不能为空"
                   placeholder="公告标题1-50字符，不能有空格" class="layui-input" value="${notice.title}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">公告内容</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入公告内容"  name="content" maxlength="255" class="layui-textarea" lay-verify="required" lay-reqtext="公告内容不能为空">${notice.content}</textarea>
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

        //公告标题是否重名
        $("#title").on("mouseleave", function () {
            const title = $("#title").val();
            if (/^[\S]{1,50}$/.test(title) == false) {
                layer.tips('公告标题1-50字符，不能有空格', '#title', {
                    tips: 1,
                    time: 1500
                });
                $("#title").val("");
            } else {
                if (title != null && title != '') {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/notice/titleExist",
                        type: "POST",
                        data: JSON.stringify(title),
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            if (data.code == 0) {
                                layer.tips('公告标题已存在,请重新输入!', '#title', {
                                    tips: 1,
                                    time: 1500
                                });
                                $("#title").val("");
                            }
                        }
                    });
                }
            }
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            const datas = data.field;
            $.ajax({
                url: "${pageContext.request.contextPath}/notice/editNotice",
                type: "POST",
                data: JSON.stringify(datas),
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.code == 1) {
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