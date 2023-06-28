<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>异常还书</title>
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
    <input type="hidden" name="id" value="${borrowBook.id}"/>
    <input type="hidden" name="bookId" value="${borrowBook.bookId}"/>
    <input type="hidden" name="returnBookTime" id="returnBookTime">

    <div class="layui-form-item">
        <label class="layui-form-label required">异常类型</label>
        <div class="layui-input-block">
            <select name="returnBookType" lay-filter="currentSelectFilter" id="select" lay-verify="required"
                    lay-reqtext="异常类型不能为空">
                <option value="">请选择</option>
                <option value="1">延迟还书</option>
                <option value="2">破损还书</option>
                <option value="3">丢失图书</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label required" >异常备注</label>
        <div class="layui-input-block">
            <textarea name="remark" class="layui-textarea" maxlength="255" lay-verify="required" lay-reqtext="异常备注不能为空"
                      placeholder="请填写异常还书备注(必填)"></textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认还书</button>
        </div>
    </div>

</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'jquery'], function () {
        const form = layui.form,
            layer = layui.layer,
            $ = layui.jquery;

        function compareDate(date1, date2) {
            const oDate1 = new Date(date1);
            const oDate2 = new Date(date2);
            if (((oDate1.getTime() - oDate2.getTime()) / (1000 * 3600 * 24)) >= 1 && ((oDate1.getTime() - oDate2.getTime()) / (1000 * 3600 * 24)) <= 30) {
                return true;
            } else {
                return false;
            }
        };

        Date.prototype.format = function(fmt)
        {
            var o = {
                "M+" : this.getMonth()+1, //月份
                "d+" : this.getDate(), //日
                "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时
                "H+" : this.getHours(), //小时
                "m+" : this.getMinutes(), //分
                "s+" : this.getSeconds(), //秒
                "q+" : Math.floor((this.getMonth()+3)/3), //季度
                "S" : this.getMilliseconds() //毫秒
            };
            if(/(y+)/.test(fmt))
                fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
            for(var k in o)
                if(new RegExp("("+ k +")").test(fmt))
                    fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
            return fmt;
        }

        //监听下拉框选择
        form.on('select(currentSelectFilter)', function (data) {
            if (data.value == "1") {
                layer.prompt({
                    title: '请选择延期日期，延期日期必须不超过30天(包含30天)',
                    content: '<input type="date" class="layui-layer-input">',
                    formType: 3,
                    btn: ["确定"],
                    closeBtn: 0
                }, function (enddate, index) {
                    const nowDate = new Date().toLocaleDateString();
                    const boolean = compareDate(enddate, nowDate);
                    if (boolean === false) {
                        layer.msg("延期日期选择错误，请重新选择!", {
                            icon: 2,
                            time: 1500
                        }, function () {
                            $("#select").val("");
                        });
                    } else {
                        const time1 = new Date(enddate).format("yyyy-MM-dd HH:mm:ss");
                        $("#returnBookTime").val(time1);
                        layer.msg("读者还书后请管理员及时更新还书类型!", {
                            icon: 1,
                            time: 3000
                        });
                    }
                    layer.close(index);
                });
            } else if (data.value == "2") {
                layer.alert('请管理员检查损坏程度，如人为损坏，重度损坏等，请联系借阅人理赔，并选择归还类型为丢失图书', {
                    skin: 'layui-layer-molv',
                    closeBtn: 0,
                    time: 5 * 1000
                    , success: function (layero, index) {
                        var timeNum = this.time / 1000, setText = function (start) {
                            layer.title((start ? timeNum : --timeNum) + ' 秒后关闭', index);
                        };
                        setText(!0);
                        this.timer = setInterval(setText, 1000);
                        if (timeNum <= 0) clearInterval(this.timer);
                    }
                    , end: function () {
                        clearInterval(this.timer);
                    }
                });
            } else {
                if (data.value == "3") {
                    layer.alert('请管理员在理赔补充新书后及时更新还书类型', {
                        skin: 'layui-layer-molv',
                        closeBtn: 0,
                        time: 5 * 1000
                        , success: function (layero, index) {
                            var timeNum = this.time / 1000, setText = function (start) {
                                layer.title((start ? timeNum : --timeNum) + ' 秒后关闭', index);
                            };
                            setText(!0);
                            this.timer = setInterval(setText, 1000);
                            if (timeNum <= 0) clearInterval(this.timer);
                        }
                        , end: function () {
                            clearInterval(this.timer);
                        }
                    });
                }
            }
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            const datas = data.field;
            //向后台发送数据提交添加
            $.ajax({
                url: "${pageContext.request.contextPath}/borrowBook/abnormalBorrowBook",
                type: "POST",
                data: datas,
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('异常还书成功', {
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
            return false;
        });

    });
</script>
</body>
</html>