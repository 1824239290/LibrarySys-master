<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css"
          media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        .layui-card {
            border: 1px solid #f2f2f2;
            border-radius: 5px;
        }

        .icon {
            margin-right: 10px;
            color: #1aa094;
        }

        .icon-cray {
            color: #ffb800 !important;
        }

        .icon-blue {
            color: #1e9fff !important;
        }

        .icon-tip {
            color: #ff5722 !important;
        }

        .layuimini-qiuck-module {
            text-align: center;
            margin-top: 10px
        }

        .layuimini-qiuck-module a i {
            display: inline-block;
            width: 100%;
            height: 60px;
            line-height: 60px;
            text-align: center;
            border-radius: 2px;
            font-size: 30px;
            background-color: #F8F8F8;
            color: #333;
            transition: all .3s;
            -webkit-transition: all .3s;
        }

        .layuimini-qiuck-module a cite {
            position: relative;
            top: 2px;
            display: block;
            color: #666;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            font-size: 14px;
        }

        .welcome-module {
            width: 100%;
            height: 210px;
        }

        .panel {
            background-color: #fff;
            border: 1px solid transparent;
            border-radius: 3px;
            -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 1px rgba(0, 0, 0, .05)
        }

        .panel-body {
            padding: 10px
        }

        .panel-title {
            margin-top: 0;
            margin-bottom: 0;
            font-size: 12px;
            color: inherit
        }

        .label {
            display: inline;
            padding: .2em .6em .3em;
            font-size: 75%;
            font-weight: 700;
            line-height: 1;
            color: #fff;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: .25em;
            margin-top: .3em;
        }

        .layui-red {
            color: red
        }

        .main_btn > p {
            height: 40px;
        }

        .layui-bg-number {
            background-color: #F8F8F8;
        }

        .layuimini-notice:hover {
            background: #f6f6f6;
        }

        .layuimini-notice {
            padding: 7px 16px;
            clear: both;
            font-size: 12px !important;
            cursor: pointer;
            position: relative;
            transition: background 0.2s ease-in-out;
        }

        .layuimini-notice-title, .layuimini-notice-label {
            padding-right: 70px !important;
            text-overflow: ellipsis !important;
            overflow: hidden !important;
            white-space: nowrap !important;
        }

        .layuimini-notice-title {
            line-height: 28px;
            font-size: 14px;
        }

        .layuimini-notice-extra {
            position: absolute;
            top: 50%;
            margin-top: -8px;
            right: 16px;
            display: inline-block;
            height: 16px;
            color: #999;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">
        <div class="layui-row layui-col-space15">
            <div class="layui-col-md8">
                <div class="layui-row layui-col-space15">
                    <div class="layui-col-md6">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-warning icon"></i>数据统计</div>
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <div class="layui-row layui-col-space10">
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-blue">实时</span>
                                                        <h5>用户统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <small>用户总记录数：</small>
                                                        <span class="no-margins" id="user"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-cyan">实时</span>
                                                        <h5>图书统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <small>图书总记录数：</small>
                                                        <span class="no-margins" id="book"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-orange">实时</span>
                                                        <h5>分类统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <small>分类总记录数：</small>
                                                        <span class="no-margins" id="bookType"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-col-xs6">
                                            <div class="panel layui-bg-number">
                                                <div class="panel-body">
                                                    <div class="panel-title">
                                                        <span class="label pull-right layui-bg-green">实时</span>
                                                        <h5>借阅统计</h5>
                                                    </div>
                                                    <div class="panel-content">
                                                        <small>借阅总记录数：</small>
                                                        <span class="no-margins" id="borrowBook"></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-credit-card icon icon-blue"></i>快捷入口</div>
                            <div class="layui-card-body">
                                <div class="welcome-module">
                                    <div class="layui-row layui-col-space10 layuimini-qiuck">
                                        <c:choose>

                                            <c:when test="${sessionScope.type.equals('supperAdmin')}">
                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/borrowBook/borrowBookList"
                                                       data-title="借阅管理" data-icon="fa fa-window-maximize">
                                                        <i class="fa fa-window-maximize"></i>
                                                        <cite>借阅管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/book/bookList"
                                                       data-title="图书管理" data-icon="fa fa-book">
                                                        <i class="fa fa-gears"></i>
                                                        <cite>图书管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/reader/readerList"
                                                       data-title="读者管理" data-icon="fa fa-file-text">
                                                        <i class="fa fa-credit-card"></i>
                                                        <cite>读者管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/bookType/bookTypeList"
                                                       data-title="图书类型管理" data-icon="fa fa-dot-circle-o">
                                                        <i class="fa fa-file-text"></i>
                                                        <cite>图书类型管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/notice/noticeList"
                                                       data-title="公告管理" data-icon="fa fa-calendar">
                                                        <i class="fa fa-bell"></i>
                                                        <cite>公告管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/admin/adminList"
                                                       data-title="管理员管理" data-icon="fa fa-hourglass-end">
                                                        <i class="fa fa-user-circle-o"></i>
                                                        <cite>管理员管理</cite>
                                                    </a>
                                                </div>
                                            </c:when>

                                            <c:when test="${sessionScope.type.equals('admin')}">
                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}//borrowBook/borrowBookList"
                                                       data-title="借阅管理" data-icon="fa fa-window-maximize">
                                                        <i class="fa fa-window-maximize"></i>
                                                        <cite>借阅管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/book/bookList"
                                                       data-title="图书管理" data-icon="fa fa-book">
                                                        <i class="fa fa-gears"></i>
                                                        <cite>图书管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/reader/readerList"
                                                       data-title="读者管理" data-icon="fa fa-file-text">
                                                        <i class="fa fa-credit-card"></i>
                                                        <cite>读者管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/bookType/bookTypeList"
                                                       data-title="图书类型管理" data-icon="fa fa-dot-circle-o">
                                                        <i class="fa fa-file-text"></i>
                                                        <cite>图书类型管理</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/notice/noticeList"
                                                       data-title="公告管理" data-icon="fa fa-calendar">
                                                        <i class="fa fa-bell"></i>
                                                        <cite>公告管理</cite>
                                                    </a>
                                                </div>
                                            </c:when>

                                            <c:otherwise>
                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/borrowBook/readerBorrowList"
                                                       data-title="借阅图书" data-icon="fa fa-window-maximize">
                                                        <i class="fa fa-window-maximize"></i>
                                                        <cite>借阅图书</cite>
                                                    </a>
                                                </div>

                                                <div class="layui-col-xs3 layuimini-qiuck-module">
                                                    <a href="javascript:;" layuimini-content-href="${pageContext.request.contextPath}/borrowBook/readerQueryBookList
                                                       data-title="归还图书" data-icon="fa fa-gears">
                                                        <i class="fa fa-book"></i>
                                                        <cite>借阅时间线</cite>
                                                    </a>
                                                </div>

                                            </c:otherwise>

                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header"><i class="fa fa-line-chart icon"></i>报表统计</div>
                            <div class="layui-card-body">
                                <div id="echarts-records" style="width: 100%;min-height:500px"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="layui-col-md4">

                <div class="layui-card">
                    <div class="layui-card-header"><i class="fa fa-bullhorn icon icon-tip"></i>系统公告</div>
                    <div class="layui-card-body layui-text">

                        <c:forEach var="notice" items="${noticeList}">
                            <div class="layuimini-notice">
                                <div class="layuimini-notice-title">${notice.title}</div>
                                <div class="layuimini-notice-label">${notice.creator}</div>
                                <div class="layuimini-notice-extra"><fmt:formatDate value="${notice.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                <div class="layuimini-notice-content layui-hide">${notice.content}</div>
                            </div>
                        </c:forEach>

                    </div>
                </div>

                <div class="layui-card">
                    <div class="layui-card-header"><i class="fa fa-fire icon"></i>版本信息</div>
                    <div class="layui-card-body layui-text">
                        <table class="layui-table">
                            <colgroup>
                                <col width="100">
                                <col>
                            </colgroup>
                            <tbody>
                            <tr>
                                <td>项目名称</td>
                                <td>
                                    图书管理系统
                                </td>
                            </tr>
                            <tr>
                                <td>当前版本</td>
                                <td>v1.0.1</td>
                            </tr>
                            <tr>
                                <td>主要特色</td>
                                <td>零门槛 / 响应式 / 清爽 / 极简</td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="layui-card">
                    <div class="layui-card-header"><i class="fa fa-paper-plane-o icon"></i>作者心语</div>
                    <div class="layui-card-body layui-text layadmin-text">
                        <p>本管理系统基于ssm+layui实现</p>
                        <p>希望大家能喜欢这个项目</p>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab', 'echarts'], function () {
        const $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab,
            echarts = layui.echarts;

        miniTab.listen();

        /**
         * 查看公告信息
         **/
        $('body').on('click', '.layuimini-notice', function () {
            const title = $(this).children('.layuimini-notice-title').text(),
                noticeTime = $(this).children('.layuimini-notice-extra').text(),
                content = $(this).children('.layuimini-notice-content').html();
            const html = '<div style="padding:15px 20px; text-align:justify; line-height: 22px;border-bottom:1px solid #e2e2e2;background-color: #2f4056;color: #ffffff">\n' +
                '<div style="text-align: center;margin-bottom: 20px;font-weight: bold;border-bottom:1px solid #718fb5;padding-bottom: 5px"><h4 class="text-danger">' + title + '</h4></div>\n' +
                '<div style="font-size: 12px">' + content + '</div>\n' +
                '</div>\n';
            parent.layer.open({
                type: 1,
                title: '系统公告' + '<span style="float: right;right: 1px;font-size: 12px;color: #b1b3b9;margin-top: 1px">' + noticeTime + '</span>',
                area: '300px;',
                shade: 0.8,
                id: 'layuimini-notice',
                btn: ['查看', '取消'],
                btnAlign: 'c',
                moveType: 1,
                content: html,
                success: function (layero) {
                    var btn = layero.find('.layui-layer-btn');
                    btn.find('.layui-layer-btn0').attr({
                        href: 'https://www.baidu.com/',
                        target: '_blank'
                    });
                }
            });
        });

        //统计查询，刷新一次，查询一次
        $(document).ready(function(){
            $.ajax({
                url: "util/getCount",
                type: "GET",
                contentType: "application/json;charset=utf-8",
                success: function (data) {
                    $("#user").html(data.user);
                    $("#book").html(data.book);
                    $("#bookType").html(data.bookType);
                    $("#borrowBook").html(data.borrowBook);

                    const user = data.user;
                    const book = data.book;
                    const bookType = data.bookType;
                    const borrowBook = data.borrowBook;

                    /**
                     * 报表功能
                     */
                    const echartsRecords = echarts.init(document.getElementById('echarts-records'), 'walden');
                    option = {
                        title: {
                            text: '数据统计可视化展示',
                            left: 'center'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: '{a} <br/>{b} : {c} ({d}%)'
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: ['用户总计', '图书总计', '图书分类总计', '借阅记录总计']
                        },
                        series: [
                            {
                                name: '访问来源',
                                type: 'pie',
                                radius: '55%',
                                center: ['50%', '60%'],
                                data: [
                                    { value: user, name: '用户总计' },
                                    { value: book, name: '图书总计' },
                                    { value: bookType, name: '图书分类总计' },
                                    { value: borrowBook, name: '借阅记录总计' },
                                ],
                                emphasis: {
                                    itemStyle: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    };
                    echartsRecords.setOption(option);

                    // echarts 窗口缩放自适应
                    window.onresize = function () {
                        echartsRecords.resize();
                    }
                }
            });
        });

    });
</script>
</body>
</html>