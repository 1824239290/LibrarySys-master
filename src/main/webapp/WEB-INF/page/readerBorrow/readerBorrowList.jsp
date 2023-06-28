<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>借阅列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 借书</button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        const $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/borrowBook/readerQueryAllBorrowBook',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {
                    templet: '<div>{{d.book.bookName}}</div>',
                    minwidth: 120,
                    title: '图书名称'
                },
                {templet: '<div>{{d.libraryCard}}</div>', minwidth: 120, title: '借书卡号'},
                {
                    templet: '<div>{{d.user.username}}</div>',
                    minwidth: 120,
                    title: '借阅人'
                },
                {
                    templet: "<div>{{layui.util.toDateString(d.borrowTime,'yyyy-MM-dd HH:mm:ss')}}</div>",
                    minwidth: 160,
                    title: '借阅时间'
                },
                {field: 'returnBookTime', minwidth: 160, title: '还书时间'},
                {
                    title: "还书类型", minwidth: 120, templet: function (res) {
                        if (res.returnBookType == '0') {
                            return '<span class="layui-badge layui-bg-green">正常还书</span>'
                        } else if (res.returnBookType == '1') {
                            return '<span class="layui-badge layui-bg-black">延迟还书</span>'
                        } else if (res.returnBookType == '2') {
                            return '<span class="layui-badge layui-bg-blue">破损还书</span>'
                        } else if (res.returnBookType == '3') {
                            return '<span class="layui-badge layui-bg-yellow">丢失图书</span>'
                        } else {
                            return '<span class="layui-badge layui-bg-red">在借中</span>'
                        }
                    }
                },
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line',
        });

        //监听表头借书操作
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听借书操作
                const index = layer.open({
                    title: '借阅图书',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['75%', '75%'],
                    content: '${pageContext.request.contextPath}/borrowBook/addBorrowBook',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });

    });
</script>
</body>
</html>