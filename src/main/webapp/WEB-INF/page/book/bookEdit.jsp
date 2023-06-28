<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>添加书籍</title>
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

    <input type="hidden" name="id" value="${book.id}">

    <div class="layui-form-item">
        <label class="layui-form-label required">图书名称</label>
        <div class="layui-input-block">
            <input type="text" name="bookName" id="bookName" minlength="1" maxlength="16" lay-verify="required"
                   lay-reqtext="图书名称不能为空"
                   placeholder="图书名称1-16字符，不能有空格" class="layui-input" value="${book.bookName}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">图书作者</label>
        <div class="layui-input-block">
            <input type="text" name="author" minlength="1" maxlength="16" placeholder="1-16个字符，不能有空格"
                   class="layui-input"
                   lay-verify="required|other" lay-reqtext="图书作者不能为空" value="${book.author}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">出版社</label>
        <div class="layui-input-block">
            <input type="text" name="press" minlength="1" maxlength="16" placeholder="1-16个字符，不能有空格"
                   class="layui-input"
                   lay-verify="required|other" lay-reqtext="出版社不能为空" value="${book.press}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">书籍简介</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入书籍简介"  name="bookDescription" maxlength="255" class="layui-textarea" lay-verify="required" lay-reqtext="书籍简介不能为空">${book.bookDescription}</textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">书籍语言</label>
        <div class="layui-input-block">
            <input type="text" name="bookLanguage" minlength="1" maxlength="16" placeholder="1-16个字符，不能有空格"
                   class="layui-input"
                   lay-verify="required|other" lay-reqtext="书籍语言不能为空" value="${book.bookLanguage}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">书籍价格</label>
        <div class="layui-input-block">
            <input type="number" name="bookPrice" minlength="1" maxlength="3" placeholder="只能输入整数,最高999"
                   class="layui-input"
                   lay-verify="required" lay-reqtext="书籍价格不能为空" value="${book.bookPrice}">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label required">出版日期</label>
        <div class="layui-input-block">
            <input type="text" name="publicationTime" id="date" placeholder="请选择出版日期" class="layui-input" lay-verify="required" lay-reqtext="出版日期不能为空" value="<fmt:formatDate value="${book.publicationTime}" pattern="yyyy-MM-dd"/>">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">书籍类型</label>
        <div class="layui-input-block">
            <select id="typeName" name="typeName" lay-verify="required" lay-reqtext="书籍类型不能为空">
                <option value="${book.typeName}">请选择</option>
            </select>
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

        //墨绿主题日期选择器
        laydate.render({
            elem: '#date',
            theme: 'molv'
        });

        //动态获取图书类型的数据，下拉菜单，跳出图书类型
        $.get("${pageContext.request.contextPath}/book/queryAllBookType",{},function (data) {
            //获取图书类型的值
            const typeName = $('#typeName')[0].value;
            const list = data;
            const select = document.getElementById("typeName");
            if(list!=null|| list.size()>0){
                for(const obj in list){
                    const option = document.createElement("option");
                    option.setAttribute("value",list[obj].typeName);
                    option.innerText=list[obj].typeName;
                    select.appendChild(option);
                    //如果书籍类型和循环到的书籍类型一致，选中
                    if (list[obj].typeName==typeName){
                        option.setAttribute("selected","selected");
                        layui.form.render('select');
                    }
                }
            }
            form.render('select');
        },"json");

        //图书名是否重名
        $("#bookName").on("mouseleave", function () {
            const bookName = $("#bookName").val();
            if (/^[\S]{1,16}$/.test(bookName) == false) {
                layer.tips('图书名称1-16字符，不能有空格', '#bookName', {
                    tips: 1,
                    time: 1500
                });
                $("#bookName").val("");
            } else {
                if (bookName != null && bookName != '') {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/book/bookExist",
                        type: "POST",
                        data: JSON.stringify(bookName),
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            if (data.code == 0) {
                                layer.tips('图书名已存在,请重新输入!', '#bookName', {
                                    tips: 1,
                                    time: 1500
                                });
                                $("#bookName").val("");
                            }
                        }
                    });
                }
            }
        });

        //自定义验证规则
        form.verify({
            other: function (value) {
                if (value != null && value != '') {
                    if (/^[\S]{1,16}$/ == false) {
                        return "请输入正确的信息";
                    }
                }
            }
        });

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            const datas = data.field;
            $.ajax({
                url: "${pageContext.request.contextPath}/book/editBook",
                type: "POST",
                data: JSON.stringify(datas),
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    if (data.code == 1) {
                        layer.msg('修改成功！', {
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