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

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">

                        <div class="layui-inline">
                            <label class="layui-form-label">图书名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="bookName" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">借书卡号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="libraryCard" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">借阅人</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">还书类型</label>
                            <div class="layui-input-inline">
                                <select name="returnBookType">
                                    <option value="">请选择</option>
                                    <option value="0">正常还书</option>
                                    <option value="1">延迟还书</option>
                                    <option value="2">破损还书</option>
                                    <option value="3">丢失图书</option>
                                    <option value="4">在借中</option>
                                </select>
                            </div>
                        </div>

                        <div class="layui-inline">
                            <button type="submit" class="layui-btn" lay-submit lay-filter="data-search-btn"><i
                                    class="layui-icon"></i> 搜 索
                            </button>
                        </div>

                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 借书</button>
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="borrow"> 还书</button>
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="updateDelay"> 更新延迟还书
                </button>
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="updateAbnormal">
                    更新丢失图书
                </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除</button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            {{# if(d.returnBookType == "4"){ }}
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">异常还书</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            {{# }else{ }}
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            {{# } }}
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
            url: '${pageContext.request.contextPath}/borrowBook/queryAllBorrowBook',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'bookName', minwidth: 120, title: '图书名称', sort: true,templet:'<div><a href="javascript:void(0)" style="color:#00b7ee" lay-event="bookEvent">{{d.book.bookName}}</a></div>'},
                {field: 'libraryCard', minwidth: 120, title: '借书卡号', sort: true,templet:'<div>{{d.libraryCard}}</div>'},
                {field: 'libraryCard', minwidth: 120, title: '借阅人', sort: true,templet:'<div><a href="javascript:void(0)" style="color:#00b7ee" lay-event="readerEvent">{{d.user.username}}</a></div>'},
                {field: 'borrowTime', minwidth: 160, title: '借阅时间', sort: true,templet:"<div>{{layui.util.toDateString(d.borrowTime,'yyyy-MM-dd HH:mm:ss')}}</div>"},
                {field: 'returnBookTime', minwidth: 160, title: '还书时间'},
                {field: 'returnBookType', minwidth: 120, title: '还书类型', sort: true,templet:function (res) {
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
                    }},
                {title: '操作', minwidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line',
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            const datas = data.field;
            const bookName = datas.bookName;
            const libraryCard = datas.libraryCard;
            const username = datas.username;
            const returnBookType = datas.returnBookType;

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    bookName: bookName,
                    libraryCard: libraryCard,
                    username: username,
                    returnBookType: returnBookType
                }
            }, 'data');
            return false;
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        //获取选中记录的借阅记录的id信息
        function getCheckedId(data) {
            const arr = [];
            for (let i = 0; i < data.length; i++) {
                arr.push(data[i].id);
            }
            //拼接id
            return arr.join(",");
        };


        //获取选中记录的图书id的记录信息
        function getCheckedBookId(data) {
            const arr = [];
            for (let i = 0; i < data.length; i++) {
                arr.push(data[i].bookId);
            }
            //拼接id
            return arr.join(",");
        };

        //获取选中记录的还书类型的记录信息防止重复还书
        function returnBookTypeExist(data) {
            const arr = [];
            for (let i in data) {
                if (data[i].returnBookType === 0) {
                    arr.push(data[i].returnBookType);
                } else if (data[i].returnBookType === 1) {
                    arr.push(data[i].returnBookType);
                } else if (data[i].returnBookType === 2) {
                    arr.push(data[i].returnBookType);
                } else if (data[i].returnBookType === 3) {
                    arr.push(data[i].returnBookType);
                }
            }
            return arr.length;
        };

        //查询是否有在借中、延迟还书和丢失图书的记录，没有返回空，有则返回记录信息
        function typeExist(data) {
            const arr = [];
            for (let i in data) {
                if (data[i].returnBookType === 1) {
                    arr.push(data[i].returnBookType);
                } else if (data[i].returnBookType === 3) {
                    arr.push(data[i].returnBookType);
                } else if (data[i].returnBookType === 4) {
                    arr.push(data[i].returnBookType);
                }
            }
            return arr.length;
        };

        //查询是否有延迟还书的记录，没有返回空，有则返回记录信息
        function delayExist(data) {
            const arr = [];
            for (const i in data) {
                if (data[i].returnBookType === 1) {
                    arr.push(data[i].returnBookType);
                }
            }
            return arr.length;
        };

        //查询是否有丢失图书的记录，没有返回空，有则返回记录信息
        function loseExist(data) {
            const arr = [];
            for (const i in data) {
                if (data[i].returnBookType === 3) {
                    arr.push(data[i].returnBookType);
                }
            }
            return arr.length;
        };

        //借阅时间线打开内容
        function queryBookList(flag, id) {
            const index = layer.open({
                title: '借阅时间线',
                type: 2,
                shade: 0.2,
                maxmin: true,
                shadeClose: true,
                area: ['50%', '50%'],
                content: '${pageContext.request.contextPath}/borrowBook/queryBookList?id=' + id + "&flag=" + flag,
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
        }

        //批量删除功能
        function deleteBooksByIds(ids, index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/borrowBook/deleteBorrowBook",
                type: "POST",
                data: {ids: ids},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('删除成功', {
                            icon: 6,
                            time: 1500
                        }, function () {
                            parent.window.location.reload();
                            const iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                }
            });
        };

        //还书
        function borrowBooksByIds(ids, bookIds, index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/borrowBook/returnBooks",
                type: "POST",
                data: {ids: ids, bookIds: bookIds},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('还书成功', {
                            icon: 6,
                            time: 1500
                        }, function () {
                            parent.window.location.reload();
                            const iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                }
            });
        };

        //更新还书
        function updateBooksByIds(ids, bookIds, index) {
            $.ajax({
                url: "${pageContext.request.contextPath}/borrowBook/updateBooks",
                type: "POST",
                data: {ids: ids, bookIds: bookIds},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('更新还书成功', {
                            icon: 6,
                            time: 1500
                        }, function () {
                            parent.window.location.reload();
                            const iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                }
            });
        };

        //监听表头借书、还书和批量删除操作
        table.on('toolbar(currentTableFilter)', function (obj) {
            let data;
            let checkStatus;
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
            } else if (obj.event === 'borrow') {  // 监听还书操作
                checkStatus = table.checkStatus('currentTableId');
                data = checkStatus.data;
                const ids = getCheckedId(data);//借阅记录的id集合
                const bookIds = getCheckedBookId(data);//图书的id集合
                if (data.length === 0) {
                    layer.msg("请选择要归还的记录信息");
                } else if (returnBookTypeExist(data) !== 0) {
                    layer.msg("请不要重复归还图书");
                } else {
                    layer.confirm('真的要归还图书吗？', function (index) {
                        //调用还书功能
                        borrowBooksByIds(ids, bookIds, index);
                        layer.close(index);
                    });
                }
            } else if (obj.event === 'delete') {
                checkStatus = table.checkStatus('currentTableId');
                data = checkStatus.data;
                if (data.length === 0) {
                    layer.msg("请选择要删除的记录信息");
                } else if (typeExist(data) !== 0) {
                    layer.msg("在借中、延迟还书和丢失图书的记录不可删除");
                } else {
                    layer.confirm('真的要删除吗?', function (index) {
                        const ids = getCheckedId(data);//借阅记录的id集合
                        deleteBooksByIds(ids, index);
                        layer.close(index);
                    });
                }
            } else if (obj.event === 'updateDelay') {
                checkStatus = table.checkStatus('currentTableId');
                data = checkStatus.data;
                if (data.length === 0) {
                    layer.msg("请选择要操作的记录信息!");
                } else if (delayExist(data) === 0) {
                    layer.msg("请选择延迟还书的记录信息!");
                } else {
                    layer.confirm('真的要更新延迟归还的图书吗?', function (index) {
                        const ids = getCheckedId(data);//借阅记录的id集合
                        const bookIds = getCheckedBookId(data);//图书的id集合
                        updateBooksByIds(ids, bookIds, index);
                        layer.close(index);
                    });
                }
            } else if (obj.event === 'updateAbnormal') {
                checkStatus = table.checkStatus('currentTableId');
                data = checkStatus.data;
                if (data.length === 0) {
                    layer.msg("请选择要操作的记录信息!");
                } else if (loseExist(data) === 0) {
                    layer.msg("请选择丢失还书的记录信息!");
                } else {
                    layer.confirm('真的要更新归还丢失的图书吗?', function (index) {
                        const ids = getCheckedId(data);//借阅记录的id集合
                        const bookIds = getCheckedBookId(data);//图书的id集合
                        updateBooksByIds(ids, bookIds, index);
                        layer.close(index);
                    });
                }
            }
        });

        //监听信息栏删除和异常还书
        table.on('tool(currentTableFilter)', function (obj) {
            const data = obj.data;
            if (obj.event === 'edit') {
                const index = layer.open({
                    title: '异常还书',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['50%', '50%'],
                    content: '${pageContext.request.contextPath}/borrowBook/toAbnormalBorrowBook?id=' + data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                if (typeExist(data) !== 0) {
                    layer.msg("在借中、延迟还书和丢失图书的记录不可删除");
                } else {
                    layer.confirm('真的要删除吗?', function (index) {
                        deleteBooksByIds(data.id, index);
                        layer.close(index);
                    });
                }
            } else if (obj.event === 'bookEvent') {
                const bookId = data.bookId;
                queryBookList("book", bookId);
            } else {
                const readerId = data.readerId;
                queryBookList("user", readerId);
            }
        });

    });
</script>
</body>
</html>