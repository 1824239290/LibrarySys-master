<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员列表</title>
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
                            <label class="layui-form-label">管理员名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">真实姓名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="realName" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">性别</label>
                            <div class="layui-input-inline">
                                <input type="text" name="sex" autocomplete="off" class="layui-input">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <label class="layui-form-label">借书卡号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="libraryCard" autocomplete="off" class="layui-input">
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
            <a class="layui-btn layui-btn-xs layui-btn-danger data-cont-reset" lay-event="reset">重置</a>
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
            url: '${pageContext.request.contextPath}/admin/queryAllAdmin',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'username', width: 120, title: '管理员名称'},
                {field: 'realName', width: 120, title: '真实姓名', sort: true},
                {field: 'sex', width: 80, title: '性别'},
                {field: 'birthday', width: 140, title: '出生日期', templet:function (d){if (d.birthday == ''){return '暂无数据'}else{return d.birthday}}},
                {field: 'address', minwidth: 200, title: '地址',templet:function (d){if (d.address == ''){return '暂无数据'}else{return d.address}}},
                {field: 'tel', width: 120, title: '电话',templet:function (d){if (d.tel == ''){return '暂无数据'}else{return d.tel}}},
                {field: 'email', minwidth: 120, title: '邮箱',templet:function (d){if (d.email == ''){return '暂无数据'}else{return d.email}}},
                {field: 'createDate', minwidth: 120, title: '注册日期',sort: true,templet: '<div>{{ layui.util.toDateString(d.createDate, "yyyy年MM月dd日HH时mm分ss秒") }}</div>'},
                {field: 'libraryCard', width: 120, title: '借书卡号', sort: true},
                {field: 'userStatus',width: 120, title: '用户状态',templet:function (d){if (d.userStatus == 1){return '<span class="layui-badge layui-bg-green">正常</span>'}else {return '<span class="layui-badge layui-bg-red">冻结</span>'}}},
                {title: '操作', minwidth: 120, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line',
        });

        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            const datas = data.field;
            const username = datas.username;
            const realName = datas.realName;
            const sex = datas.sex;
            const libraryCard = datas.libraryCard;

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    username: username,
                    realName:realName,
                    sex:sex,
                    libraryCard:libraryCard
                }
            }, 'data');
            return false;
        });

        //监听表头添加和批量删除操作
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                const index = layer.open({
                    title: '添加管理员',
                    type: 2,
                    shade: 0.2,
                    maxmin: true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/admin/adminAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId');
                const data = checkStatus.data;
                if(data.length === 0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合,拼接的ids
                    const ids = getCheackId(data);
                    layer.confirm('真的要删除吗？', function (index) {
                        //调用删除功能
                        deleteReaderByIds(ids,index);
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
        function deleteReaderByIds(ids ,index){
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/deleteAdmin",
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

        //重置密码功能
        function updatePasswordById(id ,index){
            $.ajax({
                url: "${pageContext.request.contextPath}/admin/updatePasswordById",
                type: "POST",
                data: {id: id},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('重置成功', {
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

                var index = layer.open({
                    title: '编辑管理员',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/admin/adminEdit?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('真的要删除吗?', function (index) {
                    deleteReaderByIds(data.id,index);
                    layer.close(index);
                });
            }else if (obj.event === 'reset'){
                layer.confirm('确定要重置管理员密码为初始密码吗?', function (index) {
                    updatePasswordById(data.id,index);
                    layer.close(index);
                });
            }
        });

    });
</script>
</body>
</html>