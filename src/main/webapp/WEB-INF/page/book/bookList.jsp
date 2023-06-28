<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>书籍列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px" >
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">

                        <div class="layui-inline">
                            <label class="layui-form-label">图书名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="bookName" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">图书作者</label>
                            <div class="layui-input-inline">
                                <input type="text" name="author" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">书籍编号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="bookNumber" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">书籍类型</label>
                            <div class="layui-input-inline">
                                <select id="typeName" name="typeName">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn" lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>

                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

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
            url: '${pageContext.request.contextPath}/book/queryAllBook',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'bookName', minwidth: 100, title: '图书名称'},
                {field: 'author', minwidth: 100, title: '图书作者', sort: true},
                {field: 'press', minwidth: 100, title: '出版社'},
                {field: 'bookNumber', width: 120, title: '书籍编号', sort: true},
                {field: 'bookDescription', minwidth: 200, title: '书籍简介'},
                {field: 'bookLanguage', width: 120, title: '书籍语言', sort: true},
                {field: 'bookPrice', width: 120, title: '书籍价格', sort: true,templet:function (d){if (d.bookPrice != ''){return '￥'+d.bookPrice+'元'}}},
                {field: 'publicationTime', width: 140, title: '出版日期', templet: '<div>{{ layui.util.toDateString(d.publicationTime, "yyyy年MM月dd日") }}</div>'},
                {field: 'typeName', width: 140, title: '书籍类型', sort: true},
                {field: 'bookStatus',width: 120, title: '书籍状态',templet:function (d){if (d.bookStatus == 0){return '<span class="layui-badge layui-bg-green">未借出</span>'}}},
                {title: '操作', minwidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line',
        });

        //动态获取图书类型的数据，下拉菜单，跳出图书类型
        $.get("${pageContext.request.contextPath}/book/queryAllBookType",{},function (data) {
            const list = data;
            const select = document.getElementById("typeName");
            if(list!=null|| list.size()>0){
                for(const obj in list){
                    const option = document.createElement("option");
                    option.setAttribute("value",list[obj].typeName);
                    option.innerText=list[obj].typeName;
                    select.appendChild(option);
                }
            }
            form.render('select');
        },"json");

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            const datas = data.field;
            const bookName = datas.bookName;
            const author = datas.author;
            const bookNumber = datas.bookNumber;
            const typeName = datas.typeName;

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    bookName: bookName,
                    author:author,
                    bookNumber:bookNumber,
                    typeName:typeName
                }
            }, 'data');
            return false;
        });

        //监听表头添加和批量删除操作
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                const index = layer.open({
                    title: '添加图书',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/book/bookAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                const checkStatus = table.checkStatus('currentTableId');
                const data = checkStatus.data;
                if(data.length === 0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合,拼接的ids
                    const ids = getCheackId(data);
                    layer.confirm('真的要删除吗？', function (index) {
                        //调用删除功能
                        deleteBookByIds(ids,index);
                        layer.close(index);
                    });
                }
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        //获取选中记录的id信息
        function getCheackId(data){
            const arr = [];
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id);
            }
            //拼接id,变成一个字符串
            return arr.join(",");
        };

        //批量删除功能
        function deleteBookByIds(ids ,index){
            $.ajax({
                url: "${pageContext.request.contextPath}/book/deleteBook",
                type: "POST",
                data: {ids: ids},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('删除成功', {
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
        };

        //监听信息栏删除和编辑
        table.on('tool(currentTableFilter)', function (obj) {
            const data = obj.data;
            if (obj.event === 'edit') {
                const index = layer.open({
                    title: '编辑图书',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/book/bookEdit?id=' + data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的要删除吗?', function (index) {
                    deleteBookByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

    });
</script>
</body>
</html>
