<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>上传用户头像</title>
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

    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;"> <legend>只允许上传png|jpg格式的图片，且大小在1mb以内，头像可以多次上传，会同步更新为最新上传的头像</legend></fieldset>

    <button type="button" class="layui-btn layui-btn-danger" id="test7"><i class="layui-icon"></i>上传头像</button>

</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['upload', 'element', 'layer'], function () {
        const $ = layui.jquery
            , upload = layui.upload
            , layer = layui.layer;

        upload.render({
            elem: '#test7'
            ,url: '${pageContext.request.contextPath}/photo/upload' //此处配置你自己的上传接口即可
            ,accept: 'file' //普通文件
            ,size: 1024 //限制文件大小，单位 KB
            ,exts: 'png|jpg' //只允许上传png|jpg文件
            ,done: function(res){
                if (res.code === 1 ){
                    layer.msg('上传成功！', {
                        icon: 6,
                        time: 1500
                    }, function () {
                        parent.window.location.reload();
                        const iframeIndex = parent.layer.getFrameIndex(window.name);
                        parent.layer.close(iframeIndex);
                    });
                }else {
                    layer.msg(res.msg);
                }
            }
        });
    });
</script>
</body>
</html>