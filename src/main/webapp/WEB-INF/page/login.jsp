<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>后台管理-登陆</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <style>
        .main-body {
            top: 50%;
            left: 50%;
            position: absolute;
            -webkit-transform: translate(-50%, -50%);
            -moz-transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            -o-transform: translate(-50%, -50%);
            transform: translate(-50%, -50%);
            overflow: hidden;
        }

        .login-main .login-bottom .center .item input {
            display: inline-block;
            width: 227px;
            height: 22px;
            padding: 0;
            position: absolute;
            border: 0;
            outline: 0;
            font-size: 14px;
            letter-spacing: 0;
        }

        .login-main .login-bottom .center .item .icon-1 {
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat 1px 0;
        }

        .login-main .login-bottom .center .item .icon-2 {
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat -54px 0;
        }

        .login-main .login-bottom .center .item .icon-3 {
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat -106px 0;
        }

        .login-main .login-bottom .center .item .icon-4 {
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat 0 -43px;
            position: absolute;
            right: -10px;
            cursor: pointer;
        }

        .login-main .login-bottom .center .item .icon-5 {
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat -55px -43px;
        }

        .login-main .login-bottom .center .item .icon-6 {
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat 0 -93px;
            position: absolute;
            right: -10px;
            margin-top: 8px;
            cursor: pointer;
        }

        .login-main .login-bottom .tip .icon-nocheck {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 2px;
            border: solid 1px #9abcda;
            position: relative;
            top: 2px;
            margin: 1px 8px 1px 1px;
            cursor: pointer;
        }

        .login-main .login-bottom .tip .icon-check {
            margin: 0 7px 0 0;
            width: 14px;
            height: 14px;
            border: none;
            background: url(${pageContext.request.contextPath}/images/icon-login.png) no-repeat -111px -48px;
        }

        .login-main .login-bottom .center .item .icon {
            display: inline-block;
            width: 33px;
            height: 22px;
        }

        .login-main .login-bottom .center .item {
            width: 288px;
            height: 35px;
            border-bottom: 1px solid #dae1e6;
            margin-bottom: 35px;
        }

        .login-main {
            width: 428px;
            position: relative;
            float: left;
        }

        .login-main .login-top {
            height: 117px;
            background-color: #148be4;
            border-radius: 12px 12px 0 0;
            font-family: SourceHanSansCN-Regular;
            font-size: 30px;
            font-weight: 400;
            font-stretch: normal;
            letter-spacing: 0;
            color: #fff;
            line-height: 117px;
            text-align: center;
            overflow: hidden;
            -webkit-transform: rotate(0);
            -moz-transform: rotate(0);
            -ms-transform: rotate(0);
            -o-transform: rotate(0);
            transform: rotate(0);
        }

        .login-main .login-top .bg1 {
            display: inline-block;
            width: 74px;
            height: 74px;
            background: #fff;
            opacity: .1;
            border-radius: 0 74px 0 0;
            position: absolute;
            left: 0;
            top: 43px;
        }

        .login-main .login-top .bg2 {
            display: inline-block;
            width: 94px;
            height: 94px;
            background: #fff;
            opacity: .1;
            border-radius: 50%;
            position: absolute;
            right: -16px;
            top: -16px;
        }

        .login-main .login-bottom {
            width: 428px;
            background: #fff;
            border-radius: 0 0 12px 12px;
            padding-bottom: 53px;
        }

        .login-main .login-bottom .center {
            width: 288px;
            margin: 0 auto;
            padding-top: 40px;
            padding-bottom: 15px;
            position: relative;
        }

        .login-main .login-bottom .tip {
            clear: both;
            height: 16px;
            line-height: 16px;
            width: 288px;
            margin: 0 auto;
        }

        body {
            background: url(${pageContext.request.contextPath}/images/R-C.jpg) 0% 0% / cover no-repeat;
            position: static;
            font-size: 12px;
        }

        input::-webkit-input-placeholder {
            color: #a6aebf;
        }

        input::-moz-placeholder { /* Mozilla Firefox 19+ */
            color: #a6aebf;
        }

        input:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
            color: #a6aebf;
        }

        input:-ms-input-placeholder { /* Internet Explorer 10-11 */
            color: #a6aebf;
        }

        input:-webkit-autofill { /* 取消Chrome记住密码的背景颜色 */
            -webkit-box-shadow: 0 0 0 1000px white inset !important;
        }

        html {
            height: 100%;
        }

        .login-main .login-bottom .tip {
            clear: both;
            height: 16px;
            line-height: 16px;
            width: 288px;
            margin: 0 auto;
        }

        .login-main .login-bottom .tip .login-tip {
            font-family: MicrosoftYaHei;
            font-size: 12px;
            font-weight: 400;
            font-stretch: normal;
            letter-spacing: 0;
            color: #9abcda;
            cursor: pointer;
        }

        .login-main .login-bottom .tip .forget-password {
            font-stretch: normal;
            letter-spacing: 0;
            color: #1391ff;
            text-decoration: none;
            position: absolute;
            right: 62px;
        }

        .login-main .login-bottom .login-btn {
            width: 288px;
            height: 40px;
            background-color: #1E9FFF;
            border-radius: 16px;
            margin: 24px auto 0;
            text-align: center;
            line-height: 40px;
            color: #fff;
            font-size: 14px;
            letter-spacing: 0;
            cursor: pointer;
            border: none;
        }

        .login-main .login-bottom .center .item .validateImg {
            position: absolute;
            right: 1px;
            cursor: pointer;
            height: 36px;
            border: 1px solid #e6e6e6;
        }

        .footer {
            left: 0;
            bottom: 0;
            color: #fff;
            width: 100%;
            position: absolute;
            text-align: center;
            line-height: 30px;
            padding-bottom: 10px;
            text-shadow: #000 0.1em 0.1em 0.1em;
            font-size: 14px;
        }

        .padding-5 {
            padding: 5px !important;
        }

        .footer a, .footer span {
            color: #fff;
        }

        @media screen and (max-width: 428px) {
            .login-main {
                width: 360px !important;
            }

            .login-main .login-top {
                width: 360px !important;
            }

            .login-main .login-bottom {
                width: 360px !important;
            }
        }
    </style>
</head>
<body>
<div class="main-body">
    <div class="login-main">
        <div class="login-top">
            <span>图书管理系统后台登录</span>
            <span class="bg1"></span>
            <span class="bg2"></span>
        </div>
        <form class="layui-form login-bottom">
            <div class="center">
                <div class="item">
                    <span class="icon icon-2"></span>
                    <input type="text" name="username" lay-verify="required" placeholder="请输入登录账号" minlength="1"
                           maxlength="6" lay-verify="required|user" lay-reqtext="登录账号不能为空"/>
                </div>

                <div class="item">
                    <span class="icon icon-3"></span>
                    <input type="password" name="password" minlength="6" maxlength="16" placeholder="请输入登录密码"
                           lay-verify="required|pass" lay-reqtext="密码不能为空">
                    <span class="bind-password icon icon-4"></span>
                </div>

                <div id="validatePanel" class="item" style="width: 137px;">
                    <input type="text" id="captcha" placeholder="请输入4位验证码" maxlength="4" lay-verify="required|captcha"
                           lay-reqtext="验证码不能为空">
                    <img id="code" class="validateImg" onclick="getCode()">
                </div>
            </div>
            <div class="tip">
                <span class="login-tip" id="register" style="color: #1391ff">立即注册</span>
                <span class="forget-password" id="retrievePassword" style='cursor:pointer;'>找回密码</span>
            </div>
            <div class="layui-form-item" style="text-align:center; width:100%;height:100%;margin:0px;">
                <button class="login-btn" lay-submit="" lay-filter="login">立即登录</button>
            </div>
        </form>
    </div>
</div>
<div class="footer">
    ©版权所有 2022 <span class="padding-5">|</span>
    <a target="_blank" >粤ICP备202212345678号</a>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/lib/aes.js" charset="utf-8"></script>
<script>
    getCode();

    //获取验证码
    function getCode() {
        document.getElementById("code").src = timestamp("verifyCode");
    }

    //实现刷新更换验证码
    function timestamp(url) {
        const gettime = new Date().getTime();
        if (url.indexOf("?") > -1) {
            url = url + "&timestamp=" + gettime;
        } else {
            url = url + "?timestamp=" + gettime;
        }
        return url;
    }

    layui.use(['form', 'jquery'], function () {
        const $ = layui.jquery,
            form = layui.form,
            layer = layui.layer;

        //跳转注册界面
        $("#register").on("click", function () {
            window.location = "${pageContext.request.contextPath}/register";
        });

        //跳转忘记密码页面
        $("#retrievePassword").on("click", function () {
            window.location = "${pageContext.request.contextPath}/retrievePassword";
        });

        //查询验证码是否正确
        $("#captcha").on("input propertychange", function () {
            const captcha = $("#captcha").val();
            if (captcha.length === 4) {
                $.ajax({
                    url: "codeExist",
                    type: "POST",
                    data: JSON.stringify(captcha),
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        if (data.code === 0) {
                            layer.tips('验证码错误,请重新输入!', '#captcha', {
                                tips: 1,
                                time: 1000
                            });
                            $("#captcha").val("");
                        }
                    }
                });
            }
        });

        // 登录过期的时候，跳出ifram框架
        if (top.location != self.location) {
            top.location = self.location;
        }

        $('.bind-password').on('click', function () {
            if ($(this).hasClass('icon-5')) {
                $(this).removeClass('icon-5');
                $("input[name='password']").attr('type', 'password');
            } else {
                $(this).addClass('icon-5');
                $("input[name='password']").attr('type', 'text');
            }
        });

        $('.icon-nocheck').on('click', function () {
            if ($(this).hasClass('icon-check')) {
                $(this).removeClass('icon-check');
            } else {
                $(this).addClass('icon-check');
            }
        });

        //自定义验证规则
        form.verify({
            captcha: function (value) {
                if (value.length < 4) {
                    return "请输入正确的验证码!";
                }
            },
            user: [
                /^[\S]{1,6}$/, '账号必须1-6位字符，且不能出现空格'
            ],
            pass: [
                /^[\S]{6,16}$/, '密码必须6-16位字符，且不能出现空格'
            ]
        });

        /**
         * 加密
         * @param word
         * @returns {string}
         */
        function encrypt(str){
            const key = CryptoJS.enc.Utf8.parse("1234567890123456");
            const strs = CryptoJS.enc.Utf8.parse(str);
            const encrypted = CryptoJS.AES.encrypt(strs, key, {mode: CryptoJS.mode.ECB, padding: CryptoJS.pad.Pkcs7});
            return encrypted.toString();

        }

        /**
         * 解密
         * @param word
         * @returns {string}
         */
        function decrypt(str){
            var key = CryptoJS.enc.Utf8.parse("1234567890123456");
            const strs = CryptoJS.enc.Utf8.parse(str);
            var decrypt = CryptoJS.AES.decrypt(strs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
            return CryptoJS.enc.Utf8.stringify(decrypt).toString();
        }

        // 进行登录操作
        form.on('submit(login)', function (data) {
            const datas = data.field;
            const username = encrypt(datas.username);
            const password = encrypt(datas.password);
            $.ajax({
                url: "loginTo",
                type: "POST",
                data: {username: username, password: password},
                success: function (data) {
                    if (data.code === 1) {
                        layer.msg('验证成功,即将自动跳转登录!', {
                            icon: 6,
                            time: 2000
                        }, function () {
                            window.location = "${pageContext.request.contextPath}/toIndex";
                        });
                    } else {
                        layer.msg(data.msg, function () {
                            parent.window.location.reload();
                        });
                    }
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
