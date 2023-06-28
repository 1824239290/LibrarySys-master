<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>借阅书籍</title>
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
<div class="layuimini-container">
    <div class="layuimini-main">

        <form class="layui-form" style="padding:20px;">

            <div class="layui-form-item">
                <label class="layui-form-label required" >图书列表</label>
                <div class="layui-input-inline">
                    <input type="password" placeholder="点我选择你要借阅的书籍" name="id" class="layui-input" id="borrow" lay-verify="required"
                           lay-reqtext="要借阅的书籍不能为空">
                    <tip>每次可借阅一本图书，最多借阅五本，还书后可继续借阅</tip>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label required">借书卡号</label>
                <div class="layui-input-block">
                    <input type="text" name="libraryCard" minlength="1" maxlength="6" lay-verify="required"
                           lay-reqtext="借书卡号不能为空"
                           placeholder="请输入借书卡号" class="layui-input">
                    <tip>借书卡号可以在右上角基本资料中查看</tip>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">立即借书</button>
                </div>
            </div>

        </form>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['table', 'form', 'tableSelect'], function () {
        const $ = layui.jquery,
            table = layui.table,
            form = layui.form,
            tableSelect = layui.tableSelect;

        tableSelect.render({
            elem: '#borrow',
            checkedKey: 'id',
            height:'400',
            width:'900',
            searchType: 'more',
            searchList: [
                {searchKey: 'bookName', searchPlaceholder: '搜索图书名称'},
                {searchKey: 'author', searchPlaceholder: '搜索图书作者'},
            ],
            table: {
                url: '${pageContext.request.contextPath}/book/queryAllBook',
                cols: [[
                    { type: 'radio' },
                    {field: 'bookName', width: 140, title: '图书名称'},
                    {field: 'author', width: 160, title: '图书作者', sort: true},
                    {field: 'press', width: 160, title: '出版社'},
                    {field: 'bookNumber', width: 120, title: '书籍编号', sort: true},
                    {field: 'bookDescription', width: 200, title: '书籍简介'},
                    {field: 'bookLanguage', width: 120, title: '书籍语言', sort: true},
                    {field: 'bookPrice', width: 120, title: '书籍价格', sort: true,templet:function (d){if (d.bookPrice != ''){return '￥'+d.bookPrice+'元'}}},
                    {field: 'publicationTime', width: 140, title: '出版日期', templet: '<div>{{ layui.util.toDateString(d.publicationTime, "yyyy年MM月dd日") }}</div>'},
                    {field: 'typeName', width: 140, title: '书籍类型', sort: true},
                    {field: 'bookStatus',width: 120, title: '书籍状态',templet:function (d){if (d.bookStatus == 0){return '<span class="layui-badge layui-bg-green">未借出</span>'}}},
                ]]
            },
            done: function (elem, data) {
                const NEWJSON = [];
                layui.each(data.data, function (index, item) {
                    NEWJSON.push(item.id);
                });
                elem.val(NEWJSON.join(","));
            }
        });

        // 进行借书操作
        form.on('submit(saveBtn)', function (data) {
            const datas = data.field;
            const id = datas.id;
            const libraryCard = datas.libraryCard;
            $.ajax({
                url: "${pageContext.request.contextPath}/borrowBook/borrowBookSubmit",
                type: "POST",
                data: {id: id, libraryCard: libraryCard},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('借书成功', {
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