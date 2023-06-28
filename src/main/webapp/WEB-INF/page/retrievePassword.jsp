<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>找回密码</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/lay-module/step-lay/step.css" media="all">
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-fluid">
            <div class="layui-card">
                <div class="layui-card-body" style="padding-top: 200px;">
                    <div class="layui-carousel" id="stepForm" lay-filter="stepForm" style="margin: 0 auto;">
                        <div carousel-item>
                            <div>
                                <form class="layui-form"
                                      style="margin: 0 auto;max-width: 460px;padding-top: 40px;">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">用户名:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="username" minlength="1" maxlength="6"
                                                   lay-verify="required|user"
                                                   lay-reqtext="用户名不能为空" placeholder="请输入用户名"
                                                   class="layui-input"/>
                                            <tip>请填写自己的账号名称。</tip>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit lay-filter="formStep">
                                                &emsp;下一步&emsp;
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                <div style="text-align: center;margin-top: 50px;">
                                    <button class="layui-btn" id="loginPre">返回登录</button>
                                </div>
                            </div>
                            <div>
                                <form class="layui-form"
                                      style="margin: 0 auto;max-width: 460px;padding-top: 40px;">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">用户名:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="username" id="read" minlength="1" maxlength="6"
                                                   readonly="true" class="layui-input"/>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">手机号:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="tel" maxlength="11" lay-verify="tel"
                                                   placeholder="请输入手机号"
                                                   class="layui-input"/>
                                            <tip>请填写自己账号绑定的手机号。</tip>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">邮箱:</label>
                                        <div class="layui-input-block">
                                            <input type="text" name="email" maxlength="30" lay-verify="emails"
                                                   placeholder="请输入邮箱" class="layui-input"/>
                                            <tip>请填写自己账号绑定的邮箱。</tip>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">新密码:</label>
                                        <div class="layui-input-block">
                                            <input type="password" name="password" minlength="6" maxlength="16"
                                                   lay-verify="required|pass" lay-reqtext="密码不能为空"
                                                   placeholder="请输入密码" class="layui-input"/>
                                            <tip>请填写自己想要修改的密码。</tip>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button type="button"
                                                    class="layui-btn layui-btn-primary pre">上一步
                                            </button>
                                            <button class="layui-btn" lay-submit lay-filter="formStep2">
                                                &emsp;修改密码&emsp;
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div>
                                <div style="text-align: center;margin-top: 90px;">
                                    <i class="layui-icon layui-circle"
                                       style="color: white;font-size:30px;font-weight:bold;background: #52C41A;padding: 20px;line-height: 80px;">&#xe605;</i>
                                    <div style="font-size: 24px;color: #333;font-weight: 500;margin-top: 30px;">
                                        修改成功
                                    </div>
                                    <div style="font-size: 14px;color: #666;margin-top: 20px;">密码修改后立即生效</div>
                                </div>
                                <div style="text-align: center;margin-top: 50px;">
                                    <button class="layui-btn" id="login">返回登录</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div style="color: #666;margin-top: 30px;margin-bottom: 40px;padding-left: 30px;">
                        <h3>说明</h3><br>
                        <h4>找回密码</h4>
                        <p>找回密码需要账户绑定手机号或邮箱，如果没绑定无法找回账号，请知晓！</p>
                        <br>
                        <h4>绑定填写</h4>
                        <p>绑定邮箱就填写邮箱，绑定手机号就填写手机号，全部填写也可</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form', 'step'], function () {
        const $ = layui.$,
            form = layui.form,
            layer = layui.layer,
            step = layui.step;

        step.render({
            elem: '#stepForm',
            filter: 'stepForm',
            width: '100%', //设置容器宽度
            stepWidth: '750px',
            height: '500px',
            stepItems: [{
                title: '查询账户是否绑定'
            }, {
                title: '填写绑定信息'
            }, {
                title: '修改完成'
            }]
        });

        //跳转登录界面
        $("#loginPre").on("click", function () {
            window.location = "${pageContext.request.contextPath}/login";
        });

        //跳转登录界面
        $("#login").on("click", function () {
            window.location = "${pageContext.request.contextPath}/login";
        });

        //自定义验证规则
        form.verify({
            user: function (value) {
                if (value !== null && value !== '') {
                    if (/^[\S]{1,6}$/.test(value) === false) {
                        return "用户名必须1-6位字符，且不能出现空格";
                    }
                }
            },
            tel: function (value) {
                if (value !== null && value !== '') {
                    if (/^1\d{10}$/.test(value) === false) {
                        return "请输入正确的手机号";
                    }
                }
            },
            emails: function (value) {
                if (value !== null && value !== '') {
                    if (/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/.test(value) === false) {
                        return "邮箱格式不正确";
                    }
                }
            },
            pass: [
                /^[\S]{6,16}$/, '密码必须6-16位字符，且不能出现空格'
            ]
        });

        form.on('submit(formStep)', function (data) {
            const datas = data.field;
            const username = datas.username;
            $.ajax({
                url: "telEmailExist",
                type: "POST",
                data: JSON.stringify(username),
                contentType: "application/json;charset=utf-8",
                success: function (result) {
                    if (result.msg === '请求成功') {
                        $("#read").val(result.data);
                        step.next('#stepForm');
                    } else {
                        layer.msg(result.msg, {
                            icon: 2,
                            time: 2000
                        });
                    }
                }
            });
            return false;
        });

        form.on('submit(formStep2)', function (data) {
            const datas = data.field;
            $.ajax({
                url: "retrievePasswordUser",
                type: "POST",
                data: datas,
                success: function (data) {
                    if (data.code === 1) {
                        step.next('#stepForm');
                    } else {
                        layer.msg(data.msg, {
                            icon: 1,
                            time: 2000
                        });
                    }
                }
            });
            return false;
        });

        $('.pre').click(function () {
            step.pre('#stepForm');
        });

        $('.next').click(function () {
            step.next('#stepForm');
        });
    })
</script>
</body>
</html>

