<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>修改书籍类型</title>
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

    <input type="hidden" name="id" value="${bookType.id}">

    <div class="layui-form-item">
        <label class="layui-form-label required">图书类型名称</label>
        <div class="layui-input-block">
            <input type="text" name="typeName" id="typeName" minlength="1" maxlength="16" lay-verify="required"
                   lay-reqtext="图书类型名称不能为空"
                   placeholder="图书类型名称1-16字符，不能有空格" class="layui-input" value="${bookType.typeName}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">图书类型备注</label>
        <div class="layui-input-block">
            <input type="text" name="remark" maxlength="255" placeholder="请输入图书类型备注(可为空)"
                   class="layui-input" value="${bookType.remark}">
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

        //图书类型名是否重名
        $("#typeName").on("mouseleave", function () {
            const typeName = $("#typeName").val();
            if (/^[\S]{1,16}$/.test(typeName) == false) {
                layer.tips('图书类型名称1-16字符，不能有空格', '#typeName', {
                    tips: 1,
                    time: 1500
                });
                $("#typeName").val("");
            } else {
                if (typeName != null && typeName != '') {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/bookType/bookTypeExist",
                        type: "POST",
                        data: JSON.stringify(typeName),
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            if (data.code == 0) {
                                layer.tips('图书类型名称已存在,请重新输入!', '#typeName', {
                                    tips: 1,
                                    time: 1500
                                });
                                $("#typeName").val("");
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
                url: "${pageContext.request.contextPath}/bookType/editBookType",
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